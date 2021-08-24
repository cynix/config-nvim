local exec = vim.api.nvim_exec
local get_cursor = vim.api.nvim_win_get_cursor
local SymbolKind = require('vim.lsp.protocol').SymbolKind
local make_text_document_params = require('vim.lsp.util').make_text_document_params
local buf_request = require('vim.lsp').buf_request
local redraw = require('utils.redraw').redraw

local interesting_kinds = {
  Module = true,
  Namespace = true,
  Package = true,
  Class = true,
  Method = true,
  Constructor = true,
  Enum = true,
  Interface = true,
  Function = true,
  Struct = true,
  Operator = true,
}

local function in_range(pos, range)
  local line, char = pos[1], pos[2]

  if line < range.start.line or line > range['end'].line then
    return false
  end

  if
    line == range.start.line and char < range.start.character
    or line == range['end'].line and char > range['end'].character
  then
    return false
  end

  return true
end

local function callback(_, _, result, _, _)
  local b = vim.b
  b.lsp_current_function = ''

  if type(result) ~= 'table' then
    return
  end

  local pos = get_cursor(0)
  local symbols = {}

  local function maybe_add(item)
    local kind = SymbolKind[item.kind] or 'Unknown'

    if interesting_kinds[kind] then
      local range = item.location and item.location.range or item.range

      if range then
        range.start.line = range.start.line + 1
        range['end'].line = range['end'].line + 1

        if in_range(pos, range) then
          table.insert(symbols, {name=item.name, kind=kind})
        end
      end
    end

    if item.children then
      for _, child in ipairs(item.children) do
        maybe_add(child)
      end
    end
  end

  for _, item in ipairs(result) do
    maybe_add(item)
  end

  if #symbols > 0 then
    b.lsp_current_function = symbols[#symbols].name
  end

  redraw()
end

local function update()
  buf_request(0, 'textDocument/documentSymbol', {textDocument=make_text_document_params()}, callback)
end

local function on_attach(client)
  if client.resolved_capabilities.document_symbol then
    exec([[
      augroup LspCurrentFunction
        autocmd!
        autocmd CursorHold <buffer> lua require('lsp.current_function').update()
      augroup END
    ]], false)
  end
end

return {
  on_attach=on_attach,
  update=update,
}

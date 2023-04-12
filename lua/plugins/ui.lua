local api = vim.api
local cu = require('utils.color')

local function get_diagnostic_label(props)
  local icons = {
    Error = '',
    Warn = '',
    Info = '',
    Hint = '',
  }

  local label = {}

  for severity, icon in pairs(icons) do
    local n = #vim.diagnostic.get(props.buf, {severity = vim.diagnostic.severity[string.upper(severity)]})
    if n > 0 then
      table.insert(label, { icon .. ' ' .. n .. ' ', guifg=cu.hex(cu.hl('DiagnosticSign' .. severity).foreground) })
    end
  end

  return label
end

return {
  {
    'b0o/incline.nvim',
    event = 'VeryLazy',
    opts = {
      render = function(props)
        local filename = vim.fn.fnamemodify(api.nvim_buf_get_name(props.buf), ':t')
        local diagnostics = get_diagnostic_label(props)
        local modified = api.nvim_buf_get_option(props.buf, 'modified') and 'bold,italic' or 'None'
        local filetype_icon, color = require('nvim-web-devicons').get_icon_color(filename)

        local buffer = {
          { filetype_icon, guifg=color },
          { ' ' },
          { filename, gui=modified, guifg=cu.hex(cu.hl(props.focused and 'Normal' or 'Comment').foreground) },
        }

        if #diagnostics > 0 then
          table.insert(diagnostics, { '| ', guifg='grey' })
        end
        for _, buffer_ in ipairs(buffer) do
          table.insert(diagnostics, buffer_)
        end
        return diagnostics
      end,
    },
  },
  {
    'echasnovski/mini.indentscope',
    opts = function(_, opts)
      opts.draw = vim.tbl_deep_extend('force', opts or {}, {
        animation = require('mini.indentscope').gen_animation.none(),
      })
    end,
  },
  {
    'folke/noice.nvim',
    opts = {
      lsp = {
        override = {
          ['cmp.entry.get_documentation'] = true,
        },
      },
      messages = {
        view_search = false,
      },
      presets = {
        lsp_doc_border = true,
      },
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      sections = {
        lualine_z = {'fileformat', 'filetype'},
      },
    },
  },
  {
    'sitiom/nvim-numbertoggle',
    event = 'VeryLazy',
  },
}

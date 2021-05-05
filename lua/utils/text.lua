local replace_termcodes = vim.api.nvim_replace_termcodes
local nr2char = vim.fn.nr2char

local function t(code)
  return replace_termcodes(code, true, true, true)
end

local function u(code)
  if type(code) == 'string' then
    code = tonumber('0x' .. code)
  end

  return nr2char(code)
end

return {
  t=t,
  u=u,
}

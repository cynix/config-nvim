local set_keymap = vim.api.nvim_set_keymap

local function map(modes, from, to, options)
  if type(modes) == 'string' then
    modes = {modes}
  end

  options = options or {}
  if type(options) == 'string' then
    local opt = options
    options = {}
    options[opt] = true
  end

  for _, mode in ipairs(modes) do
    set_keymap(mode, from, to, options)
  end
end

return {
  map=map,
}

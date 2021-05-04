local function exists(path)
  local fn = vim.fn
  return fn.empty(fn.glob(path)) == 0
end

return {
  exists=exists,
}

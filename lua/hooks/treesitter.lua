local has = vim.fn.has

if has('mac') > 0 or has('bsd') > 0 then
  vim.cmd('TSUpdate')
end

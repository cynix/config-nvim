local lazy = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazy) then
  vim.fn.system({'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazy})
end
vim.opt.rtp:prepend(lazy)

require('lazy').setup({
  spec = {
    { 'LazyVim/LazyVim', import = 'lazyvim.plugins' },
    { import = 'lazyvim.plugins.extras.coding.copilot' },
    { import = 'lazyvim.plugins.extras.editor.aerial' },
    { import = 'plugins' },
  },
  defaults = {
    lazy = true,
    version = false,
  },
  install = { colorscheme = { 'kanagawa' } },
  checker = { enabled = true },
  ui = {
    border = 'rounded',
  },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'man',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'nvim',
        'rplugin',
        'spellfile',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})

local function load(use)
  use 'wbthomason/packer.nvim'
  use {'famiu/nvim-reload', requires={'nvim-lua/plenary.nvim'}}

  -- visual {{{
  use 'bronson/vim-crosshairs'
  use {'lukas-reineke/indent-blankline.nvim', config=[[require('config.indent-blankline')]]}
  use {'kyazdani42/nvim-web-devicons', config=[[require('config.web-devicons')]]}
  use {'ntpeters/vim-better-whitespace', config=[[require('config.better-whitespace')]]}
  -- }}}

  -- navigation {{{
  use {'derekwyatt/vim-fswitch', config=[[require('config.fswitch')]]}
  use {'haya14busa/is.vim'}
  use {
    'ibhagwan/fzf-lua',
    requires={'vijaymarupudi/nvim-fzf'},
    config=[[require('config.fzf')]],
  }
  -- }}}

  -- editing {{{
  use {'junegunn/vim-easy-align', config=[[require('config.easy-align')]]}
  use 'tpope/vim-surround'
  use {'windwp/nvim-autopairs', config=[[require('config.autopairs')]]}
  use {'b3nj5m1n/kommentary', config=[[require('config.kommentary')]]}
  use {'bmundt6/conflict-marker.vim', config=[[require('config.conflict-marker')]]}
  -- }}}

  -- yank/paste {{{
  use 'junegunn/vim-peekaboo'
  -- }}}

  -- syntax/completion {{{
  use 'ciaranm/securemodelines'

  use 'sheerun/vim-polyglot'
  use {
    'nvim-treesitter/nvim-treesitter',
    config=[[require('config.treesitter')]],
    run=[[require('hooks.treesitter')]],
  }
  use 'nvim-treesitter/playground'
  use {'romgrk/nvim-treesitter-context', config=[[require('config.treesitter-context')]]}

  use {'nvim-lua/lsp-status.nvim', config=[[require('config.lsp-status')]]}
  use {
    'neovim/nvim-lspconfig',
    requires={'p00f/clangd_extensions.nvim'},
    config=[[require('config.lspconfig')]],
  }
  use {
    'hrsh7th/nvim-cmp',
    requires={'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-nvim-lsp-signature-help', 'L3MON4D3/LuaSnip', 'onsails/lspkind-nvim', 'saadparwaiz1/cmp_luasnip'},
    config=[[require('config.cmp')]],
  }
  use {'folke/trouble.nvim', config=[[require('config.trouble')]]}
  use {'kosayoda/nvim-lightbulb', config=[[require('config.lightbulb')]]}
  use {'https://git.sr.ht/~whynothugo/lsp_lines.nvim', config=[[require('config.lsp_lines')]]}
  -- }}}

  -- status {{{
  use {'nvim-lualine/lualine.nvim', config=[[require('config.lualine')]]}
  -- }}}

  -- gutter {{{
  use 'jeffkreeftmeijer/vim-numbertoggle'
  -- }}}

  -- git {{{
  use {'lewis6991/gitsigns.nvim', requires={'nvim-lua/plenary.nvim'}, config=[[require('config.gitsigns')]]}
  -- }}}

  -- themes {{{
  use {'lifepillar/vim-gruvbox8', config=[[require('config.gruvbox8')]]}
  -- }}}
end

local function bootstrap()
  local fn = vim.fn
  local cmd = vim.api.nvim_command

  local path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  local boot = not require('utils.path').exists(path)

  if boot then
    fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', path})
  end

  cmd('packadd packer.nvim')

  vim.api.nvim_exec([[
    augroup Packer
      autocmd!
      autocmd BufWritePost ~/.config/nvim/*.lua PackerCompile
    augroup end
  ]], false)

  require('packer').startup(load)

  if boot then
    require('packer').sync()
  end
end

bootstrap()

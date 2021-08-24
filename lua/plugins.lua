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
    'nvim-telescope/telescope.nvim',
    requires={'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim'},
    config=[[require('config.telescope')]],
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

  use {'neovim/nvim-lspconfig', config=[[require('config.lspconfig')]]}
  use {'ray-x/lsp_signature.nvim', config=[[require('config.lsp_signature')]]}
  use {
    'hrsh7th/nvim-compe',
    requires={'hrsh7th/vim-vsnip', 'hrsh7th/vim-vsnip-integ'},
    config=[[require('config.compe')]],
  }
  use {'folke/lsp-trouble.nvim', config=[[require('config.lsp-trouble')]]}
  use {'kosayoda/nvim-lightbulb', config=[[require('config.lightbulb')]]}
  -- }}}

  -- status {{{
  use {'hoob3rt/lualine.nvim', config=[[require('config.lualine')]]}
  -- }}}

  -- gutter {{{
  use 'jeffkreeftmeijer/vim-numbertoggle'
  use {'lewis6991/gitsigns.nvim', requires={'nvim-lua/plenary.nvim'}, config=[[require('config.gitsigns')]]}
  -- }}}

  -- git {{{
  use {'f-person/git-blame.nvim', config=[[require('config.git-blame')]]}
  -- }}}

  -- themes {{{
  use {'lifepillar/vim-gruvbox8', config=[[require('config.gruvbox8')]]}
  -- }}}
end

local function bootstrap()
  local fn = vim.fn
  local cmd = vim.api.nvim_command

  local path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  local boot = not require('utils.fs').exists(path)

  if boot then
    fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', path})
  end

  cmd('packadd packer.nvim')

  vim.api.nvim_exec([[
    augroup Packer
      autocmd!
      autocmd BufWritePost plugins.lua PackerCompile
    augroup end
  ]], false)

  require('packer').startup(load)

  if boot then
    cmd('PackerSync')
  end
end

bootstrap()

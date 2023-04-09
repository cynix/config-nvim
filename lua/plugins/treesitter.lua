return {
  {
    'cshuaimin/ssr.nvim',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    keys = {
      { '<Leader>sR', function() require('ssr').open() end, desc='Structured Replace', mode={'n', 'x'} },
    },
    opts = {
      border = 'rounded',
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'cmake',
        'cpp',
        'dockerfile',
        'fish',
        'go',
        'gomod',
        'html',
        'java',
        'javascript',
        'json',
        'lua',
        'markdown',
        'markdown_inline',
        'python',
        'ruby',
        'scss',
        'toml',
        'yaml',
      },
      autopairs = {
        enable = true,
      },
      highlight = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
      },
      indent = {
        enable = false,
      },
      playground = {
        enable = true,
      },
    }
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = 'VeryLazy',
    opts = {
      patterns = {
        default = { 'class', 'function', 'method', 'if', 'for', 'while', 'switch', 'case' }
      },
    },
  },
}

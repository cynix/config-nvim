return {
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
      matchup = {
        enable = true,
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

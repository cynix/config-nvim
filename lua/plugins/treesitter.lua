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
    'andersevenrud/nvim_context_vt',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = 'VeryLazy',
    opts = {
      min_rows = 10,
    },
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = 'VeryLazy',
    opts = {
      max_lines = 1,
      patterns = {
        default = { 'class', 'function', 'method', 'if', 'for', 'while', 'switch', 'case' }
      },
    },
  },
}

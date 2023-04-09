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
      playground = {
        enable = true,
      },
    }
  }
}

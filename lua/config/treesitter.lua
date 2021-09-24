local cpp = require('nvim-treesitter.parsers').get_parser_configs().cpp.install_info
cpp.url = 'https://github.com/tree-sitter/tree-sitter-cpp.git'
cpp.revision = '977dc3a960da5e9a2baec95160f661092466df46'

local config = {
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

require('nvim-treesitter.configs').setup(config)

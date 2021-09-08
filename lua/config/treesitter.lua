local cpp = require('nvim-treesitter.parsers').get_parser_configs().cpp.install_info
cpp.url = 'https://github.com/cynix/tree-sitter-cpp.git'
cpp.revision = 'd18734042ab7205f8a1a612617ad4d5a713da9db'

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

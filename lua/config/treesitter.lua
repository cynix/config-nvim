local cpp = '~/src/tree-sitter/tree-sitter-cpp'
if require('utils.fs').exists(cpp) then
  require('nvim-treesitter.parsers').get_parser_configs().cpp.install_info.url = cpp
end

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

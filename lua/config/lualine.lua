local u = require('utils.text').u

local config = {
  theme = 'gruvbox',
  section_separators = {u'e0b0', u'e0b2'},
  component_separators = {u'e0b1', u'e0b3'},
  sections = {
    lualine_a = {
      'mode',
    },
    lualine_b = {
      'branch',
      'diff'
    },
    lualine_c = {
      {'filename', path=1, symbols={modified=' ' .. u'f040', readonly=' ' .. u'f023'}},
      function() return vim.b.lsp_current_function end,
    },
    lualine_x = {
      {'diagnostics', sources={'nvim_lsp'}},
      'encoding',
      'fileformat',
      'filetype'
    },
  },
}

require('lualine').setup(config)

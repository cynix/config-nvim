return {
  {
    'echasnovski/mini.indentscope',
    opts = function(_, opts)
      opts.draw = vim.tbl_deep_extend('force', opts or {}, {
        animation = require('mini.indentscope').gen_animation.none(),
      })
    end,
  },
  {
    'folke/noice.nvim',
    opts = {
      lsp = {
        override = {
          ['cmp.entry.get_documentation'] = true,
        },
      },
      presets = {
        lsp_doc_border = true,
      },
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      sections = {
        lualine_z = {'fileformat', 'filetype'},
      },
    },
  },
  {
    'sitiom/nvim-numbertoggle',
    event = 'VeryLazy',
  },
}

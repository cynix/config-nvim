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
    'lewis6991/gitsigns.nvim',
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text_pos = 'eol',
      },
      current_line_blame_formatter_opts = {
        relative_time = true,
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

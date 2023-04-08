return {
  {
    'echasnovski/mini.surround',
    opts = {
      mappings = {
        delete = 'ds',
        replace = 'cs',
      },
    },
  },
  {
    'echasnovski/mini.trailspace',
    config = function()
      vim.api.nvim_set_hl(0, 'MiniTrailspace', {fg='#870000', bg='#870000'})
      require('mini.trailspace').setup()
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    opts = function(_, opts)
      local cmp = require('cmp')

      opts.mapping['<Up>'] = cmp.mapping.select_prev_item({behavior=cmp.SelectBehavior.Insert})
      opts.mapping['<Down>'] = cmp.mapping.select_next_item({behavior=cmp.SelectBehavior.Insert})

      opts.window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      }
    end,
  },
}

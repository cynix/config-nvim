return {
  {
    'abecodes/tabout.nvim',
    dependencies = {
      'hrsh7th/nvim-cmp',
      'L3MON4D3/LuaSnip',
      'nvim-treesitter/nvim-treesitter',
    },
    event = 'InsertCharPre',
    opt = true,
    opts = {
      act_as_tab = true,
      act_as_shift_tab = true,
      completion = true,
      ignore_beginning = true,
    },
    priority = 1000,
  },
  {
    'cshuaimin/ssr.nvim',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    keys = {
      { '<Leader>sR', function() require('ssr').open() end, desc='Structured Replace', mode={'n', 'x'} },
    },
    opts = {
      border = 'rounded',
    },
  },
  {
    'echasnovski/mini.comment',
    opts = {
      mappings = {
        comment = '//',
        comment_line = '//',
      },
    },
  },
  {
    'echasnovski/mini.trailspace',
    event = 'VeryLazy',
    config = function()
      vim.api.nvim_set_hl(0, 'MiniTrailspace', {fg='#870000', bg='#870000'})
      require('mini.trailspace').setup()
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    opts = function(_, opts)
      local cmp = require('cmp')
      local mapping = cmp.mapping
      local Insert = cmp.SelectBehavior.Insert

      local luasnip = require('luasnip')

      opts.mapping['<Down>'] = mapping.select_next_item({behavior=Insert})
      opts.mapping['<C-j>' ] = mapping.select_next_item({behavior=Insert})
      opts.mapping['<Up>'  ] = mapping.select_prev_item({behavior=Insert})
      opts.mapping['<C-k>' ] = mapping.select_prev_item({behavior=Insert})

      opts.mapping['<Tab>'] = function(fallback)
        if cmp.visible() then
          cmp.confirm({behavior=Insert, select=true})
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end

      opts.mapping['<S-Tab>'] = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({behavior=Insert})
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end

      opts.window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      }
    end,
  },
  {
    'kylechui/nvim-surround',
    keys = {
      { 'ys', desc='Add surround' },
      { 'yS', desc='Add surround on new lines' },
      { 'gS', desc='Add surround on new lines', mode='x' },
      { '<C-g>s', desc='Add surround', mode='i' },
      { '<C-g>S', desc='Add surround on new lines', mode='i' },
      { 'ds', desc='Delete surround' },
      { 'cs', desc='Change surround' },
    },
    config = function()
      require('nvim-surround').setup()
    end,
  },
}

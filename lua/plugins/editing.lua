return {
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
    'echasnovski/mini.trailspace',
    config = function()
      vim.api.nvim_set_hl(0, 'MiniTrailspace', {fg='#870000', bg='#870000'})
      require('mini.trailspace').setup()
    end,
  },
  {
    'gbprod/yanky.nvim',
    dependencies = {
      'kkharji/sqlite.lua',
    },
    keys = {
      { 'y', '<Plug>(YankyYank)', desc='Yanky yank', mode={'n', 'x'} },
      { 'p', '<Plug>(YankyPutAfter)', desc='Yanky put after', mode={'n', 'x'} },
      { 'P', '<Plug>(YankyPutBefore)', desc='Yanky put before', mode={'n', 'x'} },
      { '<A-n>', '<Plug>(YankyCycleForward)', desc='Yanky cycle forward', mode={'n', 'x'} },
      { '<A-p>', '<Plug>(YankyCycleBackward)', desc='Yanky cycle backward', mode={'n', 'x'} },
    },
    opts = {
      ring = {
        storage = 'sqlite',
      },
    },
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

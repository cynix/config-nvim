return {
  {
    'abecodes/tabout.nvim',
    dependencies = {
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
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
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
  {
    'saghen/blink.cmp',
    opts = {
      completion = {
        documentation = {
          window = {
            border = 'rounded',
          },
        },
        ghost_text = {
          enabled = true,
        },
        menu = {
          border = 'rounded',
          winblend = 0,
        },
      },
      signature = {
        enabled = true,
        window = {
          border = 'rounded',
        },
      },
    },
  },
}

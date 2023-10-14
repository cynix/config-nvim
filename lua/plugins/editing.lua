local feedkeys = vim.fn.feedkeys
local replace_termcodes = vim.api.nvim_replace_termcodes
local luasnip = nil

local function tab_forward()
  if not luasnip then
    luasnip = require('luasnip')
  end

  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  else
    feedkeys(replace_termcodes('<Plug>(Tabout)', true, true, true))
  end
end

local function tab_backward()
  if not luasnip then
    luasnip = require('luasnip')
  end

  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  else
    feedkeys(replace_termcodes('<Plug>(TaboutBack)', true, true, true))
  end
end

return {
  {
    'abecodes/tabout.nvim',
    dependencies = {
      'hrsh7th/nvim-cmp',
      'L3MON4D3/LuaSnip',
      'nvim-treesitter/nvim-treesitter',
    },
    event = 'InsertEnter',
    opts = {
      act_as_tab = true,
      act_as_shift_tab = true,
      ignore_beginning = true,
      tabkey = '',
      backwards_tabkey = '',
    },
    config = function(_, opts)
      require('tabout').setup(opts)

      local map = vim.keymap.set
      map('i', '<Tab>', tab_forward)
      map('i', '<S-Tab>', tab_backward)
    end,
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

      opts.mapping['<Down>'] = mapping.select_next_item({behavior=Insert})
      opts.mapping['<C-j>' ] = mapping.select_next_item({behavior=Insert})
      opts.mapping['<Up>'  ] = mapping.select_prev_item({behavior=Insert})
      opts.mapping['<C-k>' ] = mapping.select_prev_item({behavior=Insert})

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

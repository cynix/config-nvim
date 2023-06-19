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

      opts.mapping['<Down>'] = cmp.mapping.select_next_item({behavior=cmp.SelectBehavior.Insert})
      opts.mapping['<C-j>' ] = cmp.mapping.select_next_item({behavior=cmp.SelectBehavior.Insert})
      opts.mapping['<Up>'  ] = cmp.mapping.select_prev_item({behavior=cmp.SelectBehavior.Insert})
      opts.mapping['<C-k>' ] = cmp.mapping.select_prev_item({behavior=cmp.SelectBehavior.Insert})

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

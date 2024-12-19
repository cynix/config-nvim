return {
  {
    'andymass/vim-matchup',
    event = {'BufReadPost', 'BufNewFile'},
    dependencies = 'nvim-treesitter/nvim-treesitter',
    init = function()
      vim.g.matchup_matchparen_deferred = 1
    end,
  },
  {
    'chrisgrieser/nvim-spider',
    keys = {
      { 'w', '<Cmd>lua require("spider").motion("w")<CR>', desc='Spider-w', mode={'n', 'o', 'x'} },
      { 'e', '<Cmd>lua require("spider").motion("e")<CR>', desc='Spider-e', mode={'n', 'o', 'x'} },
      { 'b', '<Cmd>lua require("spider").motion("b")<CR>', desc='Spider-b', mode={'n', 'o', 'x'} },
    },
  },
  {
    'folke/flash.nvim',
    -- do not override s
    keys = function()
      return {
        { 'S', mode={'n', 'x', 'o'}, function() require('flash').jump() end, desc='Flash' },
        { 'r', mode={'o'}, function() require('flash').remote() end, desc='Remote Flash' },
      }
    end,
    opts = {
      modes = {
        char = {
          jump_labels = true,
        },
      },
    },
  },
  {
    'kevinhwang91/nvim-hlslens',
    keys = {
      { '/' },
      { '?' },
      { 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], desc='Search forward', silent=true },
      { 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], desc='Search backward', silent=true },
      { '*', [[*<Cmd>lua require('hlslens').start()<CR>]], desc='Search for cursor word', silent=true },
    },
    opts = {
      calm_down = true,
    },
  },
  {
    'rgroli/other.nvim',
    keys = {
      { '<Leader>o', '<Cmd>Other<CR>', desc='Switch to alternate file' },
    },
    opts = {
      mappings = {
        {
          pattern = '(.*)/(.*)[.]cc$',
          target = '%1/%2.h',
        },
        {
          pattern = '(.*)/(.*)[.]h$',
          target = {'%1/%2.cc', '%1/%2.c', '%1/%2.cpp'},
        },
      },
      style = {
        border = 'rounded',
      },
    },
    config = function(_, opts)
      require('other-nvim').setup(opts)
    end,
  },
}

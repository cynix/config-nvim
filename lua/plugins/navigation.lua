return {
  {
    'andymass/vim-matchup',
    event = {'BufReadPost', 'BufNewFile'},
    dependencies = 'nvim-treesitter/nvim-treesitter',
    init = function()
      local g = vim.g
      g.matchup_matchparen_deferred = 1
      g.matchup_matchparen_offscreen = {method='popup'}
    end,
  },
  {
    'ggandor/leap.nvim',
    -- do not override s
    keys = function()
      return {
        { 'S', mode={'n', 'x', 'o'}, desc='Leap forward to' },
        { 'X', mode={'n', 'x', 'o'}, desc='Leap backward to' },
        { 'gs', mode={'n', 'x', 'o'}, desc='Leap from window' },
      }
    end,
    opts = {
      safe_labels = {'f', 'n', 'u', 't', '/', 'S', 'F', 'N', 'L', 'H', 'M', 'U', 'G', 'T', '?', 'Z'},
    },
    config = function(_, opts)
      local leap = require('leap')
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end

      local map = vim.keymap.set
      map({'n', 'x', 'o'}, 'S', '<Plug>(leap-forward-to)', {silent=true, desc='Leap forward to'})
      map({'n', 'x', 'o'}, 'X', '<Plug>(leap-backward-to)', {silent=true, desc='Leap backward to'})
      map({'n', 'x', 'o'}, 'gs', '<Plug>(leap-from-windows)', {silent=true, desc='Leap from window'})
    end,
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
    'nvim-telescope/telescope.nvim',
    dependencies = {
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        config = function()
          require('telescope').load_extension('fzf')
        end,
      },
    },
    keys = function(_, keys)
      for i, k in ipairs(keys) do
        -- Assigned to ssr.nvim
        if k[1] == '<leader>sR' or k[1] == '<Leader>sR' then
          table.remove(keys, i)
          break
        end
      end
    end,
    opts = {
      defaults = {
        layout_strategy = 'vertical',
      },
      pickers = {
        lsp_definitions = { fname_width = 100 },
        lsp_implementations = { fname_width = 100 },
        lsp_references = { fname_width = 100 },
      },
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

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
    'derekwyatt/vim-fswitch',
    event = 'BufEnter',
    keys = {
      { '<Leader>o', '<Cmd>FSHere<CR>', desc='Switch to alternate file' },
    },
    config = function()
      require('utils.autocmd').augroup('FSwitch', function(autocmd)
        autocmd('BufEnter', '*.cc', function() vim.b.fswitchdst = 'h,hh,hpp' end)
        autocmd('BufEnter', '*.h', function() vim.b.fswitchdst = 'cc,cpp,cxx,c,mm,m' end)
      end)
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
}

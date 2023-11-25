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
    'nvim-telescope/telescope.nvim',
    dependencies = {
      {
        'debugloop/telescope-undo.nvim',
      },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
        enabled = function() return vim.fn.executable('cmake') == 1 end,
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

      keys[#keys+1] = { '<Leader>uu', '<Cmd>Telescope undo<CR>', desc='Undo list' }
    end,
    opts = {
      defaults = {
        layout_strategy = 'vertical',
      },
      extensions = {
        undo = {
          layout_config = {
            horizontal = {
              preview_width = 0.75,
            },
          },
          layout_strategy = 'horizontal',
        },
      },
      pickers = {
        lsp_definitions = { fname_width = 100 },
        lsp_implementations = { fname_width = 100 },
        lsp_references = { fname_width = 100 },
      },
    },
    config = function(_, opts)
      local t = require('telescope')
      t.setup(opts)

      for k, _ in pairs(opts.extensions) do
        t.load_extension(k)
      end
    end,
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

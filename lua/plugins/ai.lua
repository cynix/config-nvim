return {
  {
    'nvim-mini/mini.diff',
    config = function()
      local diff = require('mini.diff')
      diff.setup({
        source = diff.gen_source.none(),
      })
    end,
  },
  {
    'OXY2DEV/markview.nvim',
    ft = { 'markdown', 'codecompanion' },
    opts = {
      preview = {
        filetypes = { 'markdown', 'codecompanion' },
        ignore_buftypes = {},
      },
    },
  },
  {
    'olimorris/codecompanion.nvim',
    enabled = vim.g.ai_cmp,
    keys = {
      { '<Leader>a', '<cmd>CodeCompanionChat Toggle<CR>', desc='CodeCompanion Chat', mode={'n'} },
      { '<Leader>a', '<cmd>CodeCompanionChat Add<CR>', desc='CodeCompanion Chat', mode={'v'} },
      { '<Leader>i', ':CodeCompanion #{buffer} #{lsp} ', desc='CodeCompanion Inline', mode={'v'} },
    },
    opts = {
      adapters = {
        opts = {
          proxy = vim.g.copilot_proxy,
        },
      },
      strategies = {
        chat = {
          adapter = {
            name = 'copilot',
            model = 'claude-sonnet-4.5',
          },
        },
        inline = {
          adapter = {
            name = 'copilot',
            model = 'claude-sonnet-4.5',
          },
          keymaps = {
            accept_change = {
              modes = { n = 'y' },
            },
            reject_change = {
              modes = { n = 'n' },
            },
          },
        },
      },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    init = function()
      require('plugins.ai.notification').init()
    end,
  },
}

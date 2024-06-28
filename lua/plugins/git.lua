return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text_pos = 'eol',
      },
      signs = {
        delete = { text = '_' },
        topdelete = { text = '‾' },
      }
    },
  },
  {
    'sindrets/diffview.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    keys = {
      { '<Leader>gd', function()
          local d = require('diffview')
          if require('diffview.lib').get_current_view() then
            d.close()
          else
            vim.cmd('DiffviewOpen')
          end
        end, desc='DiffView' },
      { ']x', desc='Next conflict' },
      { '[x', desc='Previous conflict' },
      { '<Leader>co', desc='Choose Ours' },
      { '<Leader>cO', desc='Choose Ours for all' },
      { '<Leader>ct', desc='Choose Theirs' },
      { '<Leader>cT', desc='Choose Theirs for all' },
      { '<Leader>cb', desc='Choose Base' },
      { '<Leader>cB', desc='Choose Base for all' },
      { '<Leader>ca', desc='Choose All' },
      { '<Leader>cA', desc='Choose All for all' },
      { 'dx', desc='Delete conflict' },
      { 'dX', desc='Delete all conflicts' },
    },
    opts = {
      enhanced_diff_hl = true,
      view = {
        merge_tool = {
          layout = 'diff4_mixed',
        },
      },
    },
  },
}

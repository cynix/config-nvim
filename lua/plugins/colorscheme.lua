local api = vim.api

return {
  {
    'LazyVim/LazyVim',
    dependencies = {
      {
        'rebelot/kanagawa.nvim',
        opts = {
          dimInactive = true,
        },
      },
    },
    opts = {
      colorscheme = 'kanagawa',
    },
  },
  {
    'levouh/tint.nvim',
    event = 'VeryLazy',
    opts = {
      tint = -20,
      saturation = 0.5,
      highlight_ignore_patterns = {'WinSeparator', 'Status.*'},
      window_ignore_function = function(winid)
        local floating = api.nvim_win_get_config(winid).relative ~= ''
        local buftype = api.nvim_buf_get_option(api.nvim_win_get_buf(winid), 'buftype')
        return floating or buftype == 'terminal'
      end,
    },
  },
}

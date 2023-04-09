local api = vim.api

return {
  {
    'LazyVim/LazyVim',
    dependencies = {
      {
        'luisiacc/gruvbox-baby',
        config = function()
          require('utils.autocmd').augroup('CustomHighlights', function(autocmd)
            autocmd('ColorScheme', '*', function()
              local c = require('gruvbox-baby.colors').config()
              local hl = api.nvim_set_hl

              hl(0, 'NonText', {fg=c.medium_gray})

              hl(0, 'LspReferenceText', {fg='#fbf1c7', bg='#005f87'})
              hl(0, 'LspReferenceRead', {link='LspReferenceText'})
              hl(0, 'LspReferenceWrite', {link='LspReferenceText'})

              hl(0, 'LspCodeLens', {fg=api.nvim_get_hl_by_name('Comment', true).foreground})

              hl(0, 'IlluminatedWordText', {link='LspReferenceText'})
              hl(0, 'IlluminatedWordRead', {link='LspReferenceText'})
              hl(0, 'IlluminatedWordWrite', {link='LspReferenceText'})
            end)
          end)
        end,
      },
    },
    opts = {
      colorscheme = 'gruvbox-baby',
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

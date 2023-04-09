return {
  {
    'LazyVim/LazyVim',
    dependencies = {
      {
        'luisiacc/gruvbox-baby',
        config = function()
          require('utils.autocmd').augroup('CustomHighlights', function(autocmd)
            autocmd('ColorScheme', '*', function()
              local hl = vim.api.nvim_set_hl

              hl(0, 'LspReferenceText', {fg='#fbf1c7', bg='#005f87'})
              hl(0, 'LspReferenceRead', {link='LspReferenceText'})
              hl(0, 'LspReferenceWrite', {link='LspReferenceText'})

              hl(0, 'LspCodeLens', {fg=vim.api.nvim_get_hl_by_name('Comment', true).foreground})

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
}

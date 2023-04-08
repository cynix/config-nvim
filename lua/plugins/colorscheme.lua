return {
  {
    'LazyVim/LazyVim',
    dependencies = {
      {
        'luisiacc/gruvbox-baby',
        config = function()
          local hl = vim.api.nvim_set_hl
          hl(0, 'LspReferenceText', {fg='#fbf1c7', bg='#005f87'})
          hl(0, 'LspReferenceRead', {link='LspReferenceText'})
          hl(0, 'LspReferenceWrite', {link='LspReferenceText'})

          vim.api.nvim_create_autocmd('ColorScheme', {
            group = vim.api.nvim_create_augroup('IlluminatedHighlights', {clear=true}),
            pattern = '*',
            callback = function()
              hl(0, 'IlluminatedWordText', {link='LspReferenceText'})
              hl(0, 'IlluminatedWordRead', {link='LspReferenceText'})
              hl(0, 'IlluminatedWordWrite', {link='LspReferenceText'})
            end,
          })
        end,
      },
    },
    opts = {
      colorscheme = 'gruvbox-baby',
    },
  },
}

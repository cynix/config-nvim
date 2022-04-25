require('gitsigns').setup({
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text_pos = 'eol',
  },
  current_line_blame_formatter_opts = {
    relative_time = true,
  },
})

require('utils.highlight').hl({'GitSignsCurrentLineBlame', fg='#796a5b'})

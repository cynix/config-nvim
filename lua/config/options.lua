local g = vim.g
local o = vim.opt

g.autoformat = false

o.clipboard = ''

-- display {{{
o.textwidth = 120
o.colorcolumn = '+1'

o.listchars = {eol='↩', tab='‣ ', nbsp='␣', precedes='«', extends='»'}
o.list = true

o.cursorline = true
o.cursorcolumn = true

o.scrolloff = 5
o.sidescrolloff = 5
o.scrolljump = 5
o.sidescroll = 5
o.startofline = false

o.foldmethod = 'marker'
-- }}}

-- formatting {{{
o.formatoptions = 'ro/qnlmB1j'
-- }}}

-- searching/replacing {{{
o.hlsearch = true
o.ignorecase = true
o.smartcase = true
o.gdefault = true
-- }}}

-- completion {{{
o.wildignore = {'.git', '*.pyc', '*.gz', '*.bz2', '*.lz4', '*.pcap', '*.bin'}
-- }}}

pcall(require, 'config.local.options')

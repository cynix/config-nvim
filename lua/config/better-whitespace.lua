local g = vim.g
g.better_whitespace_filetypes_blacklist = {'diff', 'gitcommit', 'help', 'LspTrouble', 'markdown', 'packer', 'qf'}
g.show_spaces_that_precede_tabs = 1

require('utils.highlight').hl({'ExtraWhitespace', fg='#870000'})

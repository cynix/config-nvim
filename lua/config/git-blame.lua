local u = require('utils.text').u

vim.g.gitblame_message_template = '    ' .. u('f1d2') .. u('2009') .. ' <author> (<date>) ' .. u('2022') .. ' <summary>'
vim.g.gitblame_date_format = '%r'

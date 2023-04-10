vim.env.CC = 'clang'
vim.env.CXX = 'clang++'

require('config.cleanup')
require('config.lazy')
pcall(require, 'config.local')

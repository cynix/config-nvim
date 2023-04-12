local augroup = require('utils.autocmd').augroup
local o = vim.opt_local

augroup('LocalKeys', function(autocmd)
  local whichkey = require('which-key').register

  autocmd('FileType', 'help', function()
    whichkey({
      ['<CR>'] = { '<C-]>', 'Go to keyword', buffer=vim.api.nvim_get_current_buf() },
    })
  end)
end)

augroup('LocalTabWidth', function(autocmd)
  autocmd('FileType', 'make', function()
    o.tabstop = 8
    o.shiftwidth = 8
    o.expandtab = false
  end)

  autocmd('FileType', 'cmake', function()
    o.tabstop = 4
    o.shiftwidth = 4
    o.expandtab = true
  end)

  autocmd('FileType', {'html', 'xhtml', 'xml', 'xsd'}, function()
    o.tabstop = 2
    o.shiftwidth = 2
    o.expandtab = true
    o.matchpairs:append('<:>')
  end)

  autocmd('FileType', {'lua', 'ruby', 'yaml'}, function()
    o.tabstop = 2
    o.shiftwidth = 2
    o.expandtab = true
  end)

  autocmd('FileType', 'python', function()
    o.tabstop = 4
    o.shiftwidth = 4
    o.expandtab = true
  end)

  autocmd('FileType', 'go', function()
    o.tabstop = 4
    o.shiftwidth = 4
    o.expandtab = false
  end)
end)

augroup('LocalColorColumn', function(autocmd)
  autocmd('FileType', {'Trouble'}, function()
    vim.opt_local.colorcolumn = nil
  end)
end)

augroup('CrossHairs', function(autocmd)
  autocmd({'VimEnter', 'WinEnter', 'BufEnter'}, '*', function()
    o.cursorline = true
    o.cursorcolumn = true
  end)

  autocmd('WinLeave', '*', function()
    o.cursorline = false
    o.cursorcolumn = false
  end)
end)

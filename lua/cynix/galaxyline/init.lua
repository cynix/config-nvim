local gl = require('galaxyline')
local ts = require('nvim-treesitter')

local colors = {
  bg              = '#000000',

  giticon         = '#FF8800',
  gitbg           = '#5C2C2E',
  gittext         = '#C5C5C5',

  diagerror       = '#F44747',
  diagwarn        = '#FF8800',
  diaghint        = '#4FC1FF',
  diaginfo        = '#FFCC66',

  lspicon         = '#68AF00',
  lspbg           = '#304B2E',
  lsptext         = '#C5C5C5',

  typeicon        = '#FF8800',
  typebg          = '#5C2C2E',
  typetext        = '#C5C5C5',

  statsicon       = '#9CDCFE',
  statsbg         = '#5080A0',
  statstext       = '#000000',

  lineokfg        = '#000000',
  lineokbg        = '#5080A0',
  linelongfg      = '#990000',
  linelongwarnfg  = '#664400',
  linelongbg      = '#5080A0',

  shortbg         = '#DCDCAA',
  shorttext       = '#000000',

  shortrightbg    = '#3F3F3F',
  shortrighttext  = '#7C4C4E',

  red             = '#D16969',
  yellow          = '#DCDCAA',
  magenta         = '#D16D9E',
  green           = '#608B4E',
  orange          = '#FF8800',
  purple          = '#C586C0',
  blue            = '#569CD6',
  cyan            = '#4EC9B0',
}

local width_warn = 80
local width_error = 120
local pill_left = ''
local pill_right = ''

gl.short_line_list = {'NvimTree', 'vista', 'dbui', 'packer', 'tagbar'}

local gls = gl.section
local condition = require('galaxyline.condition')

local i = 1

gls.left = {
  {
    ViModePadding = {
      provider = function() return ' ' end,
      highlight = {colors.giticon, colors.bg},
    }
  },
  {
    ViMode = {
      provider = function()
        local mode_color = {
          n = colors.blue,
          i = colors.red,
          v = colors.purple,
          [''] = colors.purple,
          V = colors.purple,
          c = colors.magenta,
          no = colors.blue,
          s = colors.orange,
          S = colors.orange,
          [''] = colors.orange,
          ic = colors.yellow,
          R = colors.red,
          Rv = colors.red,
          cv = colors.blue,
          ce = colors.blue,
          r = colors.cyan,
          rm = colors.cyan,
          ['r?'] = colors.cyan,
          ['!'] = colors.blue,
          t = colors.blue
        }
        vim.api.nvim_command('hi GalaxyViMode guifg=' .. mode_color[vim.fn.mode()])
        return vim.fn.mode()
      end,
      highlight = {colors.red, colors.bg},
      separator = ' ',
      separator_highlight = {colors.red, colors.bg},
    }
  },

  {
    GitStart = {
      provider = function() return pill_left end,
      condition = condition.check_git_workspace,
      highlight = {colors.giticon, colors.bg},
    }
  },
  {
    GitIcon = {
      provider = function() return ' ' end,
      condition = condition.check_git_workspace,
      highlight = {colors.gitbg, colors.giticon},
      separator = '',
      separator_highlight = {'NONE', colors.giticon},
    }
  },
  {
    GitMid = {
      provider = function() return pill_right .. ' ' end,
      condition = condition.check_git_workspace,
      highlight = {colors.giticon, colors.gitbg},
    }
  },
  {
    GitBranch = {
      provider = 'GitBranch',
      condition = condition.check_git_workspace,
      highlight = {colors.gittext, colors.gitbg},
      separator = ' ',
      separator_highlight = {'NONE', colors.gitbg},
    }
  },
  {
    DiffAdd = {
      provider = 'DiffAdd',
      condition = condition.check_git_workspace,
      icon = '  ',
      -- icon = '  ',
      highlight = {colors.green, colors.gitbg},
    },
    DiffModified = {
      provider = 'DiffModified',
      condition = condition.check_git_workspace,
      icon = '  ',
      -- icon = ' 柳',
      highlight = {colors.blue, colors.gitbg},
    },
    DiffRemove = {
      provider = 'DiffRemove',
      condition = condition.check_git_workspace,
      icon = '  ',
      -- icon = '  ',
      highlight = {colors.red, colors.gitbg},
    },
  },
  {
    GitEnd = {
      provider = function() return pill_right end,
      condition = condition.check_git_workspace,
      highlight = {colors.gitbg, colors.bg},
      separator = ' ',
      separator_highlight = {colors.gitbg, colors.bg},
    }
  },

  {
    LspStart = {
      provider = function() return pill_left end,
      --condition = condition.check_active_lsp,
      highlight = {colors.lspicon, colors.bg},
    }
  },
  {
    LspIcon = {
      provider = function() return ' ' end,
      --condition = condition.check_active_lsp,
      highlight = {colors.lspbg, colors.lspicon},
    }
  },
  {
    LspMid = {
      provider = function() return pill_right .. ' ' end,
      --condition = condition.check_active_lsp,
      highlight = {colors.lspicon, colors.lspbg}
    }
  },
  {
    FunctionName = {
      provider = function() return ts.statusline() end,
      --condition = condition.check_active_lsp,
      highlight = {colors.textbg, colors.lspbg},
    }
  },
  {
    LspSpace = {
      provider = function() return ' ' end,
      --condition = condition.check_active_lsp,
      highlight = {colors.lspicon, colors.lspbg},
    }
  },
  {
    DiagnosticError = {
      provider = 'DiagnosticError',
      --condition = condition.check_active_lsp,
      icon = '  ',
      highlight = {colors.diagerror, colors.lspbg},
      separator_highlight = {colors.gitbg, colors.bg},
    }
  },
  {
    DiagnosticWarn = {
      provider = 'DiagnosticWarn',
      --condition = condition.check_active_lsp,
      icon = '  ',
      highlight = {colors.diagwarn, colors.lspbg},
    }
  },
  {
    DiagnosticHint = {
      provider = 'DiagnosticHint',
      --condition = condition.check_active_lsp,
      icon = '  ',
      highlight = {colors.diaghint, colors.lspbg},
    }
  },
  {
    DiagnosticInfo = {
      provider = 'DiagnosticInfo',
      --condition = condition.check_active_lsp,
      icon = '  ',
      highlight = {colors.diaginfo, colors.lspbg},
    }
  },
  {
    LspEnd = {
      provider = function() return pill_right .. " " end,
      --condition = condition.check_active_lsp,
      highlight = {colors.lspbg, colors.bg},
    }
  },

  {
    FileStart = {
      provider = function() return pill_left end,
      highlight = {colors.typeicon, colors.bg},
    }
  },
  {
    FileIcon = {
      provider = 'FileIcon',
      highlight = {colors.typebg, colors.typeicon},
    }
  },
  {
    FileMid = {
      provider = function() return pill_right .. ' ' end,
      highlight = {colors.typeicon, colors.typebg},
    }
  },
  {
    FileName = {
      provider = 'FileName',
      highlight = {colors.typetext, colors.typebg},
      separator_highlight = {'NONE', colors.typebg},
    }
  },
  {
    FileEnd = {
      provider = function() return pill_right .. ' ' end,
      highlight = {colors.typebg, colors.bg},
    },
  },
}

gls.right = {
  {
    TypeStart = {
      provider = function() return pill_left end,
      highlight = {colors.typebg, colors.bg},
    }
  },
  {
    FileSize = {
      provider = 'FileSize',
      separator = ' ',
      highlight = {colors.typetext, colors.typebg},
      separator_highlight = {colors.typeicon, colors.typebg},
    }
  },
  {
    FileFormat = {
      provider = 'FileFormat',
      separator = ' ⏎ ',
      highlight = {colors.typetext, colors.typebg},
      separator_highlight = {colors.typeicon, colors.typebg},
    }
  },
  {
    FileEncode = {
      provider = 'FileEncode',
      separator = ' ',
      highlight = {colors.typetext, colors.typebg},
      separator_highlight = {colors.typeicon, colors.typebg},
    }
  },
  {
    TypeEnd = {
      provider = function() return pill_right .. ' ' end,
      highlight = {colors.typebg, colors.bg},
    },
  },

  {
    StatsStart = {
      provider = function() return pill_left end,
      highlight = {colors.statsicon, colors.bg},
    }
  },
  {
    StatsIcon = {
      provider = function() return '⅑' end,
      highlight = {colors.statsbg, colors.statsicon},
    }
  },
  {
    StatsMid = {
      provider = function() return pill_right .. ' ' end,
      highlight = {colors.statsicon, colors.statsbg},
    }
  },
  {
    Percent = {
      provider = 'LinePercent',
      highlight = {colors.statstext, colors.statsbg},
    }
  },
  {
    VPos = {
      provider = function() return vim.fn.line('.') .. '/' .. vim.fn.line('$') .. ' ' end,
      highlight = {colors.statstext, colors.statsbg},
      separator = '⇕ ',
      separator_highlight = {colors.statsicon, colors.statsbg},
    }
  },
  {
    LinePos = {
      provider = function()
        if (vim.fn.col('.') > width_warn) then
          if (vim.fn.col('.') > width_error) then
            vim.cmd('highlight LinePosHighlight guifg=' .. colors.linelongfg .. ' guibg=' .. colors.linelongbg)
          else
            vim.cmd('highlight LinePosHighlight guifg=' .. colors.linelongwarnfg .. ' guibg=' .. colors.linelongbg)
          end
        else
          vim.cmd('highlight LinePosHighlight guifg=' .. colors.lineokfg .. ' guibg=' .. colors.lineokbg)
        end
        return vim.fn.col('.')
      end,
      highlight = 'LinePosHighlight',
      separator = '⇔ ',
      separator_highlight = {colors.statsicon, colors.statsbg},
    }
  },
  {
    LineLen = {
      provider = function()
        if (vim.fn.strwidth(vim.fn.getline('.')) > width_warn) then
          if (vim.fn.strwidth(vim.fn.getline('.')) > width_error) then
            vim.cmd('highlight LineLenHighlight guifg=' .. colors.linelongfg .. ' guibg=' .. colors.linelongbg)
          else
            vim.cmd('highlight LineLenHighlight guifg=' .. colors.linelongwarnfg .. ' guibg=' .. colors.linelongbg)
          end
        else
          vim.cmd('highlight LineLenHighlight guifg=' .. colors.lineokfg .. ' guibg=' .. colors.lineokbg)
        end
        return '/' .. vim.fn.strwidth(vim.fn.getline('.')) .. ' '
      end,
      highlight = 'LineLenHighlight',
    }
  },
  {
    TabStop = {
      provider = function() return vim.api.nvim_buf_get_option(0, 'shiftwidth') end,
      condition = condition.hide_in_width,
      highlight = {colors.statstext, colors.statsbg},
      separator = ' ',
      separator_highlight = {colors.statsicon, colors.statsbg},
    }
  },
  {
    StatsEnd = {
      provider = function() return pill_right .. ' ' end,
      highlight = {colors.statsbg, colors.bg},
    }
  },
}

gls.short_line_left = {
  {
    ShortStart = {
      provider = function() return pill_left end,
      highlight = {colors.shortbg, colors.bg},
    }
  },
  {
    ShortSpace = {
      provider = function() return ' ' end,
      highlight = {colors.shorttext, colors.shortbg},
    }
  },
  {
    ShortFileIcon = {
      provider = 'FileIcon',
      highlight = {colors.shorttext, colors.shortbg},
    }
  },
  {
    ShortMid = {
      provider = function() return ' ' end,
      highlight = {colors.shortbg, colors.shortbg},
    }
  },
  {
    ShortFileName = {
      provider = 'SFileName',
      condition = condition.buffer_not_empty,
      highlight = {colors.shorttext, colors.shortbg},
      separator_highlight = {colors.shorttext, colors.shortbg},
    }
  },
  {
    ShortEnd = {
      provider = function() return pill_right end,
      highlight = {colors.shortbg, colors.bg},
    }
  },
}

gls.short_line_right = {
  {
    BufferIcon = {
      provider = 'BufferIcon',
      highlight = {colors.shortrighttext, colors.bg},
      separator_highlight = {colors.shorttext, colors.bg},
    }
  },
}

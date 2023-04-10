local api = vim.api

local function get_diagnostic_label(props)
  local icons = {
    Error = '',
    Warn = '',
    Info = '',
    Hint = '',
  }

  local label = {}

  for severity, icon in pairs(icons) do
    local n = #vim.diagnostic.get(props.buf, {severity = vim.diagnostic.severity[string.upper(severity)]})
    if n > 0 then
      table.insert(label, {icon .. ' ' .. n .. ' ', guifg=vim.api.nvim_get_hl_by_name('DiagnosticSign' .. severity, true).foreground})
    end
  end

  return label
end

return {
  {
    'b0o/incline.nvim',
    dependencies = 'luisiacc/gruvbox-baby',
    event = 'VeryLazy',
    opts = {
      render = function(props)
        local filename = vim.fn.fnamemodify(api.nvim_buf_get_name(props.buf), ':t')
        local diagnostics = get_diagnostic_label(props)
        local modified = api.nvim_buf_get_option(props.buf, 'modified') and 'bold,italic' or 'None'
        local filetype_icon, color = require('nvim-web-devicons').get_icon_color(filename)
        local colors = require('gruvbox-baby.colors').config()

        local buffer = {
          { filetype_icon, guifg=color },
          { ' ' },
          { filename, gui=modified, guifg=(props.focused and colors.foreground or colors.comment) },
        }

        if #diagnostics > 0 then
          table.insert(diagnostics, { '| ', guifg='grey' })
        end
        for _, buffer_ in ipairs(buffer) do
          table.insert(diagnostics, buffer_)
        end
        return diagnostics
      end,
    },
  },
  {
    'echasnovski/mini.indentscope',
    opts = function(_, opts)
      opts.draw = vim.tbl_deep_extend('force', opts or {}, {
        animation = require('mini.indentscope').gen_animation.none(),
      })
    end,
  },
  {
    'folke/noice.nvim',
    opts = {
      lsp = {
        override = {
          ['cmp.entry.get_documentation'] = true,
        },
      },
      presets = {
        lsp_doc_border = true,
      },
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text_pos = 'eol',
      },
      current_line_blame_formatter_opts = {
        relative_time = true,
      },
      signs = {
        delete = { text = '_' },
        topdelete = { text = '‾' },
      }
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      sections = {
        lualine_z = {'fileformat', 'filetype'},
      },
    },
  },
  {
    'sitiom/nvim-numbertoggle',
    event = 'VeryLazy',
  },
}

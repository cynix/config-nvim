local api = vim.api
local cu = require('utils.color')

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
      table.insert(label, { icon .. ' ' .. n .. ' ', guifg=cu.hex(cu.hl('DiagnosticSign' .. severity).foreground) })
    end
  end

  return label
end

return {
  {
    'b0o/incline.nvim',
    event = 'VeryLazy',
    opts = {
      hide = {
        cursorline = true,
      },
      render = function(props)
        local filename = vim.fn.fnamemodify(api.nvim_buf_get_name(props.buf), ':t')
        local diagnostics = get_diagnostic_label(props)
        local modified = api.nvim_buf_get_option(props.buf, 'modified') and 'bold,italic' or 'None'
        local filetype_icon, color = require('nvim-web-devicons').get_icon_color(filename)

        local buffer = {
          { filetype_icon, guifg=color },
          { ' ' },
          { filename, gui=modified, guifg=cu.hex(cu.hl(props.focused and 'Normal' or 'Comment').foreground) },
        }

        if #diagnostics > 0 then
          table.insert(diagnostics, { '| ', guifg='grey' })
        end
        for _, buffer_ in ipairs(buffer) do
          table.insert(diagnostics, buffer_)
        end
        return diagnostics
      end,
      window = {
        margin = {
          vertical = 0,
        },
      },
    },
  },
  {
    'brenoprata10/nvim-highlight-colors',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'folke/noice.nvim',
    opts = {
      lsp = {
        signature = {
          enabled = false,
        },
      },
      messages = {
        view_search = false,
      },
      presets = {
        lsp_doc_border = true,
      },
    },
  },
  {
    'folke/snacks.nvim',
    opts = {
      dashboard = {
        enabled = false,
      },
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
    'petertriho/nvim-scrollbar',
    event = 'VeryLazy',
    opts = {
      show_in_active_only = true,
      handlers = {
        gitsigns = true,
        search = true,
      },
    },
  },
  {
    'sitiom/nvim-numbertoggle',
    event = 'VeryLazy',
  },
}

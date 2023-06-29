local inlay_hints = vim.version().prerelease and {} or {
  'cynix/inlay-hints.nvim',
  branch = 'dev',
  opts = {
    eol = {
      priority = 1,
      parameter = {
        format = function(hints)
          return string.format(' <- (%s)', string.gsub(hints, ':%s*$', ''))
        end,
      },
      type = {
        format = function(hints)
          return string.format(' => %s', string.gsub(hints, '^%s*:%s*', ''))
        end,
      },
    },
  },
  config = function(_, opts)
    local inlay = require('inlay-hints')
    inlay.setup(opts)
    require('lazyvim.util').on_attach(inlay.on_attach)
  end,
}

return {
  {
    'folke/trouble.nvim',
    keys = {
      {'<F1>', '<Cmd>TroubleToggle workspace_diagnostics<CR>', desc='Workspace Diagnostics'},
    },
    opts = {
      auto_close = true,
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'p00f/clangd_extensions.nvim',
        config = false,
      },
      inlay_hints,
    },
    ft = {'c', 'cpp', 'go', 'gomod', 'json', 'jsonc', 'lua', 'python'},
    opts = {
      autoformat = false,
      inlay_hints = { enabled = true },
      servers = {
        clangd = {
          cmd = {
            'clangd',
            '--background-index',
            '--completion-style=bundled',
            '--function-arg-placeholders',
            '--header-insertion=iwyu',
            '--header-insertion-decorators',
            '--log=error',
            '--offset-encoding=utf-16',
          },
          mason = false,
        },
        gopls = {
          cmd = { 'gopls', 'serve' },
          settings = {
            gopls = {
              usePlaceholders = true,
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
            },
          },
        },
        pyright = {
          before_init = function(_, config)
            local fn = vim.fn
            local executable = fn.executable
            local path = require('lspconfig/util').path

            local find_cmd = function(cmd, prefixes, start)
              if type(prefixes) == 'string' then
                prefixes = {prefixes}
              end

              local found = nil
              for _, prefix in ipairs(prefixes) do
                local full_cmd = prefix and path.join(prefix, cmd) or cmd

                if start and path.is_dir(start) then
                  local abs = path.join(start, full_cmd)
                  if executable(abs) > 0 then
                    found = abs
                    break
                  end
                end

                path.traverse_parents(start, function(dir)
                  local abs = path.join(dir, full_cmd)
                  if executable(abs) > 0 then
                    found = abs
                    return true
                  end
                end)

                if found ~= nil then
                  break
                end
              end

              return found or cmd
            end

            local p
            if vim.env.VIRTUAL_ENV or vim.env.VENV then
              p = (vim.env.VIRTUAL_ENV or vim.env.VENV) .. '/bin/python'
            else
              p = find_cmd('python', {'.venv/bin', '.buildenv/bin', '.ve/bin'}, config.root_dir)
            end

            config.settings.python.pythonPath = p
          end,
        },
      },
      setup = {
        clangd = function(_, opts)
          require('clangd_extensions').setup({
            server = opts,
            extensions = {
              autoSetHints = false,
            },
          })
          return true
        end,
      }
    },
    init = function()
      local keys = require('lazyvim.plugins.lsp.keymaps').get()
      keys[#keys+1] = {'<C-j>', '<Cmd>Telescope lsp_definitions<CR>', desc='Goto Definitions'}
      keys[#keys+1] = {'<C-k>', '<Cmd>Telescope lsp_references<CR>', desc='References'}
      keys[#keys+1] = {'<C-l>', vim.lsp.buf.code_action, mode={'n', 'v'}, desc='Code Action', has='codeAction'}
      keys[#keys+1] = {'<C-n>', '<Cmd>Telescope lsp_implementations<CR>', desc='Goto Implementations'}
      keys[#keys+1] = {'<F2>', vim.lsp.buf.rename, desc='Rename', has='rename'}

      local inlay_hint = vim.lsp.buf.inlay_hint
      require('lazyvim.util').on_attach(function(_, buf)
        inlay_hint(buf, true)
      end)
    end,
  },
}

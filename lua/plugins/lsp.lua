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
      {'p00f/clangd_extensions.nvim', config=false},
    },
    event = function() return {} end, -- disable loading on BufReadPre etc
    ft = {'c', 'cpp', 'go', 'gomod', 'json', 'jsonc', 'lua', 'python'},
    opts = {
      autoformat = false,
      servers = {
        clangd = {
          cmd = { 'clangd', '--background-index', '--completion-style=bundled', '--inlay-hints', '--log=error' },
          mason = false,
        },
        gopls = {
          cmd = { 'gopls', 'serve' },
          init_options = {
            usePlaceholders = true,
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
              inlay_hints = {
                parameter_hints_prefix = ' <- ',
              },
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
    end,
  },
}

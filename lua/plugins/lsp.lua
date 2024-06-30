return {
  {
    'folke/trouble.nvim',
    keys = {
      {'<F1>', '<Cmd>Trouble diagnostics toggle<CR>', desc='Diagnostics'},
    },
    opts = {
      auto_close = true,
    },
  },
  {
    'hrsh7th/nvim-cmp',
    opts = function(_, opts)
      table.insert(opts.sorting.comparators, 1, require('clangd_extensions.cmp_scores'))
    end,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'p00f/clangd_extensions.nvim',
        config = function() end,
        opts = {
          ast = {
            --These require codicons (https://github.com/microsoft/vscode-codicons)
            role_icons = {
              type = "",
              declaration = "",
              expression = "",
              specifier = "",
              statement = "",
              ["template argument"] = "",
            },
            kind_icons = {
              Compound = "",
              Recovery = "",
              TranslationUnit = "",
              PackExpansion = "",
              TemplateTypeParm = "",
              TemplateTemplateParm = "",
              TemplateParamObject = "",
            },
          },
          inlay_hints = { inline = false },
        },
      },
    },
    ft = {'c', 'cpp', 'go', 'gomod', 'json', 'jsonc', 'lua', 'python'},
    opts = {
      inlay_hints = { enabled = true },
      servers = {
        clangd = {
          capabilities = {
            offsetEncoding = {'utf-16'},
          },
          cmd = {
            'clangd',
            '--background-index',
            '--clang-tidy',
            '--completion-style=bundled',
            '--function-arg-placeholders',
            '--header-insertion=iwyu',
            '--header-insertion-decorators',
            '--log=error',
          },
          init_options = {
            clangdFileStatus = true,
            completeUnimported = true,
            usePLaceholders = true,
          },
          mason = false,
          root_dir = function(fname)
            local u = require('lspconfig.util')
            return u.root_pattern('compile_commands.json')(fname) or u.find_git_ancestor(fname)
          end,
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
        neocmake = {
          mason = false,
        },
        pyright = {
          before_init = function(_, config)
            local fn = vim.fn
            local executable = fn.executable
            local path = require('lspconfig.util').path

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
          local o = require('lazyvim.util').opts('clangd_extensions.nvim')
          require('clangd_extensions').setup(vim.tbl_deep_extend('force', o or {}, { server = opts }))
          return false
        end,
      },
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

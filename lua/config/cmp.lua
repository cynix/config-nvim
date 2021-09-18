local cmp = require('cmp')
local luasnip = require('luasnip')

local feedkeys = vim.fn.feedkeys
local pumvisible = vim.fn.pumvisible

local t = require('utils.text').t

cmp.setup({
  mapping = {
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Tab>'] = function(fallback)
        if pumvisible() == 1 then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          feedkeys(t'<Plug>luasnip-expand-or-jump', '')
        else
          fallback()
        end
      end,
    ['<S-Tab>'] = function(fallback)
        if pumvisible() == 1 then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          feedkeys(t'<Plug>luasnip-jump-prev', '')
        else
          fallback()
        end
      end,
  },
  snippet = {
    expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
  },
  sources = {
    {name='nvim_lsp'},
    {name='luasnip'},
  },
})

require('nvim-autopairs.completion.cmp').setup()
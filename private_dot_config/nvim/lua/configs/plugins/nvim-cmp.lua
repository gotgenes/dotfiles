local M = {}

function M.setup()
  local cmp = require('cmp')
  local lspkind = require('lspkind')
  local luasnip = require('luasnip')

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<Tab>'] = cmp.mapping.select_next_item(),
      ['<S-Tab>'] = cmp.mapping.select_prev_item(),
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.close()
        else
          fallback()
        end
      end, { 'i' }),
      ['<CR>'] = cmp.mapping.confirm({
        select = true,
        behavior = cmp.ConfirmBehavior.Replace,
      }),
      ['<C-y>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          return cmp.mapping.confirm({ selecet = false })
        end
        fallback()
      end, { 'i' }),
    }),
    sources = cmp.config.sources({
      {
        name = 'nvim_lsp',
      },
      { name = 'luasnip' },
    }, {
      { name = 'nvim_lua' },
    }, {
      {
        name = 'buffer',
      },
      { name = 'path' },
    }),
    formatting = {
      format = lspkind.cmp_format({
        menu = {
          buffer = '[Buffer]',
          luasnip = '[LuaSnip]',
          nvim_lsp = '[LSP]',
          nvim_lua = '[Lua]',
          path = '[Path]',
        },
      }),
    },
  })
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'buffer' },
    }),
  })
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' },
    }, {
      { name = 'cmdline' },
    }),
  })
  cmp.event:on('menu_opened', function()
    vim.b.copilot_suggestion_hidden = true
  end)

  cmp.event:on('menu_closed', function()
    vim.b.copilot_suggestion_hidden = false
  end)
end

return M

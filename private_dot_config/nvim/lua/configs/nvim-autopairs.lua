local npairs = require('nvim-autopairs')
npairs.setup({
  check_ts = true,
})
require('nvim-autopairs.completion.cmp').setup({
  map_cr = true, --  map <CR> on insert mode
  auto_select = true, -- automatically select the first item
})

npairs.add_rules(require('nvim-autopairs.rules.endwise-lua'))
npairs.add_rules(require('nvim-autopairs.rules.endwise-ruby'))

local Rule = require('nvim-autopairs.rule')
local cond = require('nvim-autopairs.conds')

npairs.add_rules({
  Rule(' ', ' ')
    :with_pair(function(opts)
      local pair = opts.line:sub(opts.col - 1, opts.col)
      return vim.tbl_contains({ '()', '{}', '[]' }, pair)
    end)
    :with_move(cond.none())
    :with_cr(cond.none())
    :with_del(function(opts)
      local col = vim.api.nvim_win_get_cursor(0)[2]
      local context = opts.line:sub(col - 1, col + 2)
      return vim.tbl_contains({ '(  )', '{  }', '[  ]' }, context)
    end),
  Rule('', ' )')
    :with_pair(cond.none())
    :with_move(function(opts)
      return opts.char == ')'
    end)
    :with_cr(cond.none())
    :with_del(cond.none())
    :use_key(')'),
  Rule('', ' }')
    :with_pair(cond.none())
    :with_move(function(opts)
      return opts.char == '}'
    end)
    :with_cr(cond.none())
    :with_del(cond.none())
    :use_key('}'),
  Rule('', ' ]')
    :with_pair(cond.none())
    :with_move(function(opts)
      return opts.char == ']'
    end)
    :with_cr(cond.none())
    :with_del(cond.none())
    :use_key(']'),
})

npairs.get_rule('"'):with_pair(cond.not_filetypes({ 'vim' }))

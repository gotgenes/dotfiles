local M = {}

local npairs = require('nvim-autopairs')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
local Rule = require('nvim-autopairs.rule')
local cond = require('nvim-autopairs.conds')

function M.setup()
  npairs.setup({
    check_ts = true,
  })
  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

  npairs.add_rules({
    Rule(' ', ' '):with_pair(function(opts)
      local pair = opts.line:sub(opts.col - 1, opts.col)
      return vim.tbl_contains({ '()', '[]', '{}' }, pair)
    end),
    Rule('( ', ' )')
      :with_pair(function()
        return false
      end)
      :with_move(function(opts)
        return opts.prev_char:match('.%)') ~= nil
      end)
      :use_key(')'),
    Rule('{ ', ' }')
      :with_pair(function()
        return false
      end)
      :with_move(function(opts)
        return opts.prev_char:match('.%}') ~= nil
      end)
      :use_key('}'),
    Rule('[ ', ' ]')
      :with_pair(function()
        return false
      end)
      :with_move(function(opts)
        return opts.prev_char:match('.%]') ~= nil
      end)
      :use_key(']'),
  })
end

return M

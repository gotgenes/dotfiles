local M = {}

local function set_keymaps(bufnr)
  local wk = require('which-key')
  wk.register({
    a = {
      function()
        require('aerial').toggle()
      end,
      'Aerial toggle',
    },
  }, {
    prefix = '<leader>',
    buffer = bufnr,
  })
  wk.register({
    [']a'] = {
      function()
        require('aerial').next()
      end,
      'Aerial next',
    },
    ['[a'] = {
      function()
        require('aerial').prev()
      end,
      'Aerial previous',
    },
    [']A'] = {
      function()
        require('aerial').next_up()
      end,
      'Aerial next up',
    },
    ['[A'] = {
      function()
        require('aerial').prev_up()
      end,
      'Aerial previous up',
    },
  }, {
    buffer = bufnr,
  })
end

function M.setup()
  local aerial = require('aerial')
  aerial.setup({
    layout = {
      min_width = 20,
    },
    on_attach = set_keymaps,
  })
end

return M

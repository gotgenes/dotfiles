local gs = require('gitsigns')
local wk = require('which-key')

local M = {}

local function set_keymaps(bufnr)
  wk.register({
    h = {
      name = 'Gitsigns',
      n = { '<CMD>Gitsigns next_hunk<CR>', 'next hunk' },
      p = { '<CMD>Gitsigns prev_hunk<CR>', 'previous hunk' },
      s = { '<CMD>Gitsigns stage_hunk<CR>', 'stage hunk' },
      r = { '<CMD>Gitsigns reset_hunk<CR>', 'reset hunk' },
      S = { gs.stage_buffer, 'stage buffer' },
      u = { gs.undo_stage_hunk, 'undo stage hunk' },
      R = { gs.reset_buffer, 'reset buffer' },
      P = { gs.preview_hunk, 'preview hunk' },
      b = {
        l = {
          function()
            gs.blame_line({ full = true })
          end,
          'blame line',
        },
        t = { gs.toggle_current_line_blame, 'toggle blame' },
      },
      d = { gs.diffthis, 'diff' },
      D = {
        function()
          gs.diffthis('~')
        end,
        'diff',
      },
      x = { gs.toggle_deleted, 'toggel deleted' },
    },
  }, {
    prefix = '<leader>',
    buffer = bufnr,
  })
  wk.register({
    h = {
      name = 'Gitsigns',
      s = { '<CMD>Gitsigns stage_hunk<CR>', 'stage hunk' },
      r = { '<CMD>Gitsigns reset_hunk<CR>', 'reset hunk' },
    },
  }, {
    mode = 'v',
    prefix = '<leader>',
    buffer = bufnr,
  })
  wk.register({
    ih = { '<CMD>Gitsigns select_hunk<CR>', 'select hunk (gitsigns)' },
  }, {
    mode = 'o',
    buffer = bufnr,
  })
  wk.register({
    ih = { '<CMD>Gitsigns select_hunk<CR>', 'select hunk (gitsigns)' },
  }, {
    mode = 'x',
    buffer = bufnr,
  })
end

function M.setup()
  gs.setup({ on_attach = set_keymaps })
end

return M

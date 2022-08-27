local M = {}

local gs = require('gitsigns')
local wk = require('which-key')

local function set_keymaps(bufnr)
  wk.register({
    h = {
      name = 'Gitsigns',
      s = { gs.stage_hunk, 'stage hunk' },
      r = { gs.reset_hunk, 'reset hunk' },
      S = { gs.stage_buffer, 'stage buffer' },
      u = { gs.undo_stage_hunk, 'undo stage hunk' },
      R = { gs.reset_buffer, 'reset buffer' },
      p = { gs.preview_hunk, 'preview hunk' },
      b = {
        l = {
          function()
            gs.blame_line({ full = true })
          end,
          'blame line',
        },
        t = { gs.toggle_current_line_blame, 'toggle blame' },
      },
      d = { gs.diffthis, 'diff against index' },
      D = {
        function()
          gs.diffthis('~')
        end,
        'diff against commit',
      },
      x = { gs.toggle_deleted, 'toggle deleted' },
    },
  }, {
    prefix = '<leader>',
    buffer = bufnr,
  })
  wk.register({
    [']h'] = { gs.next_hunk, 'Next hunk (gitsigns)' },
    ['[h'] = { gs.prev_hunk, 'Previous hunk (gitsigns)' },
  }, { buffer = bufnr })
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

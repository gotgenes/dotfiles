local M = {}

local alpha = require('alpha')
local dashboard = require('alpha.themes.dashboard')
local nwd = require('nvim-web-devicons')
local plenary_path = require('plenary.path')
local theta = require('alpha.themes.theta')

local mru_opts = theta.mru_opts
local target_width = 35
local mru_file_shortcuts = { '1', '2', '3', '4', '5', '6', '7', '8', '9', '0' }

local function get_extension(fn)
  local match = fn:match('^.+(%..+)$')
  local ext = ''
  if match ~= nil then
    ext = match:sub(2)
  end
  return ext
end

local function icon(fn)
  local ext = get_extension(fn)
  return nwd.get_icon(fn, ext, { default = true })
end

local function file_button(fn, sc, short_fn, autocd)
  short_fn = short_fn or fn
  local ico_txt
  local fb_hl = {}

  local ico, hl = icon(fn)
  if hl then
    table.insert(fb_hl, { hl, 0, 3 })
  end
  ico_txt = ico .. '  '
  local cd_cmd = (autocd and ' | cd %:p:h' or '')
  local file_button_el = dashboard.button(sc, ico_txt .. short_fn, '<cmd>e ' .. fn .. cd_cmd .. ' <CR>')
  local fn_start = short_fn:match('.*[/\\]')
  if fn_start ~= nil then
    table.insert(fb_hl, { 'Comment', #ico_txt - 2, #fn_start + #ico_txt })
  end
  file_button_el.opts.hl = fb_hl
  return file_button_el
end

local function get_oldfiles(cwd, number_of_items, opts)
  local oldfiles = {}
  for _, v in pairs(vim.v.oldfiles) do
    if #oldfiles == number_of_items then
      break
    end
    local cwd_cond
    if not cwd then
      cwd_cond = true
    else
      cwd_cond = vim.startswith(v, cwd)
    end
    local ignore = (opts.ignore and opts.ignore(v, get_extension(v))) or false
    if (vim.fn.filereadable(v) == 1) and cwd_cond and not ignore then
      oldfiles[#oldfiles + 1] = v
    end
  end
  return oldfiles
end

local function to_short_filename(fn, target_width, cwd)
  local short_fn
  if cwd then
    short_fn = vim.fn.fnamemodify(fn, ':.')
  else
    short_fn = vim.fn.fnamemodify(fn, ':~')
  end

  if #short_fn > target_width then
    short_fn = plenary_path.new(short_fn):shorten(1, { -2, -1 })
    if #short_fn > target_width then
      short_fn = plenary_path.new(short_fn):shorten(1, { -1 })
    end
  end

  return short_fn
end

local function mru(cwd, shortcuts, opts)
  opts = opts or mru_opts
  local items_number = #shortcuts
  local oldfiles = get_oldfiles(cwd, items_number, opts)

  local tbl = {}
  for i, fn in ipairs(oldfiles) do
    local short_fn = to_short_filename(fn, target_width, cwd)
    local shortcut = shortcuts[i]
    local file_button_el = file_button(fn, shortcut, short_fn, opts.autocd)
    tbl[i] = file_button_el
  end
  return {
    type = 'group',
    val = tbl,
    opts = {},
  }
end

local header = {
  type = 'text',
  -- Many more of these headers available at
  -- https://github.com/dtr2300/nvim/blob/main/lua/config/utils/headers.lua
  val = {
    [[::::    ::: ::::::::::  ::::::::  :::     ::: ::::::::::: ::::    :::: ]],
    [[:+:+:   :+: :+:        :+:    :+: :+:     :+:     :+:     +:+:+: :+:+:+]],
    [[:+:+:+  +:+ +:+        +:+    +:+ +:+     +:+     +:+     +:+ +:+:+ +:+]],
    [[+#+ +:+ +#+ +#++:++#   +#+    +:+ +#+     +:+     +#+     +#+  +:+  +#+]],
    [[+#+  +#+#+# +#+        +#+    +#+  +#+   +#+      +#+     +#+       +#+]],
    [[#+#   #+#+# #+#        #+#    #+#   #+#+#+#       #+#     #+#       #+#]],
    [[###    #### ##########  ########      ###     ########### ###       ###]],
  },
  opts = {
    position = 'center',
    hl = 'Type',
  },
}

local section_mru = {
  type = 'group',
  val = {
    {
      type = 'text',
      val = 'Recent files',
      opts = {
        hl = 'SpecialComment',
        shrink_margin = false,
        position = 'center',
      },
    },
    { type = 'padding', val = 1 },
    {
      type = 'group',
      val = function()
        return { mru(vim.fn.getcwd(), mru_file_shortcuts) }
      end,
      opts = { shrink_margin = false },
    },
  },
}

local buttons = {
  type = 'group',
  val = {
    { type = 'text', val = 'Quick links', opts = { hl = 'SpecialComment', position = 'center' } },
    { type = 'padding', val = 1 },
    dashboard.button('s', '  Load previous session', '<Cmd>SessionLoad<CR>'),
    dashboard.button('f', '  Find file', '<Cmd>Telescope find_files<CR>'),
    dashboard.button('g', '  Live grep', '<Cmd>Telescope live_grep<CR>'),
    dashboard.button('m', '  Mason', '<Cmd>Mason<CR>'),
    dashboard.button('u', '  Check for plugin updates', '<Cmd>Lazy check<CR>'),
    dashboard.button('q', '  Quit', '<Cmd>qa<CR>'),
  },
  position = 'center',
}

local config = {
  layout = {
    { type = 'padding', val = 3 },
    header,
    { type = 'padding', val = 3 },
    section_mru,
    { type = 'padding', val = 2 },
    buttons,
  },
  opts = {
    margin = 5,
    setup = function()
      vim.api.nvim_create_autocmd('DirChanged', {
        pattern = '*',
        callback = function()
          require('alpha').redraw()
        end,
      })
    end,
  },
}

function M.setup()
  alpha.setup(config)
end

return M

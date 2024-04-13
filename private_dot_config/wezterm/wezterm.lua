local wezterm = require('wezterm')
local act = wezterm.action
local mux = wezterm.mux

-- from https://stackoverflow.com/a/1283608/38140
local function table_merge(t1, t2)
  for k, v in pairs(t2) do
    if type(v) == 'table' then
      if type(t1[k] or false) == 'table' then
        table_merge(t1[k] or {}, t2[k] or {})
      else
        t1[k] = v
      end
    else
      t1[k] = v
    end
  end
  return t1
end

local function get_active_tab_idx(mux_win)
  for _, tab in ipairs(mux_win:tabs_with_info()) do
    if tab.is_active then
      wezterm.log_info('activetab: ', tab)
      return tab.index
    end
  end
end

wezterm.on('gui-attached', function(domain)
  -- maximize all displayed windows on startup
  local workspace = mux.get_active_workspace()
  for _, window in ipairs(mux.all_windows()) do
    if window:get_workspace() == workspace then
      window:gui_window():maximize()
    end
  end
end)

local url_patterns = {
  -- URL before a closing parenthesis
  [=[([[:alpha:]]+://\S+)\)]=],
  -- URL before a closing bracket
  [=[([[:alpha:]]+://\S+)\]]=],
  -- URL before a closing angle bracket
  [=[([[:alpha:]]+://\S+)>]=],
  -- URL before a closing double-quote
  [=[([[:alpha:]]+://\S+)"]=],
  -- URL before a closing single-quote
  [=[([[:alpha:]]+://\S+)']=],
  -- URL alone
  [=[([[:alpha:]]+://\S+)]=],
}

-- Alphabet for Dvorak keyboard layout
local quick_select_alphabet = 'htnsgcrlmwvzueoapkjqdfbiyx'

local copy_url_action = act.QuickSelectArgs({
  label = 'copy url',
  patterns = url_patterns,
  alphabet = quick_select_alphabet,
  action = wezterm.action_callback(function(window, pane)
    local url = window:get_selection_text_for_pane(pane)
    window:copy_to_clipboard(url, 'ClipboardAndPrimarySelection')
  end),
})

local open_url_action = act.QuickSelectArgs({
  label = 'open url',
  patterns = url_patterns,
  alphabet = quick_select_alphabet,
  action = wezterm.action_callback(function(window, pane)
    local url = window:get_selection_text_for_pane(pane)
    wezterm.open_with(url)
  end),
})

local my_config = {
  font = wezterm.font('JetBrainsMono Nerd Font', { weight = 'Regular' }),
  font_size = 13.0,
  line_height = 1.15,
  color_scheme = 'Catppuccin Macchiato',
  hide_tab_bar_if_only_one_tab = true,
  keys = {
    {
      key = 'o',
      mods = 'CTRL|SHIFT',
      action = open_url_action,
    },
    {
      key = 'a',
      mods = 'CTRL|SHIFT',
      action = copy_url_action,
    },
    {
      key = 't',
      mods = 'CTRL|SHIFT',
      -- https://github.com/wez/wezterm/issues/909
      action = wezterm.action_callback(function(win, pane)
        local mux_win = win:mux_window()
        local idx = get_active_tab_idx(mux_win)
        mux_win:spawn_tab({})
        wezterm.log_info('movetab: ', idx)
        win:perform_action(wezterm.action.MoveTab(idx + 1), pane)
      end),
    },
    {
      key = 't',
      mods = 'SUPER',
      action = act.SpawnCommandInNewTab({
        cwd = wezterm.home_dir,
        domain = 'DefaultDomain',
      }),
    },
  },
}

local config = table_merge(wezterm.config_builder(), my_config)

return config

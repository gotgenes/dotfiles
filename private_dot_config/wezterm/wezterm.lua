local wezterm = require('wezterm')
local act = wezterm.action
local mux = wezterm.mux

-- from https://stackoverflow.com/a/1283608/38140
function table_merge(t1, t2)
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

wezterm.on('gui-attached', function(domain)
  -- maximize all displayed windows on startup
  local workspace = mux.get_active_workspace()
  for _, window in ipairs(mux.all_windows()) do
    if window:get_workspace() == workspace then
      window:gui_window():maximize()
    end
  end
end)

local url_pattern = 'https?://\\S+'

local copy_url_action = act.QuickSelectArgs({
  label = 'open url',
  patterns = { url_pattern },
  action = wezterm.action_callback(function(window, pane)
    local url = window:get_selection_text_for_pane(pane)
    window:copy_to_clipboard(url, 'ClipboardAndPrimarySelection')
  end),
})

local open_url_action = act.QuickSelectArgs({
  label = 'open url',
  patterns = { url_pattern },
  action = wezterm.action_callback(function(window, pane)
    local url = window:get_selection_text_for_pane(pane)
    wezterm.open_with(url)
  end),
})

local my_config = {
  font = wezterm.font('JetBrainsMono Nerd Font', { weight = 'Regular' }),
  font_size = 12.0,
  line_height = 1.1,
  color_scheme = 'Catppuccin Macchiato',
  hide_tab_bar_if_only_one_tab = true,
  keys = {
    {
      key = 'o',
      mods = 'CTRL|SHIFT',
      action = open_url_action,
    },
    {
      key = 'u',
      mods = 'CTRL|SHIFT',
      action = copy_url_action,
    },
  },
}

local config = table_merge(wezterm.config_builder(), my_config)

return config

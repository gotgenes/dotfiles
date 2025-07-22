local M = {}

---@type snacks.picker.Action.fn
local function copy_selector(_, item)
  local modify = vim.fn.fnamemodify
  local filepath = Snacks.picker.util.path(item)
  if not filepath then
    Snacks.notify("No file selected", vim.log.levels.WARN)
    return
  end
  Snacks.notify(("Selected: `%s`"):format(filepath))
  local filename = modify(filepath, ":t")

  local vals = {
    ["FILENAME"] = filename,
    ["PATH (CWD)"] = modify(filepath, ":."),
    ["BASENAME"] = modify(filename, ":r"),
    ["FULL PATH"] = filepath,
    ["PATH (HOME)"] = modify(filepath, ":~"),
    ["URI"] = vim.uri_from_fname(filepath),
  }

  local options = vim.tbl_filter(function(val)
    return vals[val] ~= ""
  end, vim.tbl_keys(vals))
  if vim.tbl_isempty(options) then
    vim.notify("No values to copy", vim.log.levels.WARN)
    return
  end
  Snacks.picker.select(options, {
    prompt = "Choose to copy to clipboard:",
    format_item = function(f_item)
      return ("%s: %s"):format(f_item, vals[f_item])
    end,
  }, function(choice)
    local result = vals[choice]
    if result then
      Snacks.notify(("Copied: `%s`"):format(result))
      vim.fn.setreg("+", result)
    end
  end)
end

---@type snacks.Config
M.opts = {
  dashboard = {
    preset = {
      keys = {
        {
          action = ":lua Snacks.dashboard.pick('smart')",
          desc = " Find file",
          icon = " ",
          key = "f",
        },
        {
          action = ":ene | startinsert",
          desc = " New file",
          icon = " ",
          key = "n",
        },
        {
          action = ":lua Snacks.dashboard.pick('oldfiles')",
          desc = " Recent files",
          icon = " ",
          key = "r",
        },
        {
          action = ":lua Snacks.dashboard.pick('live_grep')",
          desc = " Find text",
          icon = " ",
          key = "g",
        },
        {
          action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          desc = " Config",
          icon = " ",
          key = "c",
        },
        {
          desc = " Restore Session",
          section = "session",
          icon = " ",
          key = "s",
        },
        {
          action = ":LazyExtras",
          desc = " Lazy Extras",
          icon = " ",
          key = "x",
        },
        {
          action = ":Lazy",
          desc = " Lazy",
          icon = "󰒲 ",
          key = "l",
        },
        {
          action = ":Mason",
          desc = " Mason",
          icon = "󱌢 ",
          key = "m",
        },
        {
          action = ":qa",
          desc = " Quit",
          icon = " ",
          key = "q",
        },
      },
    },
  },
  picker = {
    actions = { copy_selector = copy_selector },
    sources = {
      buffers = { layout = "select" },
      explorer = { win = { list = { keys = { Y = "copy_selector" } } } },
    },
  },
  scroll = {
    animate = {
      duration = { total = 80 },
      easing = "linear",
    },
  },
}

return M

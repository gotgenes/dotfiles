------------------------
-- BEHAVIORAL SETTINGS -
------------------------

local opt = vim.opt

-- Show matching brackets.
opt.showmatch = true

-- Leave most folds open by default.
opt.foldlevelstart = 99

-- Set the spelling language to US English.
opt.spelllang = "en_us"

-- Use absolute line numbers by default.
opt.relativenumber = false

-- LSP Server to use for Python
vim.g.lazyvim_python_lsp = "ty"

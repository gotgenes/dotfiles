vim.keymap.set("n", "<F5>", 'a<C-r>=strftime("%F")<cr><esc>', { noremap = true, silent = true, desc = "Insert date" })
vim.keymap.set("i", "<F5>", '<C-r>=strftime("%F")<cr>', { noremap = true, silent = true, desc = "Insert date" })

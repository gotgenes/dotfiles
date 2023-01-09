lua << EOF
------------------------
-- BEHAVIORAL SETTINGS -
------------------------

-- Show matching brackets.
vim.o.showmatch = true
-- Do smart case matching
vim.o.smartcase = true
-- Allow resizing of the window on session restore
vim.opt.sessionoptions:append({ 'resize' })
-- Give popup menus for a right mouse-click
vim.o.mousemodel = 'popup_setpos'
-- Hide buffers when they are not displayed; this prevents warning messages
-- about modified buffers when switching between them.
vim.o.hidden = true
-- Set the spelling language to US English.
vim.o.spelllang = 'en_us'
-- Highlight the line on which the cursor lies
vim.o.cursorline = true
-- Show line numbers
vim.o.number = true
-- Don't show insert mode; taken care of by lualine
vim.o.showmode = false

-- Use the persistent-undo feature
vim.o.undofile = true
-- Maximum number of changes that can be undone
vim.o.undolevels = 1000
-- Maximum number lines to save for undo on a buffer reload
vim.o.undoreload=10000

-- Decrease the time to update the swap file
vim.o.updatetime=500

-- Enable concealing, for example, rendering bold text in Markdown but hiding
-- the asterisks
vim.o.conceallevel=2

-- Leave most folds open by default.
vim.o.foldlevelstart=99

-- Increase cmdheight
vim.o.cmdheight=2

-- Set completion options
vim.opt.completeopt={'menuone', 'noselect'}

-- Set 24-bit colors
vim.o.termguicolors = true

-- Set the leader key to <space>
vim.g.mapleader = ' '
EOF


lua require('configs.autocmds').setup()


"""""""""""""""""""
" INSTALL PLUGINS "
"""""""""""""""""""
let g:operator_sandwich_no_default_key_mappings = 1
lua require('plugins')

lua require('configs.keymaps').setup()


""""""""""""""""""""""""""
" PLUGINS CONFIGURATIONS "
""""""""""""""""""""""""""

" Diagnostic
lua require('configs.plugins.diagnostic').setup()


" python.vim builtin
let g:no_python_maps = 1


" nvim-tree configuration
nnoremap <silent> <leader>ntt :NvimTreeToggle<CR>
nnoremap <silent> <leader>ntc :NvimTreeFindFile<CR>


" Mundo configuration
let g:mundo_right = 1


" vim-better-whitespace configuration
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:better_whitespace_filetypes_blacklist=[
      \ 'packer', 'diff', 'git', 'gitcommit', 'qf', 'help', 'markdown', 'fugitive']
highlight link ExtraWhitespace Error


" vim-matchup configuration
let g:matchup_matchparen_offscreen = {'method': 'popup'}


" vim-go configuration
let g:go_code_completion_enabled = 0
let g:go_doc_keywordprg_enabled = 0
let g:go_def_mapping_enabled = 0
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 0
let g:go_highlight_types = 1
let g:go_highlight_fields = 0


" vimtex configuration
let g:tex_flavor = 'latex'

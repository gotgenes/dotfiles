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


""""""""""""""""""""
" autocmd settings "
""""""""""""""""""""

" Recognize VTL
autocmd BufNewFile,BufRead *.vtl set ft=velocity

" Help Neovim check if file has changed on disk
" https://github.com/neovim/neovim/issues/2127
augroup checktime
  autocmd!
  if !has("gui_running")
    "silent! necessary otherwise throws errors when using command
    "line window.
    autocmd BufEnter,FocusGained,BufEnter,FocusLost,WinLeave * checktime
  endif
augroup END


""""""""""""""""""""""""""""""""""""""""""""
" SETTINGS REQUIRED BEFORE LOADING PLUGINS "
""""""""""""""""""""""""""""""""""""""""""""
let g:operator_sandwich_no_default_key_mappings = 1


"""""""""""""""""""
" INSTALL PLUGINS "
"""""""""""""""""""
lua require('plugins')
autocmd BufWritePost plugins.lua source <afile> | PackerCompile

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


" vim-sandwich configuration
" define mappings
" add
silent! nmap <unique> <leader>sa <Plug>(sandwich-add)
silent! xmap <unique> <leader>sa <Plug>(sandwich-add)
silent! omap <unique> <leader>sa <Plug>(sandwich-add)

" delete
silent! nmap <unique> <leader>sd <Plug>(sandwich-delete)
silent! xmap <unique> <leader>sd <Plug>(sandwich-delete)
silent! nmap <unique> <leader>sdb <Plug>(sandwich-delete-auto)

" replace
silent! nmap <unique> <leader>sr <Plug>(sandwich-replace)
silent! xmap <unique> <leader>sr <Plug>(sandwich-replace)
silent! nmap <unique> <leader>srb <Plug>(sandwich-replace-auto)

let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)
let g:sandwich#recipes += [
      \ {'buns': ['{ ', ' }'], 'nesting': 1, 'match_syntax': 1,
      \  'kind': ['add', 'replace'], 'action': ['add'], 'input': ['{']},
      \
      \ {'buns': ['[ ', ' ]'], 'nesting': 1, 'match_syntax': 1,
      \  'kind': ['add', 'replace'], 'action': ['add'], 'input': ['[']},
      \
      \ {'buns': ['( ', ' )'], 'nesting': 1, 'match_syntax': 1,
      \  'kind': ['add', 'replace'], 'action': ['add'], 'input': ['(']},
      \
      \ {'buns': ['{\s*', '\s*}'],   'nesting': 1, 'regex': 1,
      \  'match_syntax': 1, 'kind': ['delete', 'replace', 'textobj'],
      \  'action': ['delete'], 'input': ['{']},
      \
      \ {'buns': ['\[\s*', '\s*\]'], 'nesting': 1, 'regex': 1,
      \  'match_syntax': 1, 'kind': ['delete', 'replace', 'textobj'],
      \  'action': ['delete'], 'input': ['[']},
      \
      \ {'buns': ['(\s*', '\s*)'],   'nesting': 1, 'regex': 1,
      \  'match_syntax': 1, 'kind': ['delete', 'replace', 'textobj'],
      \  'action': ['delete'], 'input': ['(']},
      \ ]


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

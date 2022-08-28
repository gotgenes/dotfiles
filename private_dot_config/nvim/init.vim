"""""""""""""""""""""""
" BEHAVIORAL SETTINGS "
"""""""""""""""""""""""

" Show matching brackets.
set showmatch
" Do case insensitive matching
set ignorecase
" Do smart case matching
set smartcase
" Allow resizing of the window on session restore
set sessionoptions+=resize
" Give popup menus for a right mouse-click
set mousemodel=popup
" Hide buffers when they are not displayed; this prevents warning messages
" about modified buffers when switching between them.
set hidden
" Set the spelling language to US English.
set spelllang=en_us
" Highlight the line on which the cursor lies
set cursorline
" Show line numbers
set number
" Don't show insert mode; taken care of by lightline
set noshowmode

" Use the persistent-undo feature
set undofile
" Maximum number of changes that can be undone
set undolevels=1000
" Maximum number lines to save for undo on a buffer reload
set undoreload=10000

" Decrease the time to update the swap file
set updatetime=500

" Enable concealing, for example, rendering bold text in Markdown but hiding
" the asterisks
set conceallevel=2

" Leave most folds open by default.
set foldlevelstart=10

" Increase cmdheight
set cmdheight=2

" Set completion options
set completeopt=menuone,noselect

" Set 24-bit colors
set termguicolors

let &t_ut=''


""""""""""""
" MAPPINGS "
""""""""""""

" Set the leader
let mapleader = "\<Space>"

" Easy access keystrokes for editing your Vim configuration
nnoremap <leader>vrcs :source $MYVIMRC<CR>
nnoremap <leader>vrce :e $MYVIMRC<CR>

" Quickly switch buffers
nnoremap <silent> <leader>nn :bn<CR>
nnoremap <silent> <leader>pp :bp<CR>
nnoremap <silent> <leader>bd :bd<CR>

" Change the current directory to the directory of the current buffer
nnoremap <silent> <leader>cdb :lcd %:p:h<CR>

" Let j and k move up and down over line-wrapped lines, too.
nnoremap <silent> j gj
nnoremap <silent> k gk

" Turn off highlighted search terms
nnoremap <silent> <leader>/ :nohlsearch<CR>

" Insert a timestamp
nnoremap <F5> a<C-R>=strftime("%F")<CR><Esc>
inoremap <F5> <C-R>=strftime("%F")<CR>

" Quickly switch spelling on and off.
nnoremap <leader>spl :setlocal spell!<CR>

" Make it easy to toggle folding
nmap <leader><space> za
vnoremap <leader><space> zf

" Close help window
nnoremap <silent> <leader>hc :helpclose<CR>


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


""""""""""""""""""""""""""
" PLUGINS CONFIGURATIONS "
""""""""""""""""""""""""""

" Diagnostic
lua require('configs.diagnostic').setup()


" python.vim builtin
let g:no_python_maps = 1


" easyescape configuration
let g:easyescape_chars = { "j": 1, "k": 1 }
let g:easyescape_timeout = 300


" nvim-tree configuration
nnoremap <silent> <leader>ntt :NvimTreeToggle<CR>
nnoremap <silent> <leader>ntc :NvimTreeFindFile<CR>


" Symbols Outline configuration
let g:symbols_outline = { "auto_preview": v:false }
nnoremap <silent> <leader>ot :SymbolsOutline<CR>


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
let g:better_whitespace_filetypes_blacklist=[
      \ 'packer', 'diff', 'git', 'gitcommit', 'qf', 'help', 'markdown', 'fugitive']
nnoremap <silent> <leader>wss :ToggleStripWhitespaceOnSave<CR>
nnoremap <silent> <leader>wsh :ToggleWhitespace<CR>

if has("autocmd")
  autocmd BufEnter * EnableStripWhitespaceOnSave
endif

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


""""""""""""""""""""""""""""""""""""""""""
" Syntax highlighting and color settings "
""""""""""""""""""""""""""""""""""""""""""

lua << EOF
vim.g.catppuccin_flavour = "mocha"
require('catppuccin').setup({
  styles = {
    functions = {},
    variables = {},
  },
})
EOF

colorscheme catppuccin
highlight HtmlBold gui=bold
highlight HtmlItalic gui=italic

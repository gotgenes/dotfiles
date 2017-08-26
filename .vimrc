set nocompatible

"""""""""""""""""""""""
" BEHAVIORAL SETTINGS "
"""""""""""""""""""""""

" Allow backspacing over anything in insert mode
set backspace=indent,eol,start
" Show (partial) command in status line.
set showcmd
" Show matching brackets.
set showmatch
" Do case insensitive matching
set ignorecase
" Do smart case matching
set smartcase
" Search highlighting enabled
set hlsearch
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

" Use the persistent undo feature
" See :h persistent-undo
" NOTE: the directory listed in undodir must exist; Vim will not create this
" directory itself!
set undodir=~/.vimundos
set undofile
" Maximum number of changes that can be undone
set undolevels=1000
" Maximum number lines to save for undo on a buffer reload
set undoreload=10000

" Decrease the time to update the swap file
set updatetime=500


""""""""""""
" MAPPINGS "
""""""""""""

" Set the leader
let mapleader = ','

" Get to command mode easier
nnoremap ; :
vnoremap ; :

" Easy access keystrokes for editing your Vim configuration
nnoremap <leader>svrc :source $MYVIMRC<CR>
nnoremap <leader>vrc :e $MYVIMRC<CR>

" Quickly switch buffers
nnoremap <silent> <leader>nn :bn<CR>
nnoremap <silent> <leader>pp :bp<CR>
nnoremap <silent> <leader>bd :bd<CR>

" Change the current directory to the directory of the current buffer
nnoremap <silent> <leader>cdb :lcd %:p:h<CR>

" Change the current directory to the project directory

" Let j and k move up and down over line-wrapped lines, too.
nnoremap j gj
nnoremap k gk

" I want to quickly switch to text settings sometimes.
nnoremap <leader>txt :setlocal ai et sts=4 sw=4 ts=4 tw=78 spell<CR>

" Turn off highlighted search terms
nnoremap <silent> <leader>/ :nohlsearch<CR>

" Insert a timestamp
nnoremap <F5> a<C-R>=strftime("%F")<CR><Esc>
inoremap <F5> <C-R>=strftime("%F")<CR>

" Quickly switch spelling on and off.
nnoremap <leader>spl :setlocal spell!<CR>

" Make it easy to toggle folding
nnoremap <space> za
vnoremap <space> zf


""""""""""""""""""""
" autocmd settings "
""""""""""""""""""""

if has("autocmd")
  " Start editing a previously opened file from the position of the most
  " recent edit.
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif
endif


"""""""""""""""""""
" INSTALL PLUGINS "
"""""""""""""""""""
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('~/.cache/dein', '~/shell-configs/.vimrc')

" Let dein manage dein
call dein#add('Shougo/dein.vim')
call dein#add('haya14busa/dein-command.vim')

" Productivity
call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
call dein#add('Shougo/unite.vim')
call dein#add('tsukkee/unite-help')
call dein#add('Shougo/neoyank.vim')
call dein#add('schickling/vim-bufonly')
call dein#add('scrooloose/nerdtree')
call dein#add('ntpeters/vim-better-whitespace')
call dein#add('dbakker/vim-projectroot')
call dein#add('vim-scripts/utl.vim')
call dein#add('tpope/vim-repeat')
call dein#add('tpope/vim-surround')
call dein#add('tpope/vim-unimpaired')
call dein#add('itchyny/lightline.vim')
call dein#add('chriskempson/base16-vim')
call dein#add('gotgenes/base16-lightline.vim')

" Git
call dein#add('tpope/vim-fugitive')
call dein#add('airblade/vim-gitgutter')
call dein#add('gregsexton/gitv')

" Programming
call dein#add('Shougo/neocomplete')
call dein#add('scrooloose/syntastic')
call dein#add('scrooloose/nerdcommenter')
call dein#add('SirVer/ultisnips')
call dein#add('honza/vim-snippets')
call dein#add('majutsushi/tagbar')
call dein#add('cohama/lexima.vim')
call dein#add('Konfekt/FastFold')

" Go
call dein#add('fatih/vim-go')
call dein#add('gotgenes/golang-template.vim')

" HTML
call dein#add('tmhedberg/matchit')
call dein#add('othree/html5.vim')
call dein#add('alvan/vim-closetag')

" JavaScript
call dein#add('pangloss/vim-javascript')

" LaTeX
call dein#add('lervag/vimtex')

" Markdown
call dein#add('godlygeek/tabular')
call dein#add('gabrielelana/vim-markdown')

" Python
call dein#add('davidhalter/jedi-vim')
call dein#add('tmhedberg/SimpylFold')
call dein#add('hynek/vim-python-pep8-indent')

" TOML
call dein#add('cespare/vim-toml')

" TypeScript
call dein#add('leafgarland/typescript-vim')
call dein#add('Quramy/tsuquyomi')

call dein#end()

filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif


""""""""""""""""""""""""""
" PLUGINS CONFIGURATIONS "
""""""""""""""""""""""""""

" lightline configuration
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'base16_eighties',
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \   'fugitive': 'LightlineFugitive',
      \   'mode': 'LightlineMode',
      \   'readonly': 'LightlineReadonly',
      \ },
      \}

function! LightlineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'RO' : ''
endfunction

function! LightlineFilename()
  return (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]')
endfunction

function! LightlineFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = ''  " edit here for cool mark
      let branch = fugitive#head()
      return branch !=# '' ? mark.branch : ''
    endif
  catch
  endtry
  return ''
endfunction

function! LightlineMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'
function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

let g:unite_force_overwrite_statusline = 0


" utl configuration
let g:utl_cfg_hdl_scm_http_system = "silent !firefox -remote 'ping()' && firefox -remote 'openURL( %u )' || firefox '%u#%f' &"
nnoremap <leader>gu :Utl openLink underCursor edit<CR>
nnoremap <leader>cl :Utl copyLink underCursor<CR>


" NERDCommenter configuration
" Prevent NERDCommenter from complaining about unrecognized filetypes.
let NERDShutUp=1


" NERDTree configuration
nnoremap <leader>nt :NERDTreeToggle<CR>


" Tagbar configuration
nnoremap <leader>tb :TagbarToggle<CR>


" UltiSnips configuration
let g:UltiSnipsExpandTrigger = "<C-S>"
let g:UltiSnipsJumpForwardTrigger = "<C-,>"
let g:UltiSnipsJumpBackwardTrigger = "<C-.>"

let g:ultisnips_python_style = "sphinx"


" vim-better-whitespace configuration
nnoremap <silent> <leader>rws :ToggleStripWhitespaceOnSave<CR>
nnoremap <silent> <leader>hws :ToggleWhitespace<CR>

if has("autocmd")
  autocmd BufEnter * EnableStripWhitespaceOnSave
endif

highlight link ExtraWhitespace Error


" Syntastic configuration
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_wq = 0


" neocomplete configuration
let g:neocomplete#enable_at_startup = 1

call neocomplete#custom#source('_', 'converters',
      \['converter_remove_overlap', 'converter_remove_last_paren',
      \ 'converter_delimiter', 'converter_abbr'])

if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:neocomplete#force_omni_input_patterns.python =
\ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
let g:neocomplete#force_omni_input_patterns.typescript = '[^. *\t]\.\w*\|\h\w*::'

inoremap <expr> <C-G> neocomplete#undo_completion()

" tab-completion
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-N>" :
      \ <SID>has_space_before() ? "\<Tab>" :
      \ neocomplete#start_manual_complete()

function! s:has_space_before() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <expr> <S-Tab> pumvisible() ? "\<C-P>" : "\<C-H>"


" jedi configuration
let g:jedi#use_tabs_not_buffers = 0


" SimpylFold configuration
let g:SimpylFold_fold_docstring = 0


" projectroot settings
nnoremap <silent> <leader>cdp :ProjectRootCD<CR>
nnoremap <silent> <leader>ntp :ProjectRootExe NERDTreeFind<CR>


" Unite settings
if executable('ag')
  let g:unite_source_rec_async_command = [
    \ 'ag', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', '']
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts =
    \ '-i --vimgrep --hidden'
endif
let g:unite_source_history_yank_enable = 1

function! Unite_project()
  execute ':Unite -start-insert buffer file_rec/async:'.ProjectRootGuess().'/'
endfunction

call unite#custom#source('file,file_rec,file_rec/async', 'matchers',
  \['converter_relative_word', 'matcher_fuzzy'])

nnoremap <silent> <leader>ub :<C-u>Unite buffer<CR>
nnoremap <silent> <leader>uf :<C-u>Unite -start-insert file_rec/async<CR>
nnoremap <silent> <leader>up :call Unite_project()<CR>
nnoremap <leader>uy :<C-u>Unite history/yank<CR>
nnoremap <leader>uh :<C-U>Unite -start-insert help<CR>


" base16 configuration
let g:base16colorspace=256

""""""""""""""""""""""""""""""""""""""""""
" Syntax highlighting and color settings "
""""""""""""""""""""""""""""""""""""""""""

if has('termguicolors')
  set termguicolors
endif

colorscheme base16-eighties

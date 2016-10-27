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
" Custom statusline
" Always show the status line
set laststatus=2
set statusline=%.50F
set statusline+=\ [%{strlen(&fenc)?&fenc:&enc},%{&fileformat}]
set statusline+=\ %m%w%h%q
set statusline+=%=
set statusline+=%l,%c\ %3.3p%%
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


""""""""""""
" MAPPINGS "
""""""""""""

" Set the leader
let mapleader = ','

" Get to command mode easier
nnoremap ; :

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
set runtimepath+=~/.vim/plugins/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('/Users/chris/shell-configs/.vim/plugins')

" Let dein manage dein
call dein#add('Shougo/dein.vim')

" Productivity
call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
call dein#add('Shougo/unite.vim')
call dein#add('ervandew/supertab')
call dein#add('schickling/vim-bufonly')
call dein#add('scrooloose/nerdtree')
call dein#add('bronson/vim-trailing-whitespace')  " TODO: replace this with ntpeters/vim-better-whitespace
call dein#add('dbakker/vim-projectroot')
call dein#add('altercation/vim-colors-solarized')
call dein#add('vim-scripts/utl.vim')

" Git
call dein#add('tpope/vim-fugitive')
call dein#add('jisaacks/GitGutter')
call dein#add('gregsexton/gitv')


" Programming
call dein#add('scrooloose/syntastic')
call dein#add('scrooloose/nerdcommenter')
call dein#add('SirVer/ultisnips')
call dein#add('honza/vim-snippets')
call dein#add('majutsushi/tagbar')

" Go
call dein#add('fatih/vim-go')

" HTML
call dein#add('tmhedberg/matchit')
call dein#add('othree/html5.vim')

" JavaScript
call dein#add('pangloss/vim-javascript')

" LaTeX
call dein#add('lervag/vimtex')

" Markdown
call dein#add('godlygeek/tabular')
call dein#add('plasticboy/vim-markdown')

" Python
call dein#add('davidhalter/jedi-vim')
call dein#add('tmhedberg/SimpylFold')
call dein#add('hynek/vim-python-pep8-indent')

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

" utl configuration
let g:utl_cfg_hdl_scm_http_system = "silent !firefox -remote 'ping()' && firefox -remote 'openURL( %u )' || firefox '%u#%f' &"
nnoremap <leader>gu :Utl openLink underCursor edit<CR>
nnoremap <leader>cl :Utl copyLink underCursor<CR>


" NERDCommenter configuration
" Prevent NERDCommenter from complaining about unrecognized filetypes.
let NERDShutUp=1


" Tagbar configuration
nnoremap <leader>tb :TagbarToggle<CR>


" UltiSnips configuration
let g:UltiSnipsListSnippets = "<c-tab>"
let g:ultisnips_python_style = "sphinx"


" trailing-whitespace configuration
function! ToggleAutoRmTrailingWhitespace()
  if !exists("g:auto_rm_trailing_ws")
    let g:auto_rm_trailing_ws = 1
  elseif g:auto_rm_trailing_ws != 1
    let g:auto_rm_trailing_ws = 1
    echo "Automatically removing trailing whitespace."
  else
    let g:auto_rm_trailing_ws = 0
    echo "Not automatically removing trailing whitespace."
  endif
endfunction

call ToggleAutoRmTrailingWhitespace()

nnoremap <silent> <leader>rws :call ToggleAutoRmTrailingWhitespace()<CR>

if has("autocmd")
  " Tidy up trailing whitespace when writing the file if we have the
  " trailing-whitespace plugin installed and we've set the proper variable.
  autocmd BufWritePre * if exists(":FixWhitespace") && exists("g:auto_rm_trailing_ws") && g:auto_rm_trailing_ws == 1 | exe ":FixWhitespace" | endif
endif


" Syntastic configuration
set statusline+=\ %#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_wq = 0


" jedi configuration
let g:jedi#use_tabs_not_buffers = 0


" SimpylFold configuration
let g:SimpylFold_fold_docstring = 0


" projectroot settings
nnoremap <silent> <leader>cdp :ProjectRootCD<CR>
nnoremap <silent> <leader>ntp :ProjectRootExe NERDTreeFind<CR>


" Unite settings
function! Unite_project()
  execute ':Unite -start-insert buffer file_rec/async:'.ProjectRootGuess().'/'
endfunction

call unite#custom#source('file,file_rec,file_rec/async', 'matchers',
  \['converter_relative_word', 'matcher_fuzzy'])
nnoremap <silent> <leader>ub :<C-u>Unite buffer<CR>
" file-rec/async requires vimproc is installed and compiled
nnoremap <silent> <leader>uf :<C-u>Unite -start-insert file_rec/async<CR>
nnoremap <silent> <leader>up :call Unite_project()<CR>
nnoremap <leader>yh :<C-u>Unite history/yank<CR>

if executable('ag')
  let g:unite_source_rec_async_command = [
    \ 'ag', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', '']
endif
let g:unite_source_history_yank_enable = 1

""""""""""""""""""""""""""""""""""""""""""
" Syntax highlighting and color settings "
""""""""""""""""""""""""""""""""""""""""""

" Uncomment one below to get a dark background or a light background. (NOTE:
" it is important to specify this background before specifying any colorscheme
" in Vim. [GVim does not seem phased by the order.])
set background=light
"set background=dark

" Choose a favorite color scheme
let cscheme='solarized'
if strlen(globpath(&rtp, "colors/".cscheme.".vim"))
    exec ":colorscheme ". cscheme
endif

" Fix for vim-gitgutter coloring with Solarized colorscheme
highlight clear SignColumn
highlight link SignColumn LineNr

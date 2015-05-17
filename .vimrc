"""""""""""""""""""""""
" BEHAVIORAL SETTINGS "
"""""""""""""""""""""""

" This is Vim, not VI, so we use it like we mean it!
set nocompatible
filetype plugin indent on
syntax enable
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
" Incremental search
"set incsearch
" Search highlighting enabled
set hlsearch
" Automatically save before commands like :next and :make
"set autowrite
" Allow resizing of the window on session restore
set sessionoptions+=resize
" Enable mouse usage (all modes) in terminals
"set mouse=a
" Give popup menus for a right mouse-click
set mousemodel=popup
" Hide buffers when they are not displayed; this prevents warning messages
" about modified buffers when switching between them.
set hidden
" Set the spelling language to US English.
set spelllang=en_us
" Turn on spell checking by default.
"set spell
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

" Use the persistent undo feature
" See :h persistent-undo
" NOTE: the directory listed in undodir must exist; Vim will not create this
" directory itself!
set undodir=$HOME/.vimundos
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

" Easy access keystrokes for editing your Vim configuration
nnoremap <leader>svrc :source $MYVIMRC<CR>
nnoremap <leader>vrc :e $MYVIMRC<CR>

" Quickly switch buffers
nnoremap <unique> <silent> <leader>nn :bn<CR>
nnoremap <unique> <silent> <leader>pp :bp<CR>
nnoremap <unique> <silent> <leader>bd :bd<CR>

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


""""""""""""""""""""
" autocmd settings "
""""""""""""""""""""

if has("autocmd")
  " Start editing a previously opened file from the position of the most
  " recent edit.
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif
  " This setting makes sure Vim is always operating in the directory of
  " the current buffer.
  autocmd BufEnter * if expand('%:p') !~ '://' | :lchdir %:p:h | endif

  " The lines below close the Omni-Completion tip window on movement in insert
  " mode or when leaving insert mode.
  "autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
  "autocmd InsertLeave * if pumvisible() == 0|pclose|endif
endif


""""""""""""""""""""""""""
" PLUGINS CONFIGURATIONS "
""""""""""""""""""""""""""

" vim-addon-manager support
fun! SetupVAM()
  let c = get(g:, 'vim_addon_manager', {})
  let g:vim_addon_manager = c
  let c.plugin_root_dir = expand('$HOME', 1) . '/.vim/vim-addons'

  " Force your ~/.vim/after directory to be last in &rtp always:
  let g:vim_addon_manager.rtp_list_hook = 'vam#ForceUsersAfterDirectoriesToBeLast'

  " most used options you may want to use:
  let c.log_to_buf = 1
  " let c.auto_install = 0
  let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'
  if !isdirectory(c.plugin_root_dir.'/vim-addon-manager/autoload')
    execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '
      \ shellescape(c.plugin_root_dir.'/vim-addon-manager', 1)
  endif

  " This provides the VAMActivate command, you could be passing plugin names, too
  call vam#ActivateAddons([], {})
endfun
call SetupVAM()

" Tell VAM which plugins to fetch & load:
VAMActivate BufOnly
VAMActivate fugitive
VAMActivate gitv
VAMActivate Lawrencium
VAMActivate LaTeX-Suite_aka_Vim-LaTeX
VAMActivate matchit.zip
VAMActivate Supertab
VAMActivate Syntastic
VAMActivate The_NERD_Commenter
VAMActivate trailing-whitespace
VAMActivate UltiSnips
" Note, the line below only installs vimproc to the vim-addons directory; you
" still have to compile the plugin with make after it's installed
VAMActivate vimproc
VAMActivate vim-snippets
VAMActivate unite
VAMActivate jedi-vim
VAMActivate utl
VAMActivate github:gotgenes/vim-yapif
VAMActivate vim-gitgutter
VAMActivate vim-go
VAMActivate html5
VAMActivate vim-javascript
VAMActivate typescript-vim
VAMActivate tsuquyomi
VAMActivate virtualenv
VAMActivate vspec
VAMActivate peaksea
VAMActivate Solarized
VAMActivate xoria256
VAMActivate Zenburn


" utl configuration
let g:utl_cfg_hdl_scm_http_system = "silent !firefox -remote 'ping()' && firefox -remote 'openURL( %u )' || firefox '%u#%f' &"
nnoremap <unique> <leader>gu :Utl openLink underCursor edit<CR>
nnoremap <unique> <leader>cl :Utl copyLink underCursor<CR>

" LaTeX Suite configuration
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to alway generate a file-name.
set grepprg=grep\ -nH\ $*
" LaTeX suite default output
let g:Tex_DefaultTargetFormat = "pdf"
let g:Tex_ViewRule_dvi = "evince"
let g:Tex_ViewRule_pdf = "evince"
let g:Tex_ViewRule_ps = "evince"


" NERDCommenter configuration

" Prevent NERDCommenter from complaining about unrecognized filetypes.
let NERDShutUp=1


" UltiSnips configuration
let g:UltiSnipsListSnippets = "<c-tab>"
let g:ultisnips_python_style = "sphinx"


" trailing-whitespace configuration
function ToggleAutoRmTrailingWhitespace()
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


" jedi configuration
let g:jedi#use_tabs_not_buffers = 0


" Unite settings
let g:unite_source_history_yank_enable = 1
call unite#custom#source('file,file_rec,file_rec/async', 'matchers',
      \'matcher_fuzzy')
nnoremap <silent> <leader>ub :<C-u>Unite buffer<CR>
" file-rec/async requires vimproc is installed and compiled
nnoremap <silent> <leader>uf :<C-u>Unite -start-insert file_rec/async<CR>
nnoremap <leader>yh :<C-u>Unite history/yank<CR>


""""""""""""""""""""""""""""""""""""""""""
" Syntax highlighting and color settings "
""""""""""""""""""""""""""""""""""""""""""
syntax enable

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

" Easy access keystrokes for editing your Vim configuration
:nmap <Leader>svrc :source $MYVIMRC<CR>
:nmap <Leader>vrc :tabe $MYVIMRC<CR>

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax enable

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes) in terminals
set sessionoptions+=resize " Allow resizing of the window on session restore

" This moves nicely among unbroken text
noremap j gj
noremap k gk

" My personal programming options

" This function removes trailing whitespace, a pet peeve of mine.
function! DeleteTrailingWhitespace()
  normal m`
  %s/\s\+$//e
  normal ``
endfunction

" give me popup menus for a right mouse-click
set mousemodel=popup

if has("autocmd")
  " Start editing from the last edited position in the file.
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
  filetype plugin indent on
  " This setting makes sure Vim is always operating in the directory of
  " the current buffer
  autocmd BufEnter * lcd %:p:h
  " This setting looks for tags files, recursively upwards
  autocmd FileType python,perl,c setlocal tags+=tags;$HOME
  autocmd FileType python,perl,c,cpp,sh setlocal number expandtab smarttab softtabstop=4 shiftwidth=4 textwidth=72
  autocmd FileType rst setlocal expandtab smarttab softtabstop=4 shiftwidth=4 textwidth=78 spell smartindent
  autocmd FileType vim setlocal expandtab smarttab softtabstop=2 shiftwidth=2
  " Use my Python template if this is a new Python file
  autocmd FileType python nmap <Leader>pyt :0r ~/.vim/templates/python.py<CR>
  if strlen(globpath(&rtp, '$HOME/.vim/plugin/pydoc.vim'))
    autocmd FileType python source $HOME/.vim/plugin/pydoc.vim
  endif
  " this removes trailing extra whitespace from end of lines
  autocmd BufWritePre *.py,*.pl,*.c,*.cpp,*.h,*.tex,*.sh,*.rst call DeleteTrailingWhitespace()
  " Python cTags
  " Make sure to have run
  " ctags -R -f ~/.vim/tags/python.ctags /usr/lib/pythonX.Y/
  " where X is the major version and Y is the point release installed on your
  " system
  autocmd FileType python setlocal tags+=$HOME/.vim/tags/python.ctags
  autocmd FileType python setlocal makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
  autocmd FileType python setlocal efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
  autocmd FileType tex setlocal expandtab smarttab softtabstop=4 shiftwidth=4 tabstop=4 tw=78 spell spelllang=en
  autocmd FileType html,xml,css setlocal autoindent expandtab smarttab softtabstop=2 tabstop=2 shiftwidth=2
  autocmd FileType dot setlocal tabstop=4 shiftwidth=4 tw=78 autoindent
  autocmd FileType Wikipedia setlocal linebreak

  " If you prefer the Omni-Completion tip window to close when a selection is
  " made, these lines close it on movement in insert mode or when leaving
  " insert mode
  autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
  autocmd InsertLeave * if pumvisible() == 0|pclose|endif
endif

" Omni-Completion with Control + X, Control + O is a pain in the ass. Map to 
" Control + Space bar
inoremap <C-space> <C-x><C-o>

" Remap SnippetsEmu key from tab to Shift-Tab
let g:snippetsEmu_key = "<S-Tab>"


" Placed in here for LaTeX Suite
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to alway generate a file-name.
set grepprg=grep\ -nH\ $*

" Set our Django version
let django_version = 1

" awesome remapping to open tags in new tab
nnoremap <F2> <C-W>]<C-W>T

" I use NERDCommenter, which complains when it doesn't recognize a
" filetype; this keeps it from bitching.
let NERDShutUp=1

" Choose my favorite color scheme
if strlen(globpath(&rtp, 'colors/peaksea.vim'))
    colorscheme peaksea
endif

" Uncomment below to get a dark background.
set background=dark

" I want to quickly switch to text settings sometimes.
nmap <Leader>ts :setlocal ai et sts=4 sw=4 ts=4 tw=78 spell<CR>

" UTL browser configuration
let g:utl_rc_app_browser = "silent !firefox -remote 'ping()' && firefox -remote 'openURL( %u )' || firefox '%u' &"

" LaTeX suite default output
let g:Tex_DefaultTargetFormat = "pdf"

" Vim R plugin
let g:vimrplugin_term_cmd = "gnome-terminal -t R -x"

set runtimepath^=~/.vim runtimepath+=~/.vim/after

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
" (Helpful with SimpylFold)
set foldlevelstart=2

" Increase cmdheight
set cmdheight=2

" Set completion options
set completeopt=menuone,noselect


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
nmap <space> za
vnoremap <space> zf

" Close help window
nnoremap <silent> <leader>hc :helpclose<CR>


""""""""""""""""""""
" autocmd settings "
""""""""""""""""""""

" Start editing a previously opened file from the position of the most
" recent edit.
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif
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


"""""""""""""""""""
" INSTALL PLUGINS "
"""""""""""""""""""
lua require('plugins')
autocmd BufWritePost plugins.lua source <afile> | PackerCompile


""""""""""""""""""""""""""
" PLUGINS CONFIGURATIONS "
""""""""""""""""""""""""""

" easyescape configuration
let g:easyescape_chars = { "j": 1, "k": 1 }
let g:easyescape_timeout = 300
cnoremap jk <ESC>
cnoremap kj <ESC>


" lightline configuration
let g:lightline = {}
let g:lightline.colorscheme = 'base16_eighties'
let g:lightline.active = {
      \ 'left': [ [ 'mode', 'paste' ],
      \           [ 'gitbranch', 'readonly', 'filename_active', 'modified'] ],
      \ 'right': [ [ 'lsp_status', 'lsp_errors', 'lsp_warnings', 'lsp_info', 'lsp_hints', 'lsp_ok', 'lineinfo' ],
      \            [ 'percent' ],
      \            [ 'fileformat', 'fileencoding', 'filetype' ]]
      \ }
let g:lightline.inactive = {
      \ 'left': [ [ 'filename_inactive' ] ],
      \ 'right': [ [ 'lineinfo' ],
      \            [ 'percent' ] ]
      \ }
let g:lightline.component_function = {
      \ 'fileencoding': 'LightlineFileEncoding',
      \ 'fileformat': 'LightlineFileFormat',
      \ 'filename_active': 'LightlineFileNameActive',
      \ 'filename_inactive': 'LightlineFileNameInactive',
      \ 'filetype': 'LightlineFileType',
      \ 'gitbranch': 'LightlineGitBranch',
      \ 'lineinfo': 'LightlineLineInfo',
      \ 'mode': 'LightlineMode',
      \ 'percent': 'LightlinePercent',
      \ 'readonly': 'LightlineReadonly',
      \ }

let lightline_ft_visible_condition = '&ft !~ "defx\\|denite\\|denite-filter\\|help\\|tagbar"'

let g:lightline.component_function_visible_condition = {
      \ 'fileencoding': lightline_ft_visible_condition,
      \ 'fileformat': lightline_ft_visible_condition,
      \ 'filetype': lightline_ft_visible_condition,
      \ 'lineinfo': lightline_ft_visible_condition,
      \ 'percent': lightline_ft_visible_condition
      \ }

let g:lightline.separator = { 'left': "", 'right': '' }
let g:lightline.subseparator = { 'left': '', 'right': '' }

function! LightlineIsExcludedFileType()
  return (&ft =~? 'defx\|denite\|denite-filter\|help\|tagbar\|Mundo\|MundoDiff')
endfunction

function! LightlineMode()
  return (&ft == 'tagbar' ? 'Tagbar' :
        \ &ft == 'defx' ? 'Defx' :
        \ &ft == 'denite' ? 'Denite' :
        \ &ft == 'help' ? 'Help' :
        \ &ft == 'Mundo' ? 'Mundo' :
        \ &ft == 'MundoDiff' ? 'MundoDiff' :
        \ winwidth(0) > 60 ? lightline#mode() : '')
endfunction

function! LightlineGitBranch()
  try
    if !LightlineIsExcludedFileType() && exists('*FugitiveHead')
      let mark = ' '  " edit here for cool mark
      let branch = FugitiveHead()
      return branch !=# '' ? mark.branch : ''
    endif
  catch
  endtry
  return ''
endfunction

function! LightlineReadonly()
  return !LightlineIsExcludedFileType() && &readonly ? 'RO' : ''
endfunction

function! LightlineFileNameActive()
  return LightlineFileName(1)
endfunction

function! LightlineFileNameInactive()
  return LightlineFileName(0)
endfunction

function! LightlineFileName(active)
  return (&ft == 'defx' && a:active ? '' :
        \ &ft == 'defx' && !a:active ? 'defx' :
        \ &ft == 'tagbar' && a:active ? '' :
        \ &ft == 'tagbar' && !a:active ? 'tagbar' :
        \ &ft == 'denite' ? denite#get_status('sources') :
        \ &ft == 'denite' ? denite#get_status('sources') :
        \ &ft == 'Mundo' && a:active ? '' :
        \ &ft == 'Mundo' &&  !a:active ? 'Mundo' :
        \ &ft == 'MundoDiff' && a:active ? '' :
        \ &ft == 'MundoDiff' && !a:active ? 'MundoDiff' :
        \ expand('%:t') != '' ? expand('%:t') : '[No Name]')
endfunction

function! LightlineLineInfo()
  return (LightlineIsExcludedFileType() ? '' :
        \ printf('%3d:%-2d', line('.'), col('.')))
endfunction

function! LightlinePercent()
  return (LightlineIsExcludedFileType() ? '' :
        \ (100 * line('.') / line('$')) . '%')
endfunction

function! LightlineFileEncoding()
  return (LightlineIsExcludedFileType() ? '' :
        \ winwidth(0) > 70 ? &fileencoding : '')
endfunction

function! LightlineFileFormat()
  return (LightlineIsExcludedFileType() ? '' :
        \ winwidth(0) > 70 ? &fileformat : '')
endfunction

function! LightlineFileType()
  return (LightlineIsExcludedFileType() ? '' :
        \ winwidth(0) > 70 ? (&filetype !=# '' ? &filetype: '[No Filetype]') : '')
endfunction


" lightline-lsp configuration
call lightline#lsp#register()
let g:lightline#lsp#indicator_errors = "\uf05e"
let g:lightline#lsp#indicator_warnings = "\uf071"
let g:lightline#lsp#indicator_infos = "\uf129"
let g:lightline#lsp#indicator_hints = "\uf835"
let g:lightline#lsp#indicator_ok = "\uf00c"


" utl configuration
let g:utl_cfg_hdl_scm_http_system = "silent !open %u"
nnoremap <leader>gu :Utl openLink underCursor edit<CR>
nnoremap <leader>cl :Utl copyLink underCursor<CR>


" defx configuration
autocmd BufWritePost * call defx#redraw()
nnoremap <silent><leader>fl :Defx -split=vertical -winwidth=50 -direction=topleft<CR>
nnoremap <silent><leader>ft :Defx -toggle -resume -split=vertical -winwidth=50 -direction=topleft<CR>
nnoremap <silent><leader>fc :Defx -resume -split=vertical -winwidth=50 -direction=topleft -search=`expand('%:p')` `getcwd()`<CR>
call defx#custom#option('_', {
      \ 'columns': 'indent:icons:filename:type:git',
      \ })
autocmd FileType defx call s:defx_my_settings()

function! s:defx_my_settings() abort
  " Define mappings
  nnoremap <silent><buffer><expr> <CR>
        \ defx#is_directory() ?
        \ defx#do_action('open_tree', 'toggle') :
        \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> c
        \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> m
        \ defx#do_action('move')
  nnoremap <silent><buffer><expr> p
        \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> l
        \ defx#do_action('open')
  nnoremap <silent><buffer><expr> E
        \ defx#do_action('open', 'vsplit')
  nnoremap <silent><buffer><expr> P
        \ defx#do_action('preview')
  nnoremap <silent><buffer><expr> o
        \ defx#do_action('open_tree', 'toggle')
  nnoremap <silent><buffer><expr> K
        \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N
        \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> S
        \ defx#do_action('toggle_sort', 'time')
  nnoremap <silent><buffer><expr> d
        \ defx#do_action('remove')
  nnoremap <silent><buffer><expr> r
        \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> !
        \ defx#do_action('execute_command')
  nnoremap <silent><buffer><expr> x
        \ defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> yy
        \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> .
        \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> ;
        \ defx#do_action('repeat')
  nnoremap <silent><buffer><expr> h
        \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> ~
        \ defx#do_action('cd')
  nnoremap <silent><buffer><expr> q
        \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> <Space>
        \ defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> *
        \ defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> j
        \ line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k
        \ line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> <C-l>
        \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g>
        \ defx#do_action('print')
  nnoremap <silent><buffer><expr> cd
        \ defx#do_action('change_vim_cwd')
endfunction


" Tagbar configuration
let g:tagbar_no_status_line = 1


" Mundo configuration
let g:mundo_right = 1


" vim-better-whitespace configuration
nnoremap <silent> <leader>rws :ToggleStripWhitespaceOnSave<CR>
nnoremap <silent> <leader>hws :ToggleWhitespace<CR>

if has("autocmd")
  autocmd BufEnter * EnableStripWhitespaceOnSave
endif

highlight link ExtraWhitespace Error


" tab-completion
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-N>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-P>" : "\<C-H>"


" SimpylFold configuration
let g:SimpylFold_fold_docstring = 0


" projectroot settings
nnoremap <silent> <leader>cdp :ProjectRootCD<CR>
nnoremap <silent> <leader>ntp :ProjectRootExe NERDTreeFind<CR>


" fruzzy settings
let g:fruzzy#usenative = 0
let g:fruzzy#sortonempty = 0


" Denite settings
autocmd FileType denite call s:denite_my_mappings()
function! s:denite_my_mappings() abort
  nnoremap <silent><buffer><expr> <CR>
    \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> q
    \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> a
    \ denite#do_map('choose_action')
  nnoremap <silent><buffer><expr> dd
    \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> <C-l>
    \ denite#do_map('redraw')
  nnoremap <silent><buffer><expr> i
    \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>
    \ denite#do_map('toggle_select')
endfunction

call denite#custom#option('_', 'statusline', v:false)

call denite#custom#source('_', 'matchers', ['matcher/fruzzy'])
call denite#custom#source('file,file/rec', 'sorters', ['sorter/rank'])
call denite#custom#source('grep', 'converters', ['converter/abbr_word'])

if executable('rg')
  call denite#custom#var('file/rec', 'command',
        \ ['rg', '--files', '--hidden', '--glob', '!.git', '--color', 'never'])
  call denite#custom#var('grep', 'command', ['rg'])
  call denite#custom#var('grep', 'default_opts',
        \ ['-i', '--vimgrep', '--no-heading'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'final_opts', [])
elseif executable('ag')
  call denite#custom#var('file/rec', 'command',
        \ ['ag', '--follow', '--nocolor', '--nogroup', '--hidden', '--ignore', '.git', '-g', ''])
  call denite#custom#var('grep', 'command', ['ag'])
  call denite#custom#var('grep', 'default_opts',
        \ ['-i', '--vimgrep'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'pattern_opt', [])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'final_opts', [])
endif

nnoremap <silent> <leader>db :<C-u>Denite buffer<CR>
nnoremap <silent> <leader>df :<C-u>Denite -start-filter file/rec<CR>
nnoremap <silent> <leader>dp :<C-u>DeniteProjectDir -start-filter file/rec<CR>
nnoremap <silent> <leader>dg :<C-u>Denite grep<CR><CR>
nnoremap <silent> <leader>dh :<C-u>Denite -start-filter help<CR>
nnoremap <silent> <leader>dy :<C-u>Denite neoyank<CR>
nnoremap <silent> <leader>dr :<C-u>Denite -resume<CR>


" vim-python configuration
let g:python_highlight_all = 1


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


" vim-markdown configuration
let g:vim_markdown_folding_disabled = 1


" base16 configuration
let g:base16colorspace=256

""""""""""""""""""""""""""""""""""""""""""
" Syntax highlighting and color settings "
""""""""""""""""""""""""""""""""""""""""""

set termguicolors

colorscheme base16-eighties
highlight HtmlBold gui=bold
highlight HtmlItalic gui=italic

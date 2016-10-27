setlocal tabstop=4
setlocal shiftwidth=4
setlocal noexpandtab
setlocal formatoptions+=croq


let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

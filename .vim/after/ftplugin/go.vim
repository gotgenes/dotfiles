setlocal tabstop=4
setlocal shiftwidth=4
setlocal noexpandtab
setlocal formatoptions+=croq


let g:syntastic_go_checkers = ['go', 'golint', 'govet', 'errcheck']

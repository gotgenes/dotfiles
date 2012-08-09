" Language:     hg commit file
" Author:       Dan LaMotte <lamo0070@umn.edu>
" Filenames:    ^hg-editor-*.txt
" Last Change:  2009/04/30

if exists("b:current_syntax")
    finish
endif

syn match hgcommitComment   "^HG: .*"
syn match hgcommitOnBranch  "\%(^HG: \)\@<=\<branch\> '" contained containedin=hgcommitComment nextgroup=hgcommitBranch
syn match hgcommitBranch    "[^']\+" contained
syn match hgcommitAdded     "\%(^HG: \)\@<=\<added\>" contained containedin=hgcommitComment nextgroup=hgcommitFile
syn match hgcommitChanged   "\%(^HG: \)\@<=\<changed\>" contained containedin=hgcommitComment nextgroup=hgcommitFile
syn match hgcommitRemoved   "\%(^HG: \)\@<=\<removed\>" contained containedin=hgcommitComment nextgroup=hgcommitFile
syn match hgcommitFile      " \S\+" contained containedin=hgcommitAdded,hgcommitChanged

hi def link hgcommitComment         Comment
hi def link hgcommitOnBranch        Comment
hi def link hgcommitBranch          Special
hi def link hgcommitOnBranchEnd     Comment
hi def link hgcommitAdded           Type
hi def link hgcommitChanged         Type
hi def link hgcommitRemoved         Type
hi def link hgcommitFile            Constant

let b:current_syntax = "hgcommit"

" Catppuccin Mocha (legacy Vim 7.4 approximation)
set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "catppuccin_mocha_legacy"

" Base
hi Normal       ctermfg=252 ctermbg=234
hi CursorLine   ctermbg=235 cterm=NONE
hi LineNr       ctermfg=240 ctermbg=234
hi CursorLineNr ctermfg=179 ctermbg=235

" Comments
hi Comment      ctermfg=244 cterm=italic

" Constants / Strings
hi String       ctermfg=150
hi Constant     ctermfg=173
hi Character    ctermfg=150

" Identifiers / Functions
hi Identifier   ctermfg=181
hi Function     ctermfg=110

" Statements / Keywords
hi Statement    ctermfg=176
hi Keyword      ctermfg=176
hi Conditional  ctermfg=176
hi Repeat       ctermfg=176

" Types
hi Type         ctermfg=180
hi StorageClass ctermfg=180
hi Structure    ctermfg=180

" Preprocessor
hi PreProc      ctermfg=141
hi Include      ctermfg=141
hi Define       ctermfg=141

" UI
hi StatusLine   ctermfg=252 ctermbg=237
hi StatusLineNC ctermfg=244 ctermbg=235
hi VertSplit    ctermfg=235 ctermbg=235
hi Visual       ctermbg=238
hi Search       ctermfg=234 ctermbg=179
hi IncSearch    ctermfg=234 ctermbg=180

" Errors
hi Error        ctermfg=203 ctermbg=234
hi Todo         ctermfg=234 ctermbg=180

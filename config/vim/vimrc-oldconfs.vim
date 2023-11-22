" VIMRC {{{1
"" Function to source only if file exists
"function! SourceIfExists(file)
"  if filereadable(expand(a:file))
"    exe 'source' a:file
"  endif
"endfunction
"
"call SourceIfExists("$path_dotrepo/config/vim/vimrc-plugins.vim")

"    nnoremap <leader>rp             :RainbowParentheses!!<CR>
"1}}}

" VIMRC-Plugins {{{1

" Rainbow Parentheses
    let g:rainbow#max_level=16
    let g:rainbow#pairs=[['(', ')'], ['[', ']'], ['<', '>'], ['{', '}']]

    "let g:rainbow#blacklist=[233, 234]   " List of colors that you do not want. ANSI code or #RRGGBB

    "augroup rainbow_lisp
    "  autocmd!
    "  autocmd FileType lisp,clojure,scheme RainbowParentheses
    "augroup END
"1}}}

" Status Line Symbols {{{1
"Bar
"NORMAL   master⚡  README.md[+] =%= markdown  utf-8[unix]  120 words  66% :33/50☰ ℅:15  ☲ [42]trailing 
"NORMAL   masterɆ  vimrc-oldconfs.vim[+] =%= vim  utf-8[unix]  93% :14/15☰ ℅:1  ☲ [15]trailing
"NORMAL   master⚡  vimrc =%= vim  utf-8[unix]  98% :165/168☰ ℅:1
"1}}}

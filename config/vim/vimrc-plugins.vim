" Airline
    let g:airline_left_sep=''                                   " Alt ''
    let g:airline_right_sep=''                                  " Alt ''
    let g:airline#extensions#tabline#formatter='unique_tail'    " File paths in tabline enabled themes
    let g:airline_powerline_fonts=1                             " Use powerline fonts (eg. instead of bars, use triangles)
    let g:airline_theme='badwolf'
    "let g:airline_theme='powerlineish'
    "let g:airline_theme='jellybean'
    "let g:airline_theme='murmur'
    "let g:airline_theme='tomorrow'

    "NOTE: Tablines are performance expensive.
    "let g:airline#extensions#tabline#enabled=1
    "let g:airline#extensions#tabline#left_sep=' '
    "let g:airline#extensions#tabline#left_alt_sep='|'

" FZF-Vim
    let g:fzf_layout={ 'window': { 'width': 1.0, 'height': 0.6, 'relative': v:true, 'yoffset': 1.0 } }    " - Popup window (anchored to the bottom of the current window)

    " FZF_DEFAULT_OPTS in .zshrc has --layout=reverse. Since in vim the prompt is at the bottom, I prefer the default layout
    command! -bang -nargs=? -complete=dir Files
        \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse-list', '--preview-label=[File Content]', '--preview-window=nohidden']}), <bang>0)

    "command! -bang -nargs=? GitFiles
    "    \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse-list']}), <bang>0)

    command! -bang -nargs=? GFiles
        \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse-list', '--preview-label=[File Content]', '--preview-window=nohidden']}), <bang>0)

    command! -bar -bang -nargs=? -complete=buffer Buffers
        \ call fzf#vim#buffers(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse-list']}), <bang>0)

    command! -bang -nargs=* Lines
        \ call fzf#vim#lines(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse-list']}), <bang>0)

    command! -bang -nargs=* BLines
        \ call fzf#vim#buffer_lines(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse-list']}), <bang>0)

    command! -bar -bang Commands
        \ call fzf#vim#commands(fzf#vim#with_preview({'options': ['--layout=reverse-list']}), <bang>0)

    command! -bar -bang -nargs=* -range=% -complete=file Commits
        \ let b:fzf_winview = winsaveview() |
        \ <line1>,<line2>call fzf#vim#commits(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse-list'], "placeholder": "" }), <bang>0)

    command! -bar -bang -nargs=* -range=% BCommits
        \ let b:fzf_winview = winsaveview() |
        \ <line1>,<line2>call fzf#vim#buffer_commits(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse-list'], "placeholder": "" }), <bang>0)

    command! -bar -bang Maps
        \ call fzf#vim#maps("n", fzf#vim#with_preview({'options': ['--layout=reverse-list']}), <bang>0)

" Goyo
    let g:goyo_width=150
    let g:goyo_margin_top=5
    let g:goyo_margin_bottom=5

" Limelight
    " let g:limelight_default_coefficient = 0.7     " Default 0.5
    autocmd! User GoyoEnter Limelight
    autocmd! User GoyoLeave Limelight!

" Undotree
    let g:undotree_WindowLayout=4
    let g:undotree_SplitWidth=42
    let g:undotree_SetFocusWhenToggle=1

" HighlightedYank
    let g:highlightedyank_highlight_duration=1000     " -1 = persistent"

" Better WhiteSpace
    let g:better_whitespace_enabled=0
    let g:strip_whitespace_on_save=0

    let g:better_whitespace_ctermcolor='Blue'
    "let g:better_whitespace_filetypes_blacklist=['<filetype1>', '<filetype2>', '<etc>'] "Defaults: ['diff', 'git', 'gitcommit', 'unite', 'qf', 'help', 'markdown', 'fugitive']

" Indent Guide
    "let g:indent_guides_enable_on_vim_startup=1
    let g:indent_guides_start_level=2
    let g:indent_guides_guide_size=1

" Disable netrw
    let g:loaded_netrw=1
    let g:loaded_netrwPlugin=1

" VimTeX
    let g:vimtex_view_method = 'zathura'
    "let g:vimtex_fold_enabled
    "let g:vimtex_format_enabled

" lsp
"   call LspAddServer([#{
"       \    name: 'clangd',
"       \    filetype: ['c', 'cpp'],
"       \    path: '/usr/local/bin/clangd',
"       \    args: ['--background-index']
"       \  }])

"   call LspOptionsSet(#{
"       \   aleSupport: v:false,
"       \   autoComplete: v:true,
"       \   autoHighlight: v:false,
"       \   autoHighlightDiags: v:true,
"       \   autoPopulateDiags: v:false,
"       \   completionMatcher: 'case',
"       \   completionMatcherValue: 1,
"       \   diagSignErrorText: 'E>',
"       \   diagSignHintText: 'H>',
"       \   diagSignInfoText: 'I>',
"       \   diagSignWarningText: 'W>',
"       \   echoSignature: v:false,
"       \   hideDisabledCodeActions: v:false,
"       \   highlightDiagInline: v:true,
"       \   hoverInPreview: v:false,
"       \   ignoreMissingServer: v:false,
"       \   keepFocusInDiags: v:true,
"       \   keepFocusInReferences: v:true,
"       \   completionTextEdit: v:true,
"       \   diagVirtualTextAlign: 'above',
"       \   diagVirtualTextWrap: 'default',
"       \   noNewlineInCompletion: v:false,
"       \   omniComplete: v:null,
"       \   outlineOnRight: v:false,
"       \   outlineWinSize: 20,
"       \   semanticHighlight: v:true,
"       \   showDiagInBalloon: v:true,
"       \   showDiagInPopup: v:true,
"       \   showDiagOnStatusLine: v:false,
"       \   showDiagWithSign: v:true,
"       \   showDiagWithVirtualText: v:false,
"       \   showInlayHints: v:false,
"       \   showSignature: v:true,
"       \   snippetSupport: v:false,
"       \   ultisnipsSupport: v:false,
"       \   useBufferCompletion: v:false,
"       \   usePopupInCodeAction: v:false,
"       \   useQuickfixForLocations: v:false,
"       \   vsnipSupport: v:false,
"       \   bufferCompletionTimeout: 100,
"       \   customCompletionKinds: v:false,
"       \   completionKinds: {},
"       \   filterCompletionDuplicates: v:false,
"       \ })

" Disabled (Deprecated)
    " Rainbow Parentheses
    "let g:rainbow#max_level=16
    "let g:rainbow#pairs=[['(', ')'], ['[', ']'], ['<', '>'], ['{', '}']]

    "let g:rainbow#blacklist=[233, 234]   " List of colors that you do not want. ANSI code or #RRGGBB

    "augroup rainbow_lisp
    "  autocmd!
    "  autocmd FileType lisp,clojure,scheme RainbowParentheses
    "augroup END
"

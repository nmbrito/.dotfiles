let SessionLoad = 1
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
inoremap <silent> <Plug>(-fzf-complete-finish) l
imap <C-G>S <Plug>ISurround
imap <C-G>s <Plug>Isurround
imap <C-S> <Plug>Isurround
inoremap <silent> <Plug>(fzf-maps-i) :call fzf#vim#maps('i', 0)
inoremap <expr> <Plug>(fzf-complete-buffer-line) fzf#vim#complete#buffer_line()
inoremap <expr> <Plug>(fzf-complete-line) fzf#vim#complete#line()
inoremap <expr> <Plug>(fzf-complete-file-ag) fzf#vim#complete#path('ag -l -g ""')
inoremap <expr> <Plug>(fzf-complete-file) fzf#vim#complete#path("find . -path '*/\.*' -prune -o -type f -print -o -type l -print | sed 's:^..::'")
inoremap <expr> <Plug>(fzf-complete-path) fzf#vim#complete#path("find . -path '*/\.*' -prune -o -print | sed '1d;s:^..::'")
inoremap <expr> <Plug>(fzf-complete-word) fzf#vim#complete#word()
inoremap <C-K> 
inoremap <C-J> 
inoremap <F1> 	
nnoremap  h
nnoremap <NL> j
nnoremap  k
nnoremap  l
map [3~ x
map OE i
map O5C w
map O5D b
map O5B ^F
map O5A ^B
map O2C w
map O2D b
map O2B ^F
map O2A ^B
map [3;5~ x
map [2;5~ i
map [3;2~ x
map [2;2~ i
map O5F $
map O5H 0
map O2F $
map O2H 0
map OF $
map OH 0
map [E i
map [D h
map [C l
map [B j
map [A k
map [4~ $
map [1~ 0
map [F $
map [H 0
map On .
map Op 0
map Os 3
map Or 2
map Oq 1
map Ov 6
map Ou 5
map Ot 4
map Oy 9
map Ox 8
map Ow 7
map OM 
map Ol ,
map Ok +
map Om -
map Oj *
map Oo :
nmap <silent>  ig <Plug>IndentGuidesToggle
nmap <silent>  s  :exe ".,+".v:count" StripWhitespace"
xmap <silent>  s :StripWhitespace
nnoremap  wss :ToggleStripWhitespaceOnSave
nnoremap  ws :ToggleWhitespace
nnoremap  rp :RainbowParentheses!!
vnoremap  c "_c
nnoremap  c "_c
vnoremap  d "_d
nnoremap  d "_d
nnoremap  V :vert sb 
nnoremap  H :sb 
nnoremap  v :vsp
nnoremap  h :sp
nnoremap  <S-Del> :bwipeout
nnoremap  <C-Del> :bdelete 
nnoremap  <Del> :bdelete
nnoremap  <PageUp> :bnext
nnoremap  <PageDown> :bprevious
nnoremap <silent>  cm :colorscheme molokai
nnoremap <silent>  cj :colorscheme jellybeans
nnoremap <silent>  cs :colorscheme slate
nnoremap  <S-F11> :source ${path_vimsessions}/current_session.vim
nnoremap  <F5> :wq!
nnoremap <silent> // :BLines
map! 3~ <Del>
map! 2~ <Insert>
map! 6~ <PageDown>
map! 5~ <PageUp>
map! D <Left>
map! C <Right>
map! B <Down>
map! A <Up>
map! F <End>
map! H <Home>
map! n .
map! p 0
map! s 3
map! r 2
map! q 1
map! v 6
map! u 5
map! t 4
map! y 9
map! x 8
map! w 7
map! M 
map! l ,
map! k +
map! m -
map! j *
map! o :
nnoremap H >
vnoremap J :m '>+1gv=gv
nnoremap J +
vnoremap K :m '>-2gv=gv
nnoremap K -
nnoremap L <
xmap S <Plug>VSurround
nnoremap <silent> a// :Lines
nmap cS <Plug>CSurround
nmap cs <Plug>Csurround
nmap ds <Plug>Dsurround
nnoremap <silent> f// :BLines!
xmap gS <Plug>VgSurround
nnoremap <silent> gc :Commits
nnoremap <silent> gf :GFiles
nmap ySS <Plug>YSsurround
nmap ySs <Plug>YSsurround
nmap yss <Plug>Yssurround
nmap yS <Plug>YSurround
nmap ys <Plug>Ysurround
nnoremap <silent> <Plug>(-fzf-complete-finish) a
nnoremap <Plug>(-fzf-:) :
nnoremap <Plug>(-fzf-/) /
nnoremap <Plug>(-fzf-vim-do) :execute g:__fzf_command
nnoremap <SNR>82_: :=v:count ? v:count : ''
nnoremap <silent> <Plug>SurroundRepeat .
nmap <silent> <Plug>CommentaryUndo :echoerr "Change your <Plug>CommentaryUndo map to <Plug>Commentary<Plug>Commentary"
xnoremap <silent> <Plug>(Limelight) :Limelight
nnoremap <silent> <Plug>(Limelight) :set opfunc=limelight#operatorg@
onoremap <silent> <Plug>(fzf-maps-o) :call fzf#vim#maps('o', 0)
xnoremap <silent> <Plug>(fzf-maps-x) :call fzf#vim#maps('x', 0)
nnoremap <silent> <Plug>(fzf-maps-n) :call fzf#vim#maps('n', 0)
tnoremap <silent> <Plug>(fzf-normal) 
tnoremap <silent> <Plug>(fzf-insert) i
nnoremap <silent> <Plug>(fzf-normal) <Nop>
nnoremap <silent> <Plug>(fzf-insert) i
nnoremap <M-C-L> L
nnoremap <M-C-K> K
nnoremap <M-C-J> J
nnoremap <M-C-H> H
nnoremap <C-L> l
nnoremap <C-K> k
nnoremap <C-J> j
nnoremap <C-H> h
nnoremap <silent> <F12> :sp ${path_dotrepo}/RTM.md
nnoremap <S-F11> :mksession! ${path_vimsessions}/current_session.vim
nnoremap <F7> :let _s=@/|:%s/\s\+$//e|:let @/=_s|
nnoremap <silent> <F6> :Buffers
nnoremap <F5> :w!
nnoremap <silent> <F4> :UndotreeToggle
nnoremap <silent> <F3> :Goyo
nnoremap <silent> <S-F2> :Files %:p:h
nnoremap <silent> <F2> :Files
imap S <Plug>ISurround
imap s <Plug>Isurround
inoremap <NL> 
inoremap  
imap  <Plug>Isurround
map! [3~ <Del>
map! OE <Insert>
map! O5D <S-Left>
map! O5C <S-Right>
map! O5B <PageDown>
map! O5A <PageUp>
map! O2D <S-Left>
map! O2C <S-Right>
map! O2B <PageDown>
map! O2A <PageUp>
map! [3;5~ <Del>
map! [2;5~ <Insert>
map! [3;2~ <Del>
map! [2;2~ <Insert>
map! O5F <End>
map! O5H <Home>
map! O2F <End>
map! O2H <Home>
map! OF <End>
map! OH <Home>
map! [E <Insert>
map! [D <Left>
map! [C <Right>
map! [B <Down>
map! [A <Up>
map! [4~ <End>
map! [1~ <Home>
map! [F <End>
map! [H <Home>
map! On .
map! Op 0
map! Os 3
map! Or 2
map! Oq 1
map! Ov 6
map! Ou 5
map! Ot 4
map! Oy 9
map! Ox 8
map! Ow 7
map! OM 
map! Ol ,
map! Ok +
map! Om -
map! Oj *
map! Oo :
nnoremap  L
nnoremap  K
nnoremap  J
nnoremap  H
map E i
map 3~ <Del>
map 2~ <Insert>
map 6~ <PageDown>
map 5~ <PageUp>
map D h
map C l
map B j
map A k
map F $
map H 0
map n .
map p 0
map s 3
map r 2
map q 1
map v 6
map u 5
map t 4
map y 9
map x 8
map w 7
map M 
map l ,
map k +
map m -
map j *
map o :
let &cpo=s:cpo_save
unlet s:cpo_save
set autoindent
set background=dark
set backspace=indent,eol,start
set expandtab
set fileencodings=ucs-bom,utf-8,default,latin1
set helplang=en
set hidden
set incsearch
set laststatus=2
set omnifunc=syntaxcomplete#Complete
set ruler
set runtimepath=~/.vim,~/.vim/pack/tpope/start/surround,~/.vim/pack/tpope/start/fugitive,~/.vim/pack/tpope/start/commentary,~/.vim/pack/preservim/start/vim-indent-guides,~/.vim/pack/ntpeters/start/vim-better-whitespace,~/.vim/pack/mbbill/start/undotree,~/.vim/pack/machakann/start/vim-highlightedyank,~/.vim/pack/junegunn/start/rainbow_parentheses.vim,~/.vim/pack/junegunn/start/limelight.vim,~/.vim/pack/junegunn/start/goyo.vim,~/.vim/pack/junegunn/start/fzf.vim,~/.vim/pack/junegunn/start/fzf,~/.vim/pack/dist/start/vim-airline-themes,~/.vim/pack/dist/start/vim-airline,~/.vim/pack/css-color/start/css-color,/usr/share/vim/site,/usr/share/vim/vim90,~/.vim/pack/css-color/start/css-color/after,/usr/share/vim/site/after,~/.vim/after
set shiftwidth=4
set showcmd
set showmatch
set noshowmode
set showtabline=2
set smartindent
set smarttab
set splitbelow
set splitright
set tabline=%!airline#extensions#tabline#get()
set tabstop=4
set textwidth=185
set undodir=~/.cache
set undofile
set wildmenu
set wildmode=longest,list,full
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/Documents/GitRepositories/.dotserver/INSTALL
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +80 setup.sh
badd +1 functions.sh
badd +35 software.sh
badd +1 unsetup.sh
argglobal
%argdel
$argadd setup.sh
edit setup.sh
argglobal
balt functions.sh
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal backupcopy=
setlocal balloonexpr=
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinscopedecls=public,protected,private
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=:#
setlocal commentstring=#\ %s
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
set conceallevel=2
setlocal conceallevel=2
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
setlocal nocursorline
setlocal cursorlineopt=both
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'sh'
setlocal filetype=sh
endif
setlocal fillchars=
setlocal fixendofline
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
set foldmethod=marker
setlocal foldmethod=marker
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=croql
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatprg=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=
setlocal includeexpr=
setlocal indentexpr=GetShIndent()
setlocal indentkeys=0{,0},0),0],!^F,o,O,e,0=then,0=do,0=else,0=elif,0=fi,0=esac,0=done,0=end,),0=;;,0=;&,0=fin,0=fil,0=fip,0=fir,0=fix
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal lispoptions=
setlocal lispwords=
setlocal nolist
setlocal listchars=
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=bin,octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=syntaxcomplete#Complete
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
set relativenumber
setlocal relativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal scrolloff=-1
setlocal shiftwidth=4
setlocal noshortname
setlocal showbreak=
setlocal sidescrolloff=-1
setlocal signcolumn=auto
setlocal nosmartindent
setlocal nosmoothscroll
setlocal softtabstop=0
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal spelloptions=
setlocal statusline=%!airline#statusline(1)
setlocal suffixesadd=
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'sh'
setlocal syntax=sh
endif
setlocal tabstop=4
setlocal tagcase=
setlocal tagfunc=
setlocal tags=
setlocal termwinkey=
setlocal termwinscroll=10000
setlocal termwinsize=
setlocal textwidth=185
setlocal thesaurus=
setlocal thesaurusfunc=
setlocal undofile
setlocal undolevels=-123456
setlocal varsofttabstop=
setlocal vartabstop=
setlocal virtualedit=
setlocal wincolor=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
let s:l = 111 - ((0 * winheight(0) + 18) / 36)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 111
normal! 0
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
set shortmess=filnxtToOS
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :

lua require('plugins')

filetype plugin indent on
syntax on

let g:mapleader=','

" allow using ` in tmux
nnoremap ` '
nnoremap ' `

" terminal {{{
set mouse=nv
set termguicolors
set title
" }}}

" display {{{
set lazyredraw
set noshowmode
set shortmess+=c

  " line numbers {{{
  set number
  set numberwidth=5
  " }}}

  " cursor crosshair {{{
  set cursorline
  set cursorcolumn
  " }}}

  " matching brackets {{{
  set showmatch
  set matchtime=2
  " }}}

  " list {{{
  set list
  set listchars=eol:↩,tab:‣\ ,extends:»,precedes:«,nbsp:␣
  nnoremap <silent><Leader>l :set invlist list?<CR>
  " }}}

  " wrap {{{
  set textwidth=100
  set nowrap
  set linebreak
  set colorcolumn=100

  function! ToggleWrap() "{{{
    if &wrap
      echo "wrap off"
      setlocal nowrap
      silent! nunmap <buffer>k
      silent! nunmap <buffer>j
      silent! nunmap <buffer>0
      silent! nunmap <buffer>^
      silent! nunmap <buffer>$
      silent! nunmap <buffer><Up>
      silent! nunmap <buffer><Down>
      silent! nunmap <buffer><Home>
      silent! nunmap <buffer><End>
      silent! iunmap <buffer><Up>
      silent! iunmap <buffer><Down>
      silent! iunmap <buffer><Home>
      silent! iunmap <buffer><End>
    else
      echo "wrap on"
      setlocal wrap display+=lastline
      noremap  <buffer><silent>k gk
      noremap  <buffer><silent>j gj
      noremap  <buffer><silent>0 g0
      noremap  <buffer><silent>^ g^
      noremap  <buffer><silent>$ g$
      noremap  <buffer><silent><Up>   gk
      noremap  <buffer><silent><Down> gj
      noremap  <buffer><silent><Home> g<Home>
      noremap  <buffer><silent><End>  g<End>
      inoremap <buffer><silent><Up>   <C-o>gk
      inoremap <buffer><silent><Down> <C-o>gj
      inoremap <buffer><silent><Home> <C-o>g<Home>
      inoremap <buffer><silent><End>  <C-o>g<End>
    endif
  endfunction "}}}
  nnoremap <silent><Leader>r <cmd>call ToggleWrap()<CR>
  " }}}

  " fold {{{
  set foldmethod=marker
  nnoremap <silent><Space> @=(foldlevel('.')?'za':'30j')<CR>
  vnoremap <Space> zf
  " }}}
" }}}

" editing {{{
set tabstop=4
set shiftwidth=4
set shiftround
set smartindent
set virtualedit=block
set formatoptions=roqnlmB1j

  " add blank line above/below {{{
  nnoremap - <cmd>put=''<CR>
  nnoremap + <cmd>put!=''<CR>
  " }}}

  " visual mode indenting {{{
  vnoremap <Tab> >gv
  vnoremap <S-Tab> <gv
  " }}}

  " copy & paste {{{
  nnoremap <silent><Leader>p <cmd>set invpaste paste?<CR>
  " }}}
" }}}

" search/replace {{{
set ignorecase
set smartcase
set gdefault

noremap / /\v
noremap ? ?\v
" }}}

" diff {{{
set diffopt+=context:3

"let g:ConflictMotions_ConflictBeginMapping='c'
"let g:ConflictMotions_ConflictEndMapping='C'
"let g:ConflictMotions_ConflictMapping='c'
" }}}

" window/navigation {{{
  " scrolling {{{
  set scrolloff=5
  set sidescrolloff=5
  set scrolljump=5
  set sidescroll=5
  set nostartofline
  " }}}

  " splitting {{{
  set splitbelow splitright
  set noequalalways
  " }}}

  nnoremap \ <C-w>
  nnoremap \\ :b#<CR>
  nnoremap \d :bd<CR>
  nnoremap <silent>\z <cmd>cclose<CR> <cmd>pclose<CR>
  nnoremap <silent><C-t> <C-o>
"}}}

" buffer {{{
set hidden
nnoremap <Left> <cmd>bprev<CR>
nnoremap <Right> <cmd>bnext<CR>
" }}}

" file {{{
  " saving {{{
  set autowrite
  set confirm
  set nobackup
  set nowritebackup
  set noswapfile
  set undofile
  " }}}

  " modeline {{{
  set nomodeline
  " }}}

  " navigation {{{
  set wildignore+=.git,*.pyc,*.gz,*.bz2

" color/highlighting {{{
  highlight ColorColumn ctermbg=236 guibg=#303030

  " ConflictDetection {{{
"  highlight link conflictOursMarker GruvboxRed
"  highlight link conflictBaseMarker GruvboxRed
"  highlight link conflictSeparatorMarkerSymbol GruvboxRed
"  highlight link conflictTheirsMarker GruvboxRed
  " }}}
" }}}

" syntax/completion {{{
  set completeopt=menuone,noinsert,noselect
  set updatetime=250
" }}}

augroup RestoreCursorPosition "{{{
  autocmd!

  autocmd BufReadPost *
  \ if &filetype !~ 'commit\c' |
  \   if line("'\"") > 0 && line("'\"") <= line("$") |
  \     exe "normal! g`\"" |
  \   endif |
  \ endif
augroup END "}}}

augroup FileTypeSpecific "{{{
  autocmd!

  " help {{{
  autocmd FileType help autocmd BufEnter,BufWinEnter <buffer>
    \ nnoremap <buffer><Space> <C-]> |
    \ nnoremap <buffer><BS> <C-o>
  " }}}
  " make {{{
  autocmd FileType make setlocal tabstop=8 shiftwidth=8 noexpandtab
  autocmd FileType cmake setlocal tabstop=4 shiftwidth=4 expandtab
  " }}}
  " html/xml {{{
  autocmd FileType html,xhtml,xml,xsd setlocal tabstop=2 shiftwidth=2 expandtab matchpairs+=<:>
  " }}}
  " lua {{{
  autocmd FileType lua setlocal tabstop=2 shiftwidth=2 expandtab
  " }}}
  " ruby {{{
  autocmd FileType ruby,yaml setlocal tabstop=2 shiftwidth=2 expandtab
  " }}}
  " python {{{
  autocmd FileType python setlocal tabstop=4 shiftwidth=4 expandtab
  " }}}
  " go {{{
  autocmd FileType go setlocal tabstop=4 shiftwidth=4 noexpandtab
  " }}}
augroup END "}}}

augroup AutoCloseWindows "{{{
  autocmd!

  " automatically close quickfix window
  autocmd WinEnter *
    \ if winnr('$') == 1 && getbufvar(winbufnr(winnr()), '&buftype') == 'quickfix' |
    \   quit |
    \ endif

  " automatically close preview window
  autocmd CompleteDone * if pumvisible() == 0 | silent! pclose | endif
augroup END "}}}

augroup FastEscape "{{{
  autocmd!

  autocmd InsertEnter * set timeoutlen=0
  autocmd InsertLeave * set timeoutlen=1000
augroup END "}}}

runtime! init.vim.local
silent! helptags ALL

" vim: tabstop=2 shiftwidth=2 expandtab

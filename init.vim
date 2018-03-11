filetype plugin indent on
syntax on

let g:mapleader=','
nnoremap ` '
nnoremap ' `

" terminal {{{
set mouse=nv
set termguicolors
set title
" }}}

" display {{{
  " line numbers {{{
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
  set textwidth=80
  set nowrap
  set linebreak

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
  nnoremap <silent><Leader>r :call ToggleWrap()<CR>
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
  nnoremap - :put=''<CR>
  nnoremap + :put!=''<CR>
  " }}}

  " visual mode indenting {{{
  vnoremap <Tab> >gv
  vnoremap <S-Tab> <gv
  " }}}

  " toggle paste mode {{{
  nnoremap <silent><Leader>p :set invpaste paste?<CR>
  " }}}

  " commenting {{{
  nmap <silent><Leader>// <Plug>TComment_gcc
  xmap <silent><Leader>// <Plug>TComment_gc
  " }}}
" }}}

" search/replace {{{
set ignorecase
set smartcase
set gdefault

let g:incsearch#auto_nohlsearch=1
map / <Plug>(incsearch-forward)\v
map ? <Plug>(incsearch-backward)\v
map n <Plug>(incsearch-nohl-n)
map N <Plug>(incsearch-nohl-N)
map * <Plug>(incsearch-nohl-*)
map # <Plug>(incsearch-nohl-#)
" }}}

" diff {{{
set diffopt+=context:3

highlight def conflictOursMarker ctermfg=red
highlight def conflictTheirsMarker ctermfg=red
highlight def link conflictBaseMarker conflictBase
let g:ConflictMotions_ConflictBeginMapping='c'
let g:ConflictMotions_ConflictEndMapping='C'
let g:ConflictMotions_ConflictMapping='c'
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
  nmap \\ :b#<CR>
  nmap \d :bd<CR>
  nmap \b :Denite buffer<CR>
"}}}

" buffer {{{
set autochdir
set hidden
nnoremap <Left> :bprev<CR>
nnoremap <Right> :bnext<CR>
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
  let g:secure_modelines_verbose=0
  " }}}

  " navigation {{{
  set wildignore+=.git,*.pyc,*.gz,*.bz2
  nnoremap <C-o> :FSHere<CR>
  nnoremap <C-p> :FuzzyOpen<CR>
  " }}}
" }}}

" color/highlighting {{{
  " scheme {{{
  set background=dark
  let g:gruvbox_italic=1
  let g:gruvbox_vert_split='bg2'
  packadd! gruvbox
  colorscheme gruvbox
  " }}}

  " vim-better-whitespace {{{
  let g:show_spaces_that_precede_tabs=1
  highlight ExtraWhitespace ctermbg=88 guibg=#870000
  " }}}
" }}}

" syntax/completion {{{
  " nvim-completion-manager {{{
  let g:cm_completekeys="\<Plug>(cm_complete)"
  let g:cm_matcher = {
    \ 'module': 'cm_matchers.fuzzy_matcher',
    \ 'case': 'smartcase',
    \ }

  function! s:check_back_space() abort "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~ '\s'
  endfunction "}}}
  inoremap <silent><expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <silent><expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
  map <Esc>[Z <S-Tab>
  ounmap <Esc>[Z
  "}}}

  " LanguageClient-neovim {{{
  let g:LanguageClient_serverCommands = {
    \ 'c': ['cquery', '--log-file=/tmp/cquery.log', '--init={"cacheDirectory":"/tmp/cquery"}'],
    \ 'cpp': ['cquery', '--log-file=/tmp/cquery.log', '--init={"cacheDirectory":"/tmp/cquery"}'],
    \ 'go': ['go-langserver', '-gocodecompletion'],
    \ }
  let g:LanguageClient_changeThrottle=0.5
  let g:LanguageClient_rootMarkers = {
    \ 'c': ['.cquery', 'compile_commands.json'],
    \ 'cpp': ['.cquery', 'compile_commands.json'],
    \ 'python': ['setup.py'],
    \ }

  nnoremap <silent><C-h> :call LanguageClient_textDocument_hover()<CR>
  nnoremap <silent><C-j> :call LanguageClient_textDocument_definition()<CR>:normal! m`<CR>
  nnoremap <silent><C-k> :call LanguageClient_textDocument_references()<CR>
  nnoremap <silent><C-t> <C-o>
  " }}}
" }}}

" lightline {{{
function! LightlineFugitive() "{{{
  if exists('*fugitive#head')
    let branch = fugitive#head()
    if branch !=# ''
      return ' '.branch
    endif
    let commit = fugitive#head(7)
    if commit !=# ''
      return ' '.commit
    endif
  endif
  return ''
endfunction "}}}
function! LightlineReadonly() "{{{
  return &readonly ? '' : ''
endfunction "}}}
set showtabline=2
let g:lightline = {
  \ 'active': {
  \   'left': [['mode', 'paste'], ['fugitive', 'readonly', 'filename', 'modified']],
  \ },
  \ 'colorscheme': 'gruvbox',
  \ 'component': {
  \   'lineinfo': ' %3l:%-2v',
  \ },
  \ 'component_expand': {
  \   'buffercurrent': 'lightline#buffer#buffercurrent',
  \   'bufferbefore': 'lightline#buffer#bufferbefore',
  \   'bufferafter': 'lightline#buffer#bufferafter',
  \ },
  \ 'component_function': {
  \   'bufferinfo': 'lightline#buffer#bufferinfo',
  \   'fugitive': 'LightlineFugitive',
  \   'readonly': 'LightlineReadonly',
  \ },
  \ 'component_type': {
  \   'buffercurrent': 'tabsel',
  \   'bufferbefore': 'raw',
  \   'bufferafter': 'raw',
  \ },
  \ 'separator': { 'left': '', 'right': '' },
  \ 'subseparator': { 'left': '', 'right': '' },
  \ 'tabline': {
  \   'left': [['bufferinfo'], ['bufferbefore', 'buffercurrent', 'bufferafter']],
  \   'right': [],
  \ },
  \ }

  " lightline-buffer {{{
  let g:lightline_buffer_readonly_icon=''
  let g:lightline_buffer_modified_icon='+'
  let g:lightline_buffer_git_icon=' '
  let g:lightline_buffer_ellipsis_icon='…'
  let g:lightline_buffer_expand_left_icon='◀ '
  let g:lightline_buffer_expand_right_icon=' ▶'
  let g:lightline_buffer_enable_devicons=1
  let g:lightline_buffer_show_bufnr=1
  let g:lightline_buffer_fname_mod=':t'
  let g:lightline_buffer_maxflen=30
  " }}}
" }}}

augroup RestoreCursorPosition "{{{
  autocmd!

  au BufReadPost *
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
  " ruby {{{
  autocmd FileType ruby,yaml setlocal tabstop=2 shiftwidth=2 expandtab
  " }}}
  " python {{{
  autocmd FileType python setlocal tabstop=4 shiftwidth=4 expandtab
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
  au InsertLeave  * if pumvisible() == 0 | silent! pclose | endif
augroup END "}}}

augroup FSwitchConfig "{{{
  autocmd!

  autocmd BufEnter *.cc let b:fswitchdst='h,hh,hpp'
  autocmd BufEnter *.h let b:fswitchdst='cc,cpp,c,mm,m'
augroup END "}}}

augroup PasteDisableLexima "{{{
  autocmd!

  autocmd InsertEnter * if &paste | let b:lexima_disabled=1 | endif
  autocmd InsertLeave * if &paste | let b:lexima_disabled=0 | endif
augroup END "}}}

runtime! init.vim.local

packloadall
silent! helptags ALL

" lexima rules {{{
call lexima#add_rule({'char': '(', 'at': '\%#\w'})
call lexima#add_rule({'char': '(', 'at': '\%#[!~-]'})
call lexima#add_rule({'char': '[', 'at': '\%#\w'})
call lexima#add_rule({'char': '(', 'at': '\%#[[]'})
call lexima#add_rule({'char': '{', 'at': '\%#\w'})
call lexima#add_rule({'char': '{', 'at': '\%#[{]'})
" }}}

runtime! init.vim.local.late

" vim: tabstop=2 shiftwidth=2 expandtab

" $HOME/.vimrc

" MyAutoCmd : an augroup for my autocmd {{{1
augroup MyAutoCmd
  autocmd!
augroup END

" Encoding {{{1
scriptencoding utf-8
set encoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,utf-8,cp932

" Options {{{1
syntax on
set nocompatible
set ambiwidth=double  " Use twice the width of ASCII characters
set autoindent
set backspace=indent,eol,start
set cinoptions=:0,t0,+2s,(0,W2s
set expandtab softtabstop=2 shiftwidth=2
set noequalalways
autocmd MyAutoCmd VimEnter,WinEnter * set formatoptions-=ro
set grepprg=ack-grep\ -a
set helplang=en
set history=100
set number
set hlsearch
nohlsearch
set incsearch
set ignorecase
set laststatus=2
set mouse=a
set ruler
set showcmd
set showmode
set showtabline=2
set smartcase
set splitbelow
set splitright
set wildmenu
set wildmode=list,full

let g:mapleader = ','

" Mappings {{{1
noremap : ;
noremap ; :
nnoremap Y y$
nnoremap zo zv
nnoremap zv zMzv
nnoremap <C-h> :<C-u>help<Space>
nnoremap <C-s> :<C-u>set<Space>
nnoremap <Space> <Nop>
nnoremap <silent> <Space>/ :<C-u>nohlsearch<CR>
nnoremap <silent> <Space>s :<C-u>source $HOME/.vimrc<CR>:echo "source $HOME/.vimrc"<CR>
nnoremap <Space>cd :<C-u>lcd %:p:h<CR>
nnoremap q <Nop>
nnoremap <Space>q q
nnoremap <Space>h <C-w>h
nnoremap <Space>j <C-w>j
nnoremap <Space>k <C-w>k
nnoremap <Space>l <C-w>l
cnoremap <C-a> <C-b>
vnoremap < <gv
vnoremap > >gv

" Tabs {{{1
nnoremap t <Nop>
nnoremap <silent> tc :<C-u>tabnew<CR>:tabmove<CR>
nnoremap <silent> tk :<C-u>tabclose<CR>
nnoremap <silent> tK :<C-u>tabclose!<CR>
nnoremap <silent> tn :<C-u>tabnext<CR>
nnoremap <silent> tp :<C-u>tabprevious<CR>

" Color scheme {{{1
" For popup menu {{{2
set background=light
highlight Pmenu      ctermfg=Black ctermbg=LightGray guifg=Black guibg=LightGray
highlight PmenuSel   ctermfg=White ctermbg=DarkBlue  guifg=White guibg=DarkBlue
highlight PmenuSbar  ctermfg=Black ctermbg=DarkBlue  guifg=Black guibg=DarkBlue
highlight PmenuThumb ctermfg=LightMagenta ctermbg=LightMagenta guifg=LightMagenta guibg=LightMagenta

" Highlight trailing spaces and fullwidth ideographic spaces {{{2
autocmd MyAutoCmd VimEnter,WinEnter,ColorScheme * highlight UglySpaces term=underline ctermbg=Red guibg=Red
autocmd MyAutoCmd VimEnter,WinEnter * match UglySpaces /　\|\s\+$/

" Misc {{{1
" Auto cd {{{2
autocmd MyAutoCmd BufEnter * lcd %:p:h

" Close a particular window on press q {{{2
autocmd MyAutoCmd FileType help,qf nnoremap <buffer> q <C-w>c

" Change the color of the status bar on insert mode {{{2
" TODO: Prevent from breaking the color scheme.
" TODO: Fix bold.
autocmd MyAutoCmd InsertEnter * highlight StatusLine ctermfg=Blue ctermbg=Yellow cterm=none
autocmd MyAutoCmd InsertLeave * highlight StatusLine ctermfg=Black ctermbg=White cterm=none

" Open the quickfix window after vimgrep {{{2
autocmd MyAutoCmd QuickFixCmdPost vimgrep cwindow

" Move the cursor to the last-edit-position when opeining a buffer {{{2
autocmd MyAutoCmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
\ | execute "normal! g`\"" | endif


" Vundle {{{1
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let Vundle manage Vundle
Bundle 'gmarik/vundle'

" Original repos on Github
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/vimproc'
Bundle 'h1mesuke/unite-outline'
Bundle 'sgur/unite-qf'
Bundle 'thinca/vim-quickrun'
Bundle 'thinca/vim-ref'
Bundle 'thinca/vim-visualstar'
Bundle 'tsukkee/unite-help'

" vim-scripts repos
Bundle 'errormarker.vim'
Bundle 'skk.vim'
Bundle 'surround.vim'

filetype plugin indent on

" Plugins {{{1
" errormarker.vim {{{2
let g:errormarker_errorgroup = "ErrorMsg"

" neocomplcache.vim {{{2
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1

imap <Tab> <Plug>(neocomplcache_snippets_expand)
smap <Tab> <Plug>(neocomplcache_snippets_expand)

" Enable omni completion. {{{3
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'
autocmd MyAutoCmd FileType ruby setlocal omnifunc=rubycomplete#Complete
autocmd MyAutoCmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd MyAutoCmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd MyAutoCmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd MyAutoCmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd MyAutoCmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" quickrun.vim {{{2
let g:quickrun_config = {}
let g:quickrun_config._ = { "runner": "vimproc" }

" skk.vim {{{2
let g:skk_auto_save_jisyo = 1
let g:skk_kutouten_type = "en"
let g:skk_jisyo = "~/.skk-jisyo"
let g:skk_large_jisyo = "~/local/share/dict/SKK-JISYO.L"

" unite.vim {{{2
let g:unite_enable_start_insert = 0
let g:unite_update_time = 50

imap <C-k> <Plug>(neocomplcache_start_unite_complete)

nnoremap f <Nop>
nnoremap <silent> fb :<C-u>Unite -buffer-name=files buffer_tab<CR>
nnoremap <silent> ff :<C-u>UniteWithBufferDir -buffer-name=files file file/new<CR>
nnoremap <silent> fg :<C-u>Unite grep<CR>
nnoremap <silent> fo :<C-u>Unite outline<CR>
nnoremap <silent> fp :<C-u>Unite -buffer-name=files file_rec/async:! file/new<CR>
nnoremap <silent> fq :<C-u>Unite qf:enc=utf-8<CR>
nnoremap <silent> fr :<C-u>Unite -buffer-name=files file_mru<CR>
nnoremap <silent> fy :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> <C-h> :<C-u>Unite -start-insert help<CR>
nnoremap <silent> g<C-h> :<C-u>UniteWithCursorWord help<CR>

let g:unite_source_file_mru_filename_format = ''

if executable('ack-grep')
  let g:unite_source_grep_command = 'ack-grep'
  let g:unite_source_grep_default_opts = '--no-heading --no-color -a'
  let g:unite_source_grep_recursive_opt = ''
endif

autocmd MyAutoCmd FileType unite nmap <buffer> <C-n> <Plug>(unite_loop_cursor_down)
autocmd MyAutoCmd FileType unite nmap <buffer> <C-p> <Plug>(unite_loop_cursor_up)
autocmd MyAutoCmd FileType unite nmap <buffer> <Esc> <Plug>(unite_exit)
autocmd MyAutoCmd FileType unite nnoremap <buffer><expr><silent> s unite#do_action('split')
autocmd MyAutoCmd FileType unite nnoremap <buffer><expr><silent> v unite#do_action('vsplit')
autocmd MyAutoCmd FileType unite imap <buffer> <C-w> <Plug>(unite_delete_backward_path)

" vim: expandtab softtabstop=2 shiftwidth=2
" vim: foldmethod=marker

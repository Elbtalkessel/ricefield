" DEFAULT --------------------------------------------------------------------
" ----------------------------------------------------------------------------
set number
set t_CO=256
set tabstop=2
set softtabstop=0
set expandtab
set shiftwidth=2
set smarttab
set ls=2
set nocompatible
set backspace=2
set clipboard+=unnamedplus
set encoding=UTF-8
" disable line wrapping
set nowrap
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
let python_highlight_all=1
syntax on

packadd vimball

" VUNDLE ------------------------------------------------------------
" -------------------------------------------------------------------
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin('~/.config/nvim/bundle')
Plugin 'gmarik/Vundle.vim'
" PLUGINS

" Nav
Plugin 'ctrlpvim/ctrlp.vim'

" Syntax
Plugin 'sheerun/vim-polyglot'

" Appearance
Plugin 'flazz/vim-colorschemes'             " Colorscheme manager
Plugin 'joshdick/onedark.vim'               " Colorscheme
Plugin 'itchyny/lightline.vim'
Plugin 'vim-airline/vim-airline-themes'

" Code completion
" Plugin 'ycm-core/YouCompleteMe'
Plugin 'jiangmiao/auto-pairs'

" Misc
" Plugin 'tpope/vim-fugitive'                 " Git wrapper
Plugin 'chrisbra/Colorizer'                 " hex colors

Plugin 'vimwiki/vimwiki'
Plugin 'tpope/vim-commentary'

Plugin 'chrisbra/csv.vim'

" Gruvbox
Plugin 'morhetz/gruvbox'


" /PLUGINS
call vundle#end()
filetype indent plugin on

" Ensure files are read as what I want:
let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
map <leader>v :VimwikiIndex
let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
" Automatically deletes all trailing whitespace on save.
autocmd BufWritePre * %s/\s\+$//e
" Run xrdb whenever Xdefaults or Xresources are updated.
autocmd BufWritePost *Xresources,*Xdefaults !xrdb %
" Reload sxhkd on save
autocmd BufWritePost sxhkdrc !pkill sxhkd -SIGUSR1
" Reload dunst on rc save
autocmd BufWritePost dunstrc !pkill dunst && dunst & notify-send "dunst" "reload"



" CTRLP -------------------------------------------------------------
" -------------------------------------------------------------------
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,node_modules/*
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files --cached --exclude-standard --others'],
    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
    \ },
  \ }


" VIM-COLORSCHEME ---------------------------------------------------
" -------------------------------------------------------------------
colorscheme gruvbox


" LIGHTLINE ---------------------------------------------------------
" -------------------------------------------------------------------
let g:lightline = {
  \ 'colorscheme': 'gruvbox'
  \ }


" Key Remaps --------------------------------------------------------
" -------------------------------------------------------------------
" Shortcutting split navigation, saving a keypress:
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" buffer
map <S-J> :bprev<CR>
map <S-K> :bnext<CR>
map <S-q> :bd<CR>
map <S-c> :qa!<CR>

" Save on ctrl s, exit on ctrl c
nmap <c-s> :w<CR>
imap <c-s> <ESC>:w<CR>
map <c-c> :qa!<CR>


" File specific setups ----------------------------------------------
" -------------------------------------------------------------------
au BufNewFile,BufRead *.js,*.html,*.vue,*.css,*.scss
    \ set tabstop=2 |
    \ set shiftwidth=2 |

au BufNewFile,BufRead *.py,*.go
    \ set tabstop=2 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |


" Scripts -----------------------------------------------------------
" -------------------------------------------------------------------
" Prompt to create a directory if not exist
augroup vimrc-auto-mkdir
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
  function! s:auto_mkdir(dir, force)
    if !isdirectory(a:dir)
          \   && (a:force
          \       || input("'" . a:dir . "' does not exist. Create? [y/N]") =~? '^y\%[es]$')
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction
augroup END


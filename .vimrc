syntax on

filetype on
au BufNewFile,BufRead *.bkp set filetype=php
" au BufNewFile,BufRead *.json* set filetype=javascript
au BufNewFile,BufRead *.erb set filetype=ruby
au BufNewFile,BufRead Vagrantfile set filetype=ruby
au BufNewFile,BufRead Makefile set filetype=make
au BufNewFile,BufRead Jenkinsfile set filetype=groovy
au BufNewFile,BufRead *.groovy setf groovy

" Automatically strip whitespace from the end of lines
autocmd BufWritePre * :%s/\s\+$//e

" Highlight trailing whitespace

" Highlight search results
set hlsearch

set expandtab
set copyindent
set preserveindent
set softtabstop=2 "Makes the spaces feel like real tabs
set shiftwidth=2
set tabstop=2


set autoindent
set number
set ruler

set wrap " Wordwrap
set linebreak " Wrap on breaking characters
set nolist

" Show (partial) commands (or size of selection in Visual mode) in status line
set showcmd

" When a bracket is inserted, briefly jump to the matching one
set showmatch

" Ignore case in searches
set ignorecase

" If case is specified in the search, use case sensitive
set smartcase

" Set F2 as the paste toggle key for pasting from clipboard
" set pastetoggle=<F2>

" gVim: Allow all operations such as yy, D, and P to work with the clipboard. No need to prefix with "* or "+.
" set clipboard=unnamed

" Allow backspace over everything
set backspace=indent,eol,start

" Remember up to 100 : (colon) history commands
set history=100

" Always show status line, even for one window
set laststatus=2

" Enable full mouse support in Vim console
" set mouse=a

" Enable a menu at the bottom of the vim window
set wildmenu

" Minimal number of screen lines to keep above and below the cursor.
set scrolloff=5

" Visual shifting - Does not exit visual mode
vnoremap < <gv
vnoremap > >gv

" Remap shift+k to split the text from the current line
nnoremap <S-k> i<CR><Esc>
inoremap <C-l> <Esc>
inoremap ;; <Esc>
map ;; <Esc>

" Load the PHP .vimrc settings
" autocmd FileType source ~/.vim/phprc.vim

autocmd FileType make setlocal noexpandtab
autocmd FileType make setlocal tabstop=4

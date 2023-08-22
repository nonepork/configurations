set nocompatible

set background=dark
syntax on
filetype plugin on
set foldmethod=syntax

" True color
if has('termguicolors')
      set termguicolors
endif

set showmatch                       " Hightlight matching parentheses

set clipboard=unnamed               " Make copy works

set undodir=E:/code/vim/undo        " Undo file location
set directory=E:/code/vim/swap      " Swap file location
set backupdir=E:/code/vim/backup    " Backup file location

set number                          " Show line numbers
set expandtab                       " Use space instead of tab
set shiftwidth=4                    " indent 2
set tabstop=4                       " Tab stop 2 idk reall ww
set softtabstop=4
set autoindent                      " Does what it says
set nowrap                          " Dont wrap text
set guioptions -=T                  " Dont show toolbar

set laststatus=2                    " For lightline plugin
set noshowmode                      " For lightline plugin, disables mode display

let g:tokyonight_style = 'night'
let g:tokyonight_enable_italic = 1

let g:lightline = {'colorscheme': 'tokyonight'}
let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_infos': 'lightline#ale#infos',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \ }

let g:lightline.component_type = {
      \     'linter_checking': 'right',
      \     'linter_infos': 'right',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \ }

let g:lightline.active = { 'right': [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos']] }


let g:lightline.active = {
            \ 'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos'],
            \            [ 'lineinfo' ],
	    \            [ 'percent' ],
	    \            [ 'fileformat', 'fileencoding', 'filetype'] ] }


let g:ale_linters = {
\     'python': ['ruff'],
\}

set backspace=indent,eol,start            " Make backspace works with prewritten text
set encoding=utf-8                        " Set encoding to utf-8
set mouse=a                               " Enable mouse support
set ruler                                 " Show line and column because its cool
set guifont=Victor\ Mono:h12

" Move vertically by visual line (don't skip wrapped lines)
nmap j gj
nmap k gk

set incsearch                             " Search as characters are entered
set hlsearch                              " Highlight matches

nnoremap <F5> :exec 'NERDTreeToggle' <CR>



" Custom scripts, Plugins load below



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-n>"
    endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()


" Removes trailing spaces
function TrimWhiteSpace()
  %s/\s*$//
  ''
endfunction

set list listchars=trail:.,extends:>
autocmd FileWritePre * call TrimWhiteSpace()
autocmd FileAppendPre * call TrimWhiteSpace()
autocmd FilterWritePre * call TrimWhiteSpace()
autocmd BufWritePre * call TrimWhiteSpace()

" Disable plugin when file too large
if getfsize(expand('%')) > 400000
    set nocp
    silent! PlugClean!

    call plug#begin("$HOME/vimfiles/plugged")

    Plug 'dense-analysis/ale' , {'on': []}
    Plug 'maximbaz/lightline-ale' , {'on': []}
    Plug 'itchyny/lightline.vim' , {'on': []}
    Plug 'sheerun/vim-polyglot' , {'on': []}
    Plug 'alvan/vim-closetag' ", {'on': []}
    Plug 'ghifarit53/tokyonight-vim'
    Plug 'preservim/nerdtree' , {'on': []} 

    call plug#end()
else
    call plug#begin("$HOME/vimfiles/plugged")

    Plug 'dense-analysis/ale' ", {'on': []}
    Plug 'maximbaz/lightline-ale' ", {'on': []}
    Plug 'itchyny/lightline.vim' ", {'on': []}
    Plug 'sheerun/vim-polyglot' ", {'on': []}
    Plug 'alvan/vim-closetag' ", {'on': []}
    Plug 'ghifarit53/tokyonight-vim'
    Plug 'preservim/nerdtree' ", {'on': []} 

    call plug#end()
endif

colorscheme tokyonight                    " Its here incase of transparent lightline

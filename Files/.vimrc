" Set the mapleader
let mapleader = '\'

" ########## PLUGIN STUFF ##########

" Use vim-plug to handle plugins
call plug#begin('~/.vim/plugged')
Plug 'preservim/NERDTree'
Plug 'andymass/vim-matchup'

Plug 'luochen1990/rainbow'
let g:rainbow_active = 1 " Turn on rainbow parentheses

Plug 'preservim/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
call plug#end()

set runtimepath+=~/.vim/bundle/Vundle.vim " Set the runtime path to include Vundle

" Use Vundle to handle other plugins
call vundle#begin()
Plugin 'gmarik/Vundle.vim' " Let Vundle manage itself
Plugin 'ycm-core/YouCompleteMe'

Plugin 'Yggdroot/indentLine'
let g:indentLine_defaultGroup = 'SpecialKey'
let g:indentLine_char = '|'
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '·'
let g:indentLine_fileTypeExclude = ['json', 'markdown']

Plugin 'itchyny/lightline.vim'
let g:lightline = {'colorscheme': 'wombat'}

Plugin 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger="¬"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

Plugin 'honza/vim-snippets'
Plugin 'jiangmiao/auto-pairs'
call vundle#end()

" ########## MISC THINGS ##########

syntax on
filetype indent plugin on

colorscheme ron " Nicer for dark terminals, especially with semi-transparent background

" ########## SET THINGS ##########

set laststatus=2 " Let lightline status bar work
set noshowmode " Hide original status bar

set updatetime=100 " Update things faster (this reduces the delay of gitgutter)

set number relativenumber " set number options
set ruler
set ignorecase smartcase hlsearch incsearch " set search options

" This creates a line under the cursor that spans the whole line
set cursorline

" Show spaces and tabs
set listchars=trail:·,nbsp:~,tab:>- " Middle dot is U00B7
set list

" Always use 4 spaces when tab is pressed
set tabstop=4 " 4 spaces per tab
set shiftwidth=4
set expandtab

set foldenable
set foldmethod=indent

" Better indents
set autoindent smartindent

" Autoreload the file if it has been changed outside of vim
set autoread

" ########## CUSTOM FUNCTIONS FOR COMMANDS ##########

" Wrapper func for Pydoc call
function PydocFunc(name) abort
    execute '!pydoc3 '.expand(a:name)
endfunction

command -nargs=1 Pydoc call PydocFunc('<args>')

" ########## CUSTOM SIMPLE FUNCTIONS ###########

" Remove all trailing spaces
" This is the only way this command seems to work. It angers me.
command Rmsp execute "silent %s/ * $//g | noh"
" Convert tabs to spaces
command Tb2sp execute "silent %s/\t/    /g | noh"
" Convert spaces to tabs
command Sp2tb execute "silent %s/    /\t/g | noh"

" Fully clean up file
command Clean execute "Tbcnv | Rmsp"

command Q execute "q!"
command W execute "wq"

" ########## MAPPINGS ###########

" Easier 4 directional navigation
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l

" Easier splitting into new panes
nmap <Bar> <C-w>v<C-l>
nmap - <C-w>s<C-j>

" Don't skip wrapped line with j and k
nmap j gj
nmap k gk

" Toggle folding with space
nmap <space> za

" Quit vim completely
nmap <leader>Q :qa!<cr>

" Run current file
nnoremap <leader>r :!"%:p"<Enter>

" Write current file
nnoremap <leader>w :w<Enter>
nnoremap <leader><leader> :w<Enter>

" ########## AUTOMATIC COMMANDS ##########

" Open all folds by default
" Triggers on buffer read, matches all files, and executes 'zR' in normal mode
au BufRead * normal zR

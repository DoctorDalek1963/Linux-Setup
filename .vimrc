" Set the mapleader
let mapleader = '\'

" This should be t the start and not in the set section to ensure correct usage
set nocompatible " Possibly useless, but ensures correct usage

" ########## PLUGIN STUFF ##########

" Use vim-plug to handle plugins
call plug#begin('~/.vim/plugged')
Plug 'preservim/NERDTree'
Plug 'andymass/vim-matchup'
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1 " Turn on rainbow parentheses
Plug 'preservim/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
let g:lightline = {'colorscheme': 'wombat'}
call plug#end()

set rtp+=~/.vim/bundle/Vundle.vim " set the runtime path the include Vundle

" Use Vundle to handle other plugins
call vundle#begin()
Plugin 'gmarik/Vundle.vim' " Let Vundle manage itself
Plugin 'ycm-core/YouCompleteMe'
call vundle#end()

" ########## MISC THINGS ##########

syntax on
filetype indent plugin on

colorscheme ron " Nicer for dark terminals, mine is #002b36 with an opacity of 93%

" ########## SET THINGS ##########

set laststatus=2 " Let lightline status bar work
set noshowmode " Hide original status bar

set updatetime=100 " Update things faster (this reduces the delay of gitgutter)

set number relativenumber " set number options
set ruler
set ignorecase hlsearch incsearch " set search options

" This creates a line under the cursor that spans the whole line
set cursorline

" Show spaces and tabs
set listchars=space:·,nbsp:~,tab:>- " Middle dot is U+00B7
set list

" Always use 4 spaces when tab is pressed
set tabstop=4 " 4 spaces per tab
set shiftwidth=4
set expandtab

set foldenable
set foldmethod=indent

" ########## CUSTOM FUNCTIONS FOR COMMANDS ##########

" Wrapper func for Pydoc call
function PydocFunc(name)
    execute '!pydoc '.expand(a:name)
endfunction

command -nargs=1 Pydoc call PydocFunc('<args>')

" Edit a new file using ':E <name>'
function EditNewFile(name)
    execute 'edit '.expand(a:name)
endfunction

" -complete=file means the command will autocomplete a file name or directory when tab is pressed
command -nargs=1 -complete=file E call EditNewFile('<args>')

" ########## CUSTOM SIMPLE FUNCTIONS ###########

" Remove all spaces on lines that only have spaces
command Rmsp execute "silent %s/^[ ]\\+$//g | noh"
" Convert tabs to spaces
command Tbcnv execute "silent %s/\t/    /g"

" Fully clean up file
command Clean execute "Tbcnv | Rmsp"

command Q execute "q!"
command W execute "wq"

" Easily tab through panes
map <Tab> <C-w>w
map <S-Tab> <C-w>W

" Easier 4 directional navigation
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l

" Easier splitting into new panes
map <Bar> <C-w>v<C-l>
map - <C-w>s<C-j>

" Toggle folding with space
nmap <space> za

" Quit vim completely
nmap <leader>Q :qa!<cr>

" ########## AUTOMATIC COMMANDS ##########

" Open all folds by default
" Triggers on buffer read, matches all files, and executes 'zR' in normal mode
au BufRead * normal zR

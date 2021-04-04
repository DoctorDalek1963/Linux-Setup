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

Plug 'joshdick/onedark.vim'
let g:onedark_termcolors=256
let g:onedark_terminal_italics=1

Plug 'sheerun/vim-polyglot'

Plug 'dense-analysis/ale'

Plug 'itchyny/lightline.vim'
let g:lightline = {'colorscheme': 'onedark'}

Plug 'maximbaz/lightline-ale'
" The following lightline configuration has just be taken from https://github.com/maximbaz/lightline-ale
" I understand almost none of it, but it makes things work, so I keep it
let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_infos': 'lightline#ale#infos',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

let g:lightline.component_type = {
      \     'linter_checking': 'right',
      \     'linter_infos': 'right',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'right',
      \ }

" This will set the ALE linting stuff on the far right, and then my normal vim file info stuff to the left of that
let g:lightline.active = {
      \ 'right': [
      \            [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ],
      \            [ 'lineinfo' ],
      \            [ 'percent' ],
      \            [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ }

let g:lightline#ale#indicator_checking = "\uf110 "
let g:lightline#ale#indicator_infos = "\uf129 "
let g:lightline#ale#indicator_warnings = "\uf071 "
let g:lightline#ale#indicator_errors = "\uf05e "
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

colorscheme onedark

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

" Don't skip wrapped line with arrow keys
nmap <up> g<up>
nmap <down> g<down>

" Toggle folding with space
nmap <space> za

" Quit vim completely
nmap <leader>Q :qa!<cr>

" Run current file
nnoremap <leader>r :!"%:p"<Enter>

" Run current file with arguments
" The space at the end of this line is intentional
nnoremap <leader>a :!"%:p" 

" Write current file
nnoremap <leader>w :w<Enter>
nnoremap <leader><leader> :w<Enter>

" ########## AUTOMATIC COMMANDS ##########

" Open all folds by default
" Triggers on buffer read, matches all files, and executes 'zR' in normal mode
au BufRead * normal zR

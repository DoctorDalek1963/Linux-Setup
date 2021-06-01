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
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" Use pylintrc in this directory. This allows me to configure line length and other options
let g:ale_python_pylint_options = '--rcfile=~/.vim/plugged/ale/ale_linters/python/.pylintrc'

Plug 'itchyny/lightline.vim'
let g:lightline = {'colorscheme': 'onedark'}

Plug 'maximbaz/lightline-ale'
" The following lightline configuration has just be taken from https://github.com/maximbaz/lightline-ale
" I understand almost none of it, but it makes things work, so I keep it
let g:lightline.component_expand = {
	\	'linter_checking': 'lightline#ale#checking',
	\	'linter_infos': 'lightline#ale#infos',
	\	'linter_warnings': 'lightline#ale#warnings',
	\	'linter_errors': 'lightline#ale#errors',
	\	'linter_ok': 'lightline#ale#ok',
	\ }

let g:lightline.component_type = {
	\	'linter_checking': 'right',
	\	'linter_infos': 'right',
	\	'linter_warnings': 'warning',
	\	'linter_errors': 'error',
	\	'linter_ok': 'right',
	\ }

" This will set the ALE linting stuff on the far right, and then my normal vim file info stuff to the left of that
let g:lightline.active = {
	\	'right': [
	\		[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ],
	\		[ 'lineinfo' ],
	\		[ 'percent' ],
	\		[ 'fileformat', 'fileencoding', 'filetype' ] ]
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

" Set the mapleader
let mapleader = '\'

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
set noexpandtab

set foldenable
set foldmethod=indent

" Better indents
set autoindent smartindent

" Autoreload the file if it has been changed outside of vim
set autoread

" ########## MAPPINGS ###########

" Easier 4 directional navigation
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Easier splitting into new panes
nnoremap <Bar> <C-w>v<C-l>
nnoremap - <C-w>s<C-j>

" Duplicate line with Ctrl+D
nnoremap <C-d> yyp

" Don't skip wrapped line with arrow keys
nnoremap <up> g<up>
nnoremap <down> g<down>

" Toggle folding with space
nnoremap <space> za

" ### Writing files and quitting vim

" Quit vim completely
nnoremap <leader>q :qa<cr>
" Force quit completely
nnoremap <leader>Q :qa!<cr>

" Write all open files
nnoremap <leader>w :wa<cr>
" Write all open files and quit
nnoremap <leader>W :wqa<cr>
"
" Write current file
nnoremap <leader><leader> :w<cr>

" ### Running files

" Run current file
nnoremap <leader>r :!"%:p"<cr>

" Run current file with arguments
" The space at the end of this line is intentional
nnoremap <leader>a :!"%:p" 

" Clear the terminal
nnoremap <leader>l :!clear<cr><cr>

" ########## AUTOMATIC COMMANDS ##########

augroup tabs_augroup
	autocmd!
	" Set a tab to be width 2
	autocmd FileType haskell set tabstop=2
	autocmd FileType haskell set shiftwidth=2
	" Use spaces instead of tabs
	autocmd FileType python,haskell set expandtab
augroup END

augroup all_files_augroup
	autocmd!
	" Open all folds by default
	" Triggers on buffer read, matches all files, and executes 'zR' in normal mode
	autocmd BufRead * normal zR
augroup END

augroup vimrc_augroup
	autocmd!
	" Set foldmethod to manual and fold the plugin stuff at the top of the file
	autocmd BufRead ~/.vimrc set foldmethod=manual
	autocmd BufRead ~/.vimrc normal ggV89Gzf
augroup END

augroup python_augroup
	autocmd!
	" Set a colour column at column 120 in Python files
	autocmd FileType python set colorcolumn=120
augroup END

" ########## CUSTOM SIMPLE COMMANDS ###########

" Remove all trailing spaces
" This is the only way this command seems to work. It angers me.
command Rmsp execute "silent %s/ * $//g | noh"

command Q execute "q!"
command W execute "wq"

" Setup bulk renaming
" This treats each line in the buffer as a file name and sets up a bash mv
" command with all the destinations lined up as the first argument to allow
" for easier use of visual block selection
command SRen execute 'g/.*/execute "normal Imv -t \"\<Esc>xA\"\<Esc>xhvi\"y0f\"pa\" " | noh | normal ggf"l'

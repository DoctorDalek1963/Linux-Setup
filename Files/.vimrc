" ########## PLUGIN STUFF ########## {{{
" I'm using vim-plug to manage all of my plugins
call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim'

Plug 'preservim/NERDTree'
Plug 'andymass/vim-matchup'

Plug 'luochen1990/rainbow'
let g:rainbow_active = 1 " Turn on rainbow parentheses

Plug 'preservim/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'sheerun/vim-polyglot'

Plug 'joshdick/onedark.vim'
let g:onedark_termcolors=256
let g:onedark_terminal_italics=1

Plug 'JuliaEditorSupport/julia-vim'
let g:latex_to_unicode_tab = 0
let g:latex_to_unicode_auto = 1

Plug 'godlygeek/tabular'

" identLine {{{
Plug 'Yggdroot/indentLine'
let g:indentLine_defaultGroup = 'SpecialKey'
let g:indentLine_char = '|'
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '·'
let g:indentLine_fileTypeExclude = ['json', 'markdown']
" }}}

" UltiSnips {{{
Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger="¬"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

Plug 'honza/vim-snippets'
" }}}

" ALE {{{
Plug 'dense-analysis/ale'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
" The '%(code): %' will completely disappear if there is no error code
let g:ale_echo_msg_format = '[%linter%] [%severity%] %(code): %%s'
" }}}

" Lightline {{{
Plug 'itchyny/lightline.vim'
let g:lightline = {'colorscheme': 'onedark'}

Plug 'maximbaz/lightline-ale'
Plug 'josa42/vim-lightline-coc'

let g:lightline.component_expand = {
	\	'linter_checking': 'lightline#ale#checking',
	\	'linter_infos': 'lightline#ale#infos',
	\	'linter_warnings': 'lightline#ale#warnings',
	\	'linter_errors': 'lightline#ale#errors',
	\	'linter_ok': 'lightline#ale#ok',
	\	'coc_status': 'lightline#coc#status'
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
	\		[ 'fileformat', 'fileencoding', 'filetype' ]
	\	],
	\	'left': [
	\		[ 'mode' ],
	\		[ 'readonly', 'filename', 'modified' ],
	\		[ 'coc_status' ]
	\	]
	\ }

let g:lightline.inactive = {
	\	'right': [
	\		[ 'lineinfo' ],
	\		[ 'percent' ]
	\	],
	\	'left': [
	\		[ 'filename', 'modified' ]
	\	]
	\ }

let g:lightline#ale#indicator_checking = "\uf110 "
let g:lightline#ale#indicator_infos = "\uf129 "
let g:lightline#ale#indicator_warnings = "\uf071 "
let g:lightline#ale#indicator_errors = "\uf05e "
" }}}
call plug#end()
" }}}

" ########## COC.NVIM CONFIG ########## {{{
let g:coc_global_extensions = [
			\ 'coc-html',
			\ 'coc-java',
			\ 'coc-json',
			\ 'coc-pairs',
			\ 'coc-pyright',
			\ 'coc-sh',
			\ 'coc-snippets',
			\ 'coc-tsserver',
			\ 'coc-ultisnips',
			\ 'coc-vimlsp',
			\ ]
" }}}

" ########## MISC THINGS ########## {{{

" Set the mapleader
let mapleader = '\'

syntax on
filetype indent plugin on

colorscheme onedark
" }}}

" ########## SET THINGS ########## {{{

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
set foldlevelstart=999

" Better indents
set autoindent smartindent

" Autoreload the file if it has been changed outside of vim
set autoread

" Use British English as the language for spell checking
set spelllang=en_gb
" }}}

" ########## MAPPINGS ########## {{{

" ### COC Hover Window Scrolling {{{
" 1 moves forward, 0 moves backward
" The second 1 just means 1 line at a time
nnoremap <silent> <S-Down> :call coc#float#scroll(1, 1)<CR>
nnoremap <silent> <S-Up> :call coc#float#scroll(0, 1)<CR>
" }}}

" ### Window navigation {{{

" Easier 4 directional navigation
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Easier splitting into new panes
nnoremap <Bar> <C-w>v<C-w>l
nnoremap - <C-w>s<C-w>j
" }}}

" ### Writing files and quitting vim {{{

" Quit vim completely
nnoremap <leader>q :qa<cr>
" Force quit completely
nnoremap <leader>Q :qa!<cr>

" Write all open files
nnoremap <silent> <leader>w :wa<cr>
" Write all open files and quit
nnoremap <leader>W :wqa<cr>

" Write current file
nnoremap <leader><leader> :w<cr>
" }}}

" ### Running files {{{

" Run current file
nnoremap <leader>r :!"%:p"<cr>

" Run current file with arguments
" The space at the end of this line is intentional
nnoremap <leader>a :!"%:p" 

" Clear the terminal and run the current file
nnoremap <leader>R :!clear<cr><cr>:!"%:p"<cr>
" }}}

" ### Misc maps {{{

" Duplicate line with Ctrl+D
nnoremap <C-d> yyp

" Clear a line
nnoremap D cc<Esc>

" Don't skip wrapped line with arrow keys
nnoremap <up> g<up>
nnoremap <down> g<down>

" Toggle folding with space
nnoremap <space><space> za
nnoremap <leader><space> zA

" Clear the terminal
nnoremap <leader>l :!clear<cr><cr>

" Remove search highlight
nnoremap <silent> <leader>n :nohlsearch<cr>

" Add a semicolon to the end of a line
nnoremap <leader>; mqA;<esc>`q

" Add a colon to the end of the line and start a new line
nnoremap <leader>: A:<esc>o

" Always use very magic regex mode
nnoremap / /\v

" Toggle spell check
nnoremap <silent> <leader>s :set spell!<cr>

" Copy whole file to clipboard in normal mode
nnoremap <leader>cp :w !xclip -selection c<CR><CR>
" Visual mode version that copies selection
vnoremap <leader>cp "+y
" }}}
" }}}

" ########## AUTOMATIC COMMANDS ########## {{{

" Tabs {{{
augroup tabs_augroup
	autocmd!
	" Set a tab to be width 2
	autocmd FileType haskell setlocal tabstop=2
	autocmd FileType haskell setlocal shiftwidth=2
	" Use spaces instead of tabs
	autocmd FileType python,haskell setlocal expandtab
augroup END
" }}}

" FileType vim {{{
augroup vim_augroup
	autocmd!
	" Remove double quotes from buffer autopairs to prevent it from messing with comments
	autocmd FileType vim let b:coc_pairs_disabled = ['"']

	autocmd FileType vim setlocal foldmethod=marker
	" Fold up every section
	autocmd FileType vim setlocal foldlevel=0
augroup END
" }}}

" Python {{{
augroup python_augroup
	autocmd!
	" Set a colour column at column 120 in Python files
	autocmd FileType python setlocal colorcolumn=120
augroup END
" }}}
" }}}

" ########## SIMPLE COMMANDS ########## {{{

" Remove all trailing spaces
command Rmsp execute '%s/\s\+$//e'

command Q execute "q!"
command W execute "wq"
" }}}

" ########## FUNCTIONS AND ASSOCIATED COMMANDS ########## {{{

function! SetupRename()
	execute 'g/.*/execute "normal Imv \"\<Esc>xA\"\<Esc>xhvi\"y0f\"pa\" "'
	nohlsearch
	" TODO: Increase spacin on each line so that the block on the right is all aligned
	" Loop over every line and get the column of the third " character
	" The maximum of these column values in the desired value
	" Loop over every line and add enough spaces to get to that desired value
	execute 'normal ggf";;l'
endfunction

command SRen call SetupRename()
" }}}

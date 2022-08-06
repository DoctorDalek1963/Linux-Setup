" ########## PLUGIN STUFF ########## {{{
" I'm using vim-plug to manage all of my plugins
call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'preservim/NERDTree'
Plug 'andymass/vim-matchup'

Plug 'luochen1990/rainbow'
let g:rainbow_active = 1 " Turn on rainbow parentheses

Plug 'preservim/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'sheerun/vim-polyglot'

Plug 'joshdick/onedark.vim'
if has('termguicolors')
	set termguicolors " 24-bit truecolor
endif
let g:onedark_terminal_italics=1

Plug 'JuliaEditorSupport/julia-vim'
let g:latex_to_unicode_tab = 0
let g:latex_to_unicode_auto = 1

Plug 'godlygeek/tabular'

Plug 'jeetsukumaran/vim-pythonsense'
Plug 'vim-python/python-syntax'
Plug 'Konfekt/FastFold'

Plug 'tmhedberg/SimpylFold'
let g:SimpylFold_docstring_preview = 1

Plug 'petRUShka/vim-sage'

Plug 'lervag/vimtex'
let g:vimtex_view_general_viewer = 'evince'

let g:tex_conceal = ""

Plug 'unblevable/quick-scope'
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" indentLine {{{
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
let g:ultisnips_python_quoting_style="single"
" }}}

" ALE {{{
Plug 'dense-analysis/ale'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'

" The '%(code): %' will completely disappear if there is no error code
let g:ale_echo_msg_format = '[%linter%] [%severity%] %(code): %%s'

let g:ale_linters = {
	\	'tex': [],
	\	'cpp': []
	\ }
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

function! LightlineReadonly()
	return &readonly && &filetype !=# 'help' ? 'RO' : ''
endfunction

function! VisualWordsAndChars()
	if mode()=="v"
		return wordcount().visual_words . "W " . wordcount().visual_chars . "C"
	else
		return ""
	endif
endfunction

let g:lightline.component_function = {
	\	'readonly': 'LightlineReadonly',
	\	'visualwordsandchars': 'VisualWordsAndChars'
	\ }

" This will set the ALE linting stuff on the far right, and then my normal vim file info stuff to the left of that
let g:lightline.active = {
	\	'right': [
	\		[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ],
	\		[ 'lineinfo' ],
	\		[ 'percent' ],
	\		[ 'fileformat', 'fileencoding', 'filetype' ],
	\		[ 'visualwordsandchars' ],
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
			\ 'coc-vimtex',
			\ 'coc-yank',
			\ ]

" coc config taken partly from https://github.com/neoclide/coc.nvim/blob/e230811e3827f703d816013d860ec1d91e0198e3/README.md#example-vim-configuration
" and new pum (popup menu) mappings from https://github.com/neoclide/coc.nvim/pull/3862#issue-1253872729

" Backups can mess with LSPs
set nobackup
set nowritebackup

" Faster updates means coc and gitgutter both work better
set updatetime=100

set signcolumn=yes

" Confirm selection
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1] =~# '\s'
endfunction

" Use tab to navigate popup menu
inoremap <silent><expr> <TAB>
	\ coc#pum#visible() ? coc#pum#next(1):
	\ CheckBackspace() ? "\<Tab>" :
	\ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

if has('nvim')
	inoremap <silent><expr> <c-space> coc#refresh()
else
	inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use arrow keys to navigate popup menu
inoremap <silent><expr> <down> coc#pum#visible() ? coc#pum#next(0) : "\<down>"
inoremap <silent><expr> <up> coc#pum#visible() ? coc#pum#prev(0) : "\<up>"

" 'Exit' and 'Yes'
inoremap <silent><expr> <C-e> coc#pum#visible() ? coc#pum#cancel() : "\<C-e>"
inoremap <silent><expr> <C-y> coc#pum#visible() ? coc#pum#confirm() : "\<C-y>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
	if CocAction('hasProvider', 'hover')
		call CocActionAsync('doHover')
	else
		call feedkeys('K', 'in')
	endif
endfunction

" Symbol renaming and refactoring
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>rf <Plug>(coc-refactor)

" Scroll through floating windows
" 1 moves forward, 0 moves backward
" The second 1 just means 1 line at a time
nnoremap <silent> <S-Down> :call coc#float#scroll(1, 1)<CR>
nnoremap <silent> <S-Up> :call coc#float#scroll(0, 1)<CR>

" Preview yanked things
nnoremap <silent> <leader>y :CocList -A --normal yank<CR>
" }}}

" ########## MISC THINGS ########## {{{

" Set the mapleader
let mapleader = '\'
let maplocalleader = '\'

syntax on
filetype indent plugin on

colorscheme onedark
" }}}

" ########## SET THINGS ########## {{{

set laststatus=2 " Let lightline status bar work
set noshowmode " Hide original status bar

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

" Never hide things
set conceallevel=0

set scrolloff=2 " Keep two lines of context around cursor line
" }}}

" ########## MAPPINGS ########## {{{

" ### Window navigation {{{

" Easier 4 directional navigation
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Easier splitting into new panes
" Open empty buffer by default
nnoremap <Bar> <C-w>v<C-w>l<C-w>n<C-w>j<C-w>c
nnoremap - <C-w>n<C-w>x<C-w>j

" Open current file with leader
nnoremap <leader><Bar> <C-w>v<C-w>l
nnoremap <leader>- <C-w>s<C-w>j
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
nnoremap <leader>A :!"%:p" 

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
nnoremap <leader>cl :!clear<cr><cr>

" Remove search highlight
nnoremap <silent> <leader>n :nohlsearch<cr>

" Add a semicolon or comma to the end of a line
nnoremap <leader>; mqA;<esc>`q
nnoremap <leader>, mqA,<esc>`q

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

" Defaults {{{
augroup defaults_augroup
	autocmd!
	" Wrap on word and highlight spelling errors
	autocmd FileType markdown,tex,rst setlocal linebreak spell

	" 80 char lines
	autocmd FileType markdown,rst setlocal colorcolumn=100 textwidth=99

	" reST tab settings
	autocmd FileType rst setlocal tabstop=3 shiftwidth=3 expandtab
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

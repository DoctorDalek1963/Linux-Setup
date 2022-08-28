" ########## PLUGIN CONFIG ########## {{{
" vim-matchup
let g:matchup_matchparen_offscreen = {'method': 'popup'}

" onedark.vim
if has('termguicolors')
	set termguicolors " 24-bit truecolor
endif
let g:onedark_terminal_italics=1

" julia-vim
let g:latex_to_unicode_tab = 0
let g:latex_to_unicode_auto = 1

" SimpylFold
let g:SimpylFold_docstring_preview = 1

" vimtex
let g:vimtex_view_general_viewer = 'evince'
let g:tex_conceal = ""

" quick-scope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" indentLine {{{
let g:indentLine_defaultGroup = 'SpecialKey'
let g:indentLine_char = '|'
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '·'
let g:indentLine_fileTypeExclude = ['json', 'markdown']
" }}}

" UltiSnips and vim-snippets {{{
let g:UltiSnipsExpandTrigger="¬"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

let g:ultisnips_python_quoting_style="single"
" }}}

" lightline.vim {{{
function! LightlineReadonly()
	return &readonly && &filetype !=# 'help' ? 'RO' : ''
endfunction

function! LightlineFileformat()
	return &fileformat !=# 'unix' ? &fileformat : ''
endfunction

function! VisualWordsAndChars()
	if mode() == "v"
		return wordcount().visual_words . "W " . wordcount().visual_chars . "C"
	else
		return ""
	endif
endfunction

function! UpdateGitPS1Status()
	let s:git_directory = substitute(resolve(expand('%:p')), '\/[^/]\+$', '', '')

	if s:git_directory == '' |
		let g:git_ps1_status = '' |
	else |
		let g:git_ps1_status = system('(cd ''' . s:git_directory . '''; GIT_PS1_SHOWDIRTYSTATE=true; GIT_PS1_SHOWSTASHSTATE=true; GIT_PS1_SHOWUNTRACKEDFILES=true; GIT_PS1_SHOWUPSTREAM="auto"; GIT_PS1_HIDE_IF_PWD_IGNORED=true; source ~/.git-prompt.sh; __git_ps1 "[%s]")') |
	endif
endfunction

augroup update_git_ps1_status_augroup
	autocmd!
	autocmd BufEnter,BufWritePost * call UpdateGitPS1Status()
augroup END

function! GitPS1Status()
	return g:git_ps1_status
endfunction

let g:lightline = {'colorscheme': 'onedark'}

let g:lightline.component_expand = {
	\	'linter_errors': 'lightline#coc#errors',
	\	'linter_warnings': 'lightline#coc#warnings',
	\	'linter_info': 'lightline#coc#info',
	\	'linter_hints': 'lightline#coc#hints',
	\	'linter_ok': 'lightline#coc#ok',
	\ }

let g:lightline.component_type = {
	\	'linter_errors': 'error',
	\	'linter_warnings': 'warning',
	\	'linter_info': 'info',
	\	'linter_hints': 'hints',
	\	'linter_ok': 'left',
	\ }

let g:lightline.component_function = {
	\	'readonly': 'LightlineReadonly',
	\	'fileformat': 'LightlineFileformat',
	\	'visual_words_and_chars': 'VisualWordsAndChars',
	\	'git_ps1_status': 'GitPS1Status'
	\ }

" This will set the coc linting stuff on the far right, and then my normal vim file info stuff to the left of that
let g:lightline.active = {
	\	'right': [
	\		[ 'linter_errors', 'linter_warnings', 'linter_info', 'linter_hints', 'linter_ok' ],
	\		[ 'lineinfo' ],
	\		[ 'percent' ],
	\		[ 'fileformat', 'fileencoding', 'filetype' ],
	\		[ 'visual_words_and_chars' ],
	\	],
	\	'left': [
	\		[ 'mode' ],
	\		[ 'readonly', 'git_ps1_status', 'filename', 'modified' ]
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
" }}}

" coc.nvim {{{
let g:coc_global_extensions = [
			\ 'coc-html',
			\ 'coc-dictionary',
			\ 'coc-java',
			\ 'coc-json',
			\ 'coc-pairs',
			\ 'coc-pyright',
			\ 'coc-rust-analyzer',
			\ 'coc-sh',
			\ 'coc-snippets',
			\ 'coc-tsserver',
			\ 'coc-ultisnips',
			\ 'coc-vimlsp',
			\ 'coc-vimtex',
			\ 'coc-word',
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

" Use Alt + Enter to trigger JetBrains-like codeActions
nnoremap <silent> <M-return> <Plug>(coc-codeaction-cursor)

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

" nvim-dap {{{
nnoremap <silent> <Plug>CustomDapToggleBreakpoint :lua require('dap').toggle_breakpoint()<CR>:call repeat#set("\<Plug>CustomDapToggleBreakpoint", v:count)<CR>
nnoremap <silent> <Plug>CustomDapContinue :lua require('dap').continue()<CR>:call repeat#set("\<Plug>CustomDapContinue", v:count)<CR>
nnoremap <silent> <Plug>CustomDapStepOver :lua require('dap').step_over()<CR>:call repeat#set("\<Plug>CustomDapStepOver", v:count)<CR>
nnoremap <silent> <Plug>CustomDapStepInto :lua require('dap').step_into()<CR>:call repeat#set("\<Plug>CustomDapStepInto", v:count)<CR>
nnoremap <silent> <Plug>CustomDapREPL :lua require('dap').repl.open()<CR>:call repeat#set("\<Plug>CustomDapREPL", v:count)<CR>

nnoremap <silent> <leader>db <Plug>CustomDapToggleBreakpoint
nnoremap <silent> <leader>dc <Plug>CustomDapContinue
nnoremap <silent> <leader>dso <Plug>CustomDapStepOver
nnoremap <silent> <leader>dsi <Plug>CustomDapStepInto
nnoremap <silent> <leader>dr <Plug>CustomDapREPL

nnoremap <silent> <leader>dst :lua require('dap').continue()<CR>
nnoremap <silent> <leader>dui :lua require('dapui').setup()<CR>:lua require('dapui').open()<CR>
" }}}

" telescope.nvim {{{
" Intentional trailing space
nnoremap <leader>T :Telescope 

nnoremap <silent> <leader>tf :Telescope find_files<CR>
nnoremap <silent> <leader>tg :Telescope live_grep<CR>
nnoremap <silent> <leader>tF :Telescope frecency<CR>
nnoremap <silent> <leader>ty :Telescope neoclip<CR>
nnoremap <silent> <leader>tq :Telescope macroscope<CR>
nnoremap <silent> <leader>tb :Telescope file_browser<CR>
nnoremap <silent> <leader>tp :Telescope project<CR>
nnoremap <silent> <leader>t? :Telescope cheatsheet<CR>
nnoremap <silent> <leader>th :Telescope heading<CR>
nnoremap <silent> <leader>ts :lua require('telescope.builtin').symbols{ sources = { 'latex', 'math', 'julia', 'nerd' } }<CR>

nnoremap <silent> <leader>tC :Telescope coc<CR>
nnoremap <silent> <leader>tcds :Telescope coc document_symbols<CR>
nnoremap <silent> <leader>tcws :Telescope coc workspace_symbols<CR>
nnoremap <silent> <leader>tcdi :Telescope coc diagnostics<CR>
nnoremap <silent> <leader>tcwd :Telescope coc workspace_diagnostics<CR>
" }}}
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

" Don't overwrite the default yank buffer when pasting
vnoremap p pgvy
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

" plugins.lua {{{
augroup packer_config_augroup
	autocmd!
	" Re-compile plugins whenever config is changed
	autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup END
" }}}

" Resume cursor position {{{
augroup resume_cursor_position_augroup
	autocmd!

	" Adapted from https://stackoverflow.com/a/3699926/12985838
	" Resume cursor position, expand folds up to cursor line, and center cursor line on the screen
	autocmd BufReadPost *
		\	if line("'\"") > 0 && line ("'\"") <= line("$") |
		\		exe "normal g'\"" |
		\		exe "normal zv" |
		\		exe "normal zz" |
		\	endif
augroup END
" }}}

" Rust {{{
augroup rust_augroup
	autocmd!

	autocmd BufWritePost *.rs RustFmt | w
augroup END
" }}}
" }}}

" ########## SIMPLE COMMANDS ########## {{{

" Remove all trailing spaces
command Rmsp execute '%s/\s\+$//e'

command Q execute "q!"
command W execute "wq"
" }}}

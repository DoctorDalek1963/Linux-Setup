syntax on
filetype indent plugin on

colorscheme ron

set number relativenumber " Set number options
set ruler
set ignorecase hlsearch incsearch " Set search options

" Show spaces and tabs
set list
set listchars=space:·
set listchars+=tab:>-

" Always use 4 spaces when tab is pressed
set tabstop=4 " 4 spaces per tab
set shiftwidth=4
set expandtab

" Wrapper func for Pydoc call
function PydocFunc(name)
    execute '!pydoc '.expand(a:name)
endfunction

command -nargs=1 Pydoc call PydocFunc('<args>')

command Rmhl execute "nohlsearch"
command Q execute "q!"
command W execute "wq"

" Easily tab through panes
map <Tab> <C-W>w
" Easier 4 directional navigation
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Easier splitting into new panes
map <Bar> <C-W>v<C-l>
map - <C-W>s<C-j>

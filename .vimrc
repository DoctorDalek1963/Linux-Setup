syntax on
filetype indent plugin on

set number relativenumber " Set number options
set ruler
set ignorecase hlsearch incsearch " Search options

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

" Maps to use hjkl to easily switch panes
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
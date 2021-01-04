syntax on
filetype indent plugin on

colorscheme ron " Nicer for dark terminals, mine is #002b36 with an opacity of 93%

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
command E execute "edit"

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

" Close all windows and quit
map <leader>Q <C-w>o:q<CR>

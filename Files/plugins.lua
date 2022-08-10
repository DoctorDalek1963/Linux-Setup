return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

	use { 'neoclide/coc.nvim', branch = 'release' }

	use 'preservim/NERDTree'
	use 'andymass/vim-matchup'

	use 'luochen1990/rainbow'

	use 'preservim/nerdcommenter'
	use 'airblade/vim-gitgutter'
	use 'tpope/vim-surround'
	use 'sheerun/vim-polyglot'

	use 'joshdick/onedark.vim'

	use 'JuliaEditorSupport/julia-vim'

	use 'godlygeek/tabular'

	use 'jeetsukumaran/vim-pythonsense'
	use 'vim-python/python-syntax'
	use 'Konfekt/FastFold'

	use 'tmhedberg/SimpylFold'

	use 'petRUShka/vim-sage'

	use 'lervag/vimtex'

	use 'unblevable/quick-scope'

	use 'Yggdroot/indentLine'

	use 'SirVer/ultisnips'
	use 'honza/vim-snippets'

	use 'dense-analysis/ale'

	use 'itchyny/lightline.vim'
	use 'maximbaz/lightline-ale'
	use 'josa42/vim-lightline-coc'
end)

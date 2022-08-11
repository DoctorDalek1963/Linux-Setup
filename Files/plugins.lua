local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
	vim.cmd [[packadd packer.nvim]]
end

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

	use { 'neoclide/coc.nvim', branch = 'release' }

	use 'mfussenegger/nvim-dap'

	use {
		'mfussenegger/nvim-dap-python',
		config = function()
			require('dap-python').setup('~/.local/bin/python')
			require('dap-python').test_runner = 'pytest'
		end
	}

	use {
		'rcarriga/nvim-dap-ui',
		requires = 'mfussenegger/nvim-dap',
		config = function()
			require('dapui').setup {
				layouts = {
					{
						elements = {
							'scopes',
							'breakpoints',
							'stacks',
							'watches'
						},
						size = 0.3, -- 30% of total width
						position = 'left',
					},
					{
						elements = { 'repl' },
						size = 0.25, -- 25% of total lines
						position = 'bottom',
					},
				},
			}
		end
	}

	use {
		'theHamsta/nvim-dap-virtual-text',
		requires = {
			'nvim-dap',
			'nvim-treesitter'
		},
		config = function()
			require('nvim-dap-virtual-text').setup {
				enable = true,
				highlight_changed_variables = true,
				highlight_new_as_changed = true,
				all_frames = true
			}
		end
	}

	use { 'p00f/nvim-ts-rainbow', requires = 'nvim-treesitter' }

	use {
		'nvim-treesitter/nvim-treesitter-context',
		requires = 'nvim-treesitter',
		config = function()
			require('treesitter-context').setup {
				enable = true,
				pattern = {
					default = {
						'class',
						'function',
						'method',
						'for',
						'while',
						'if',
						'switch',
						'case',
						'try'
					}
				}
			}
		end
	}

	use {
		'lewis6991/spellsitter.nvim',
		requires = 'nvim-treesitter',
		config = function() require('spellsitter').setup() end
	}

	use {
		'nvim-treesitter/nvim-treesitter',
		run = function()
			require('nvim-treesitter.install').update({ with_sync = true })
		end,
		config = function()
			require('nvim-treesitter.configs').setup {
				ensure_installed = 'all',
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false
				},

				-- p00f/nvim-ts-rainbow
				rainbow = {
					enable = true,
					extended_mode = true,
					max_file_lines = nil
				},
			}
		end
	}

	use 'preservim/NERDTree'
	use 'preservim/nerdcommenter'

	use 'andymass/vim-matchup'
	use 'airblade/vim-gitgutter'
	use 'tpope/vim-surround'
	use 'tpope/vim-repeat'
	use 'sheerun/vim-polyglot'

	use 'joshdick/onedark.vim'

	use { 'JuliaEditorSupport/julia-vim', ft = 'julia' }

	use 'godlygeek/tabular'
	use 'Konfekt/FastFold'

	use { 'jeetsukumaran/vim-pythonsense', ft = 'python' }
	use { 'vim-python/python-syntax', ft = 'python' }
	use { 'tmhedberg/SimpylFold', ft = 'python' }

	use { 'petRUShka/vim-sage', ft = 'sage' }

	use { 'lervag/vimtex', ft = { 'tex', 'latex' } }

	use 'unblevable/quick-scope'

	use 'Yggdroot/indentLine'

	use 'SirVer/ultisnips'
	use 'honza/vim-snippets'

	use 'dense-analysis/ale'

	use 'itchyny/lightline.vim'
	use 'maximbaz/lightline-ale'
	use 'josa42/vim-lightline-coc'

	if packer_bootstrap then
		require('packer').sync()
	end
end)

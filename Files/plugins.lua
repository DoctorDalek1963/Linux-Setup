local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
	vim.cmd [[packadd packer.nvim]]
end

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

	use {
		'neoclide/coc.nvim',
		branch = 'release',
		run = ':CocUpdate'
	}

	use {
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		requires = {
			'nvim-lua/plenary.nvim',
			{ 'BurntSushi/ripgrep', run = 'rustup run nightly cargo install --path . && rustup run nightly cargo clean' },
			{ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
			{ 'sharkdp/fd', run = 'cargo binstall --force -y fd-find' },
			'nvim-treesitter',
			'kyazdani42/nvim-web-devicons'
		}
	}

	use {
		'AckslD/nvim-neoclip.lua',
		requires = {
			'telescope.nvim',
			{ 'kkharji/sqlite.lua', module = 'sqlite' }
		},
		config = function()
			local function is_whitespace(line)
				return vim.fn.match(line, [[^\s*$]]) ~= -1
			end

			local function is_single_char(text)
				return vim.fn.match(text, [[^.$]]) ~= -1
			end

			local function filter_yanks(tbl)
				for _, entry in ipairs(tbl) do
					if is_whitespace(entry) or is_single_char(entry) then
						return false
					end
				end
				return true
			end

			require('neoclip').setup {
				history = 1000,
				enable_persistent_history = true,
				continuous_sync = true,
				default_register_macros = 'w',
				filter = function(data)
					return filter_yanks(data.event.regcontents)
				end
			}
			require('telescope').load_extension('neoclip')
			require('telescope').load_extension('macroscope')
		end
	}

	use {
		'nvim-telescope/telescope-file-browser.nvim',
		config = function()
			require('telescope').load_extension('file_browser')
		end
	}

	use {
		'sudormrfbin/cheatsheet.nvim',
		requires = {
			'nvim-lua/plenary.nvim',
			'telescope.nvim'
		},
		config = function()
			require('telescope').load_extension('cheatsheet')
		end
	}

	use {
		'fannheyward/telescope-coc.nvim',
		requires = {
			{ 'coc.nvim', branch = 'release' },
			'telescope.nvim'
		},
		config = function()
			require('telescope').load_extension('coc')
		end
	}

	use {
		'nvim-telescope/telescope-symbols.nvim',
		requires = 'telescope.nvim'
	}

	use {
		'fhill2/telescope-ultisnips.nvim',
		requires = {
			'telescope.nvim',
			'ultisnips'
		},
		config = function()
			require('telescope').load_extension('ultisnips')
		end
	}

	--use {
		--'mfussenegger/nvim-dap',
		--config = function()
			--local dap = require('dap')

			--dap.adapters.rust = {
				--type = 'executable',
				--command = 'lldb',
			--}
			--dap.configurations.rust = {
				--{
					--type = 'rust',
					--request = 'launch',
					--name = 'Launch file',
					--program = '${file}',
				--},
				--{
					--type = 'rust',
					--request = 'launch',
					--name = 'Launch file with arguments',
					--program = '${file}',
					--args = function()
						--local args_string = vim.fn.input('Arguments: ')
						--return vim.split(args_string, " +")
					--end,
				--},
			--}
		--end,
		--cmd = 'EnableDap'
	--}

	--use {
		--'mfussenegger/nvim-dap-python',
		--requires = 'nvim-dap',
		--config = function()
			--require('dap-python').setup(io.popen('which python'):read())
			--require('dap-python').test_runner = 'pytest'

			--table.insert(
				--require('dap').configurations.python,
				--{
					--type = 'python',
					--request = 'launch',
					--name = 'Launch installed module',
					--module = function() return vim.fn.input('Module name: ') end
				--}
			--)
		--end,
		--ft = 'python',
		--cmd = 'EnableDap'
	--}

	--use {
		--'rcarriga/nvim-dap-ui',
		--requires = 'nvim-dap',
		--config = function()
			--require('dapui').setup {
				--layouts = {
					--{
						--elements = {
							--'scopes',
							--'breakpoints',
							--'stacks',
							--'watches'
						--},
						--size = 0.3, -- 30% of total width
						--position = 'left',
					--},
					--{
						--elements = { 'repl' },
						--size = 0.25, -- 25% of total lines
						--position = 'bottom',
					--},
				--},
			--}
		--end,
		--cmd = 'EnableDap'
	--}

	--use {
		--'theHamsta/nvim-dap-virtual-text',
		--requires = {
			--'nvim-dap',
			--'nvim-treesitter'
		--},
		--config = function()
			--require('nvim-dap-virtual-text').setup {
				--enable = true,
				--highlight_changed_variables = true,
				--highlight_new_as_changed = true,
				--all_frames = true
			--}
		--end,
		--cmd = 'EnableDap'
	--}

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
		'IndianBoy42/tree-sitter-just',
		requires = 'nvim-treesitter',
		config = function() require('tree-sitter-just').setup({}) end,
		ft = 'just'
	}

	use {
		'nvim-treesitter/nvim-treesitter',
		run = function()
			require('nvim-treesitter.install').update({ with_sync = true })
			vim.cmd [[TSUpdate]]
		end,
		config = function()
			require('nvim-treesitter.configs').setup {
				ensure_installed = 'all',
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
					disable = { 'latex' },
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

	use {
		"iamcco/markdown-preview.nvim",
		run = function() vim.fn["mkdp#util#install"]() end,
		ft = 'markdown'
	}

	use 'nathom/filetype.nvim'

	use 'preservim/NERDTree'
	use 'preservim/nerdcommenter'
	use 'preservim/vim-pencil'

	use 'junegunn/goyo.vim'

	use 'andymass/vim-matchup'
	use 'airblade/vim-gitgutter'
	use 'sheerun/vim-polyglot'

	use 'ron-rs/ron.vim'
	use 'avli/vim-lox-syntax'
	use 'vim-scripts/coq-syntax'

	use 'tpope/vim-eunuch'
	use 'tpope/vim-fugitive'
	use 'tpope/vim-repeat'
	use 'tpope/vim-surround'

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

	use 'itchyny/lightline.vim'
	use 'josa42/vim-lightline-coc'

	use 'chaoren/vim-wordmotion'

	use 'neovimhaskell/haskell-vim'

	use {
		'anuvyklack/windows.nvim',
		requires = {
			'anuvyklack/middleclass',
			'anuvyklack/animation.nvim'
		},
		config = function()
			vim.o.winwidth = 15
			vim.o.winminwidth = 0
			vim.o.equalalways = false
			require('windows').setup()
		end
	}

	if packer_bootstrap then
		require('packer').sync()
	end
end)

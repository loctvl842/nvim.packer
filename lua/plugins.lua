local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
-- vim.cmd([[
-- augroup packer_user_config
-- autocmd!
-- autocmd BufWritePost plugins.lua source <afile> | PackerSync
-- augroup end
-- ]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
	profile = {
		enable = true,
		threshold = 0.0001,
	},
	git = {
		clone_timeout = 300,
		subcommands = {
			update = "pull --rebase",
		},
	},
	auto_clean = true,
	compile_on_sync = true,
})

-- Install your plugins here
return packer.startup(function(use)
	use({ -- General
		"wbthomason/packer.nvim",
		commit = "6afb67460283f0e990d35d229fd38fdc04063e0a",
	})
	---------------------------------- LSP ------------------------------------------
	use({
		"neovim/nvim-lspconfig", -- enable LSP
		commit = "9d4b8d393aad0e6e9227e2d67629aa99e56b994a",
	})
	use({
		"jose-elias-alvarez/null-ls.nvim", -- for formatters and linters
		commit = "3d76bb2968310f7e18a20711ac89c5e7b07e8c93",
	})
	use({
		"ray-x/lsp_signature.nvim", -- Recommend type of parameter of function
		commit = "e65a63858771db3f086c8d904ff5f80705fd962b",
	})
	use({
		"lvimuser/lsp-inlayhints.nvim",
		commit = "9bcd6fe25417b7808fe039ab63d4224f2071d24a",
	})
	use({ "williamboman/mason.nvim" })
	use({ "williamboman/mason-lspconfig.nvim" })
	------------------------------ CMP PLUGIN --------------------------------------
	use({
		"hrsh7th/cmp-nvim-lsp",
		commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8",
	})
	use({
		"hrsh7th/cmp-buffer", -- buffer completions
		commit = "c46b6688f0fa1331c7e4b13b32fcba3826aa956a",
	})
	use({
		"hrsh7th/cmp-path", -- path completions
		commit = "f244d8c33387b2da8915eabf9d2296a4f4ba3e45",
	})
	use({
		"hrsh7th/cmp-cmdline", -- cmdline completions
		commit = "c36ca4bc1dedb12b4ba6546b96c43896fd6e7252",
	})
	use({
		"hrsh7th/nvim-cmp", -- The completion plugin
		commit = "0e436ee23abc6c3fe5f3600145d2a413703e7272",
	})
	use({
		"saadparwaiz1/cmp_luasnip", -- snippet completions
		commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36",
	})
	use({
		"hrsh7th/cmp-nvim-lua",
		commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21",
	})
	-- java
	use({
		"mfussenegger/nvim-jdtls",
		commit = "0422245fdef57aa4eddba3d99aee1afaaf425da7",
	})
	---------------------------- SNIPPET & EMMET ----------------------------------
	use({
		"L3MON4D3/LuaSnip", -- snippet engine
		commit = "c599c560ed26f04f5bdb7e4498b632dc16fb9209",
	})
	use({
		"rafamadriz/friendly-snippets", -- a bunch of snippets to use
		commit = "471f3ab20c1ee02d33830f379caaa8edfbd39808",
	})
	use({
		"mattn/emmet-vim", -- emmet
		commit = "f4c999bdf2a21b9d96132f6cd04a9e19eb7e87ff",
	})
	------------------------------ TREESITTER --------------------------------------
	use({
		"nvim-treesitter/nvim-treesitter",
		commit = "b273a06728305c1e7bd0179977ca48049aeff5e6",
	})
	use({
		"nvim-treesitter/playground",
		-- commit = "e6a0bfaf9b5e36e3a327a1ae9a44a989eae472cf",
	})
	use({
		"JoosepAlviste/nvim-ts-context-commentstring",
		commit = "4d3a68c41a53add8804f471fcc49bb398fe8de08",
	})
	use({
		"p00f/nvim-ts-rainbow",
		commit = "e486fad0aa038e346995e2477affd5269f2dcbea",
	})
	use({
		"windwp/nvim-ts-autotag",
		commit = "044a05c4c51051326900a53ba98fddacd15fea22",
	})
	---------------------------------- UI ------------------------------------------
	use("loctvl842/nvim-web-devicons")
	use({
		"akinsho/bufferline.nvim",
		-- event = "UIEnter",
		--   config = function() require "configs.bufferline" end,
	})
	use({ "loctvl842/winbar" }) -- Make simple root name
	-- use({ "loctvl842/colorscheme", branch = "float" }) -- Colorschemes main | float | slant
	use({ "loctvl842/monokai-plus.nvim" })
	use({
		"nvim-lualine/lualine.nvim",
		commit = "a52f078026b27694d2290e34efa61a6e4a690621",
	})
	use({
		"loctvl842/neo-tree.nvim",
		requires = {
			"MunifTanjim/nui.nvim",
			commit = "35758e946a64376e0e9625a27469410b3d1f9223",
		},
	})
	use({ -- Start up nvim Ui
		"goolord/alpha-nvim",
	})
	use({ -- float terminal
		"akinsho/toggleterm.nvim",
		commit = "8f2e78d0256eba4896c8514aa150e41e63f7d5b2",
	})
	use({
		"zbirenbaum/neodim", -- better highlight for unused variable
		-- commit = "9c9c69ab59135ccbf823c7fda16bc87ea57431db",
	})
	use({ "onsails/lspkind.nvim" })
	---------------------------------- UTIL ----------------------------------------
	use({ -- Keybinding
		"folke/which-key.nvim",
		commit = "6885b669523ff4238de99a7c653d47b081b5506d",
	})
	use({ -- Simplify compile with a responsive float terminal
		"loctvl842/compile-nvim",
	})
	use({ -- Useful lua functions used ny lots of plugins
		"nvim-lua/plenary.nvim", -- A Lua module for asynchronous programming using coroutines.
		commit = "968a4b9afec0c633bc369662e78f8c5db0eba249",
	})
	use({ -- Autopairs, integrates with both cmp and treesitter
		"windwp/nvim-autopairs",
		commit = "4a95b3982be7397cd8e1370d1a09503f9b002dbf",
	})
	use({ -- Easily comment stuff
		"numToStr/Comment.nvim",
		commit = "d30f2b059c0c03fcfab3842684212bac525a3d0b",
	})
	use({ -- Ranger
		"kevinhwang91/rnvimr",
		commit = "5877509cfdbf3a0382ff24198a3f730b476f8262",
	})
	use({ -- :Bdelete and no [no file]
		"moll/vim-bbye",
		commit = "5d4d3c957e05a4478998e1f40f3b86d05bd72963",
	})
	use({ -- Search project
		"ahmedkhalf/project.nvim",
		commit = "92166ca6cf94a6a793abbd2629652884f50b7364",
	})
	use({ -- Seep up loading Lua modules in neovim to improve startup time
		"lewis6991/impatient.nvim",
		commit = "969f2c5c90457612c09cf2a13fee1adaa986d350",
	})
	use({
		"lukas-reineke/indent-blankline.nvim",
		commit = "052c880396076af074f1ff3d3eb687cb36018dfa",
	})
	use({ -- Telescope
		"nvim-telescope/telescope.nvim",
		commit = "f174a0367b4fc7cb17710d867e25ea792311c418",
	})
	use({ -- Git
		"lewis6991/gitsigns.nvim",
		commit = "9787c94178b4062f30d2f06b6d52984217196647",
	})
	use({ -- Multi cursor
		"mg979/vim-visual-multi",
		branch = "master",
		commit = "e522dd192eb19d060a8bc312fb51fe4af49aadb1",
	})
	use({ -- Real color of rgba or hex color
		"norcalli/nvim-colorizer.lua",
		commit = "36c610a9717cc9ec426a07c8e6bf3b3abcb139d6",
	})
	use({ -- Rename
		"filipdutescu/renamer.nvim",
		branch = "master",
	})
	use({ -- better ui for showing error or warning
		"rcarriga/nvim-notify",
		commit = "7caeaaef257ecbe95473ec79e5a82757b544f1fd",
	})
	use({ -- better preview markdown
		"iamcco/markdown-preview.nvim",
		commit = "9becceee5740b7db6914da87358a183ad11b2049",
	})
	use({ -- Save job as session
		"rmagatti/auto-session",
		commit = "50f5f2eaa7ff825c7036dc3c9981ebae7584b48e",
	})
	use({ -- Add mapping 'dd' to delete session
		"loctvl842/session-lens",
	})
	use({
		"kevinhwang91/nvim-ufo",
		commit = "fdbb1f5d56cbe72f88ecf8aa1313ba7c0dc33725",
		requires = "kevinhwang91/promise-async",
	})
	use({
		"kosayoda/nvim-lightbulb",
		requires = "antoinemadec/FixCursorHold.nvim",
	})
	use({ "gorbit99/codewindow.nvim" })

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)

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
vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]])

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
})

-- Install your plugins here
return packer.startup(function(use)
	-- UI
	use("loctvl842/dev-icons")
	use({ "rcarriga/nvim-notify", commit = "7caeaaef257ecbe95473ec79e5a82757b544f1fd" })
	use({ "loctvl842/bufferline" })
	use("loctvl842/winbar")
	use({ "folke/which-key.nvim", commit = "bd4411a2ed4dd8bb69c125e339d837028a6eea71" })
	use({
		"loctvl842/neo-tree.nvim",
		requires = { "MunifTanjim/nui.nvim", commit = "ec64b753eb2b0fa75631d770b1d4a414036a3d11" },
	})
	-- neo-tree
	-- Unless you are still migrating, remove the deprecated commands from v1.x
	-- vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

	-- Colorschemes
	use("loctvl842/colorscheme")

	-- General
	use({ "wbthomason/packer.nvim", commit = "00ec5adef58c5ff9a07f11f45903b9dbbaa1b422" }) -- Have packer manage itself
	-- use({ "nvim-lua/popup.nvim", commit = "b7404d35d5d3548a82149238289fa71f7f6de4ac" }) -- An implementation of the Popup API from vim in Neovim
	use({ "nvim-lua/plenary.nvim", commit = "968a4b9afec0c633bc369662e78f8c5db0eba249" }) -- Useful lua functions used ny lots of plugins
	use({ "windwp/nvim-autopairs", commit = "4a95b3982be7397cd8e1370d1a09503f9b002dbf" }) -- Autopairs, integrates with both cmp and treesitter
	use({ "numToStr/Comment.nvim", commit = "2c26a00f32b190390b664e56e32fd5347613b9e2" }) -- Easily comment stuff
	-- Ranger
	use({ "kevinhwang91/rnvimr", commit = "5877509cfdbf3a0382ff24198a3f730b476f8262" })

	use({ "moll/vim-bbye", commit = "5d4d3c957e05a4478998e1f40f3b86d05bd72963" })
	use({ "nvim-lualine/lualine.nvim", commit = "5113cdb32f9d9588a2b56de6d1df6e33b06a554a" })
	use({ "akinsho/toggleterm.nvim", commit = "8f2e78d0256eba4896c8514aa150e41e63f7d5b2" })

	-- Seep up loading Lua modules in neovim to improve startup time
	use({ "ahmedkhalf/project.nvim", commit = "92166ca6cf94a6a793abbd2629652884f50b7364" })
	use({ "lewis6991/impatient.nvim", commit = "969f2c5c90457612c09cf2a13fee1adaa986d350" })
	use({ "lukas-reineke/indent-blankline.nvim", commit = "38b3567bc5d72a338699bd489a4b4e8e5b9b40e7" })
	use({ "goolord/alpha-nvim", commit = "ef27a59e5b4d7b1c2fe1950da3fe5b1c5f3b4c94" })
	use({ "antoinemadec/FixCursorHold.nvim", commit = "100981c4e4f224a019e028f7d56cbd1da5c1bf5d" }) -- This is needed to fix lsp doc highlight

	-- cmp plugins
	use({ "hrsh7th/nvim-cmp", commit = "8cab7889766d715b1107b9967a4077568c41ee2a" }) -- The completion plugin
	use({ "hrsh7th/cmp-buffer", commit = "c46b6688f0fa1331c7e4b13b32fcba3826aa956a" }) -- buffer completions
	use({ "hrsh7th/cmp-path", commit = "f244d8c33387b2da8915eabf9d2296a4f4ba3e45" }) -- path completions
	use({ "hrsh7th/cmp-cmdline", commit = "c36ca4bc1dedb12b4ba6546b96c43896fd6e7252" }) -- cmdline completions
	use({ "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" }) -- snippet completions
	use({ "hrsh7th/cmp-nvim-lsp", commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" })
	use({ "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" })

	-- snippets
	use({ "L3MON4D3/LuaSnip", commit = "aa1c36fa6786d2a5023a007f33c5a9dddbeb061e" }) --snippet engine
	use({ "rafamadriz/friendly-snippets", commit = "471f3ab20c1ee02d33830f379caaa8edfbd39808" }) -- a bunch of snippets to use

	-- emmet
	use({ "mattn/emmet-vim", commit = "f4c999bdf2a21b9d96132f6cd04a9e19eb7e87ff" })

	-- LSP
	use({ "neovim/nvim-lspconfig", commit = "8c2b8d490f91eb72a43a3d47c356d9bc96ccc983" }) -- enable LSP
	use({ "williamboman/nvim-lsp-installer", commit = "ed999f0a555e83932f8e400c8830679c0bb499b8" }) -- simple to use language server installer
	use({ "jose-elias-alvarez/null-ls.nvim", commit = "741894f047966f0f45d7938d0fe4473c7635c6d3" }) -- for formatters and linters
	use({ "RRethy/vim-illuminate", commit = "c82e6d04f27a41d7fdcad9be0bce5bb59fcb78e5" })
	use({ "ray-x/lsp_signature.nvim", commit = "86f0310c095ed72607359fd9a4aef1f375d8fbec" })

	-- Telescope
	use({ "nvim-telescope/telescope.nvim", commit = "e7e90466de0571d39fe642cdfec1c577451b8be1" })

	-- Treesitter
	use({ "nvim-treesitter/nvim-treesitter", commit = "901ffe1a363f21c168eacf011dce4f905fd26d5f" })
	use("nvim-treesitter/playground")
	use({ "JoosepAlviste/nvim-ts-context-commentstring", commit = "831cc1c47c2b3f88b3981f3ed033c6e973706c1f" })
	use({ "windwp/nvim-ts-autotag", commit = "044a05c4c51051326900a53ba98fddacd15fea22" })

	-- Git
	use({ "lewis6991/gitsigns.nvim", commit = "4883988cf8b623f63cc8c7d3f11b18b7e81f06ff" })

	-- Multi cursor
	use({ "mg979/vim-visual-multi", branch = "master", commit = "e522dd192eb19d060a8bc312fb51fe4af49aadb1" })

	-- Colorizer
	use({ "lilydjwg/colorizer", commit = "bafd4e98462a4ddeb275d02fa1448b4349e2e50f" })

	use({ "filipdutescu/renamer.nvim", branch = "master", commit = "eecd939c68312a1a4c1744699189eaf61f4c6027" })

	use({ "zbirenbaum/neodim", commit = "9c9c69ab59135ccbf823c7fda16bc87ea57431db" })

	-- install without yarn or npm
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})

	use({ "iamcco/markdown-preview.nvim" })
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)

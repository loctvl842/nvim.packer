-- local fn = vim.fn

-- -- Automatically install packer
-- local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
-- if fn.empty(fn.glob(install_path)) > 0 then
-- 	PACKER_BOOTSTRAP = fn.system({
-- 		"git",
-- 		"clone",
-- 		"--depth",
-- 		"1",
-- 		"https://github.com/wbthomason/packer.nvim",
-- 		install_path,
-- 	})
-- 	print("Installing packer close and reopen Neovim...")
-- 	vim.cmd([[packadd packer.nvim]])
-- end

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

local tvl_plugins = {
	-- Plugin manager
	["wbthomason/packer.nvim"] = {
		config = function()
			require("configs.mason")
		end,
	},

	---------------------------------- LSP ------------------------------------------
	["neovim/nvim-lspconfig"] = {
		commit = "9d4b8d393aad0e6e9227e2d67629aa99e56b994a",
	},

	["jose-elias-alvarez/null-ls.nvim"] = {
		-- event = "BufEnter",
		commit = "3d76bb2968310f7e18a20711ac89c5e7b07e8c93",
	},

	["ray-x/lsp_signature.nvim"] = {
		commit = "e65a63858771db3f086c8d904ff5f80705fd962b",
	},

	["lvimuser/lsp-inlayhints.nvim"] = {
		commit = "9bcd6fe25417b7808fe039ab63d4224f2071d24a",
	},

	["williamboman/mason.nvim"] = {},

	["williamboman/mason-lspconfig.nvim"] = {},

	------------------------------ CMP PLUGIN --------------------------------------
	["hrsh7th/nvim-cmp"] = {
		commit = "0e436ee23abc6c3fe5f3600145d2a413703e7272",
		config = function()
			require("configs.cmp")
		end,
	},

	["hrsh7th/cmp-nvim-lsp"] = {
		commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8",
	},

	["hrsh7th/cmp-buffer"] = {
		commit = "c46b6688f0fa1331c7e4b13b32fcba3826aa956a",
	},

	["hrsh7th/cmp-path"] = {
		commit = "f244d8c33387b2da8915eabf9d2296a4f4ba3e45",
	},

	["hrsh7th/cmp-cmdline"] = {
		commit = "c36ca4bc1dedb12b4ba6546b96c43896fd6e7252",
	},

	["saadparwaiz1/cmp_luasnip"] = {
		commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36",
	},

	["hrsh7th/cmp-nvim-lua"] = {
		commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21",
	},

	["mfussenegger/nvim-jdtls"] = {
		commit = "0422245fdef57aa4eddba3d99aee1afaaf425da7",
	},

	---------------------------- SNIPPET & EMMET ----------------------------------
	["L3MON4D3/LuaSnip"] = {
		commit = "c599c560ed26f04f5bdb7e4498b632dc16fb9209",
	},

	["rafamadriz/friendly-snippets"] = {
		commit = "471f3ab20c1ee02d33830f379caaa8edfbd39808",
	},

	["honza/vim-snippets"] = {},

	["mattn/emmet-vim"] = {
		commit = "f4c999bdf2a21b9d96132f6cd04a9e19eb7e87ff",
		config = function()
			require("configs.emmet")
		end,
	},

	------------------------------ TREESITTER --------------------------------------
	["nvim-treesitter/nvim-treesitter"] = {
		commit = "b273a06728305c1e7bd0179977ca48049aeff5e6",
		event = "BufEnter",
		cmd = {
			"TSInstall",
			"TSInstallInfo",
			"TSInstallSync",
			"TSUninstall",
			"TSUpdate",
			"TSUpdateSync",
			"TSDisableAll",
			"TSEnableAll",
		},
		config = function()
			require("configs.treesitter")
		end,
	},

	["nvim-treesitter/playground"] = {
		commit = "e6a0bfaf9b5e36e3a327a1ae9a44a989eae472cf",
		after = "nvim-treesitter",
	},

	["JoosepAlviste/nvim-ts-context-commentstring"] = {
		commit = "4d3a68c41a53add8804f471fcc49bb398fe8de08",
		after = "nvim-treesitter",
	},

	["p00f/nvim-ts-rainbow"] = {
		after = "nvim-treesitter",
	},

	["windwp/nvim-ts-autotag"] = {
		commit = "044a05c4c51051326900a53ba98fddacd15fea22",
		after = "nvim-treesitter",
		config = function()
			require("configs.auto-closetag")
		end,
	},

	---------------------------------- UI ------------------------------------------
	["loctvl842/nvim-web-devicons"] = {},

	["akinsho/bufferline.nvim"] = {
		config = function()
			require("configs.bufferline")
		end,
	},

	["loctvl842/winbar"] = {
		event = "BufEnter",
		config = function()
			require("configs.winbar")
		end,
	},

	["loctvl842/monokai-plus.nvim"] = {
		config = function()
			require("configs.colorscheme")
		end,
	},

	["nvim-lualine/lualine.nvim"] = {
		commit = "a52f078026b27694d2290e34efa61a6e4a690621",
		config = function()
			require("configs.lualine")
		end,
	},

	["loctvl842/neo-tree.nvim"] = {
		config = function()
			require("configs.neo-tree")
		end,
		requires = {
			"MunifTanjim/nui.nvim",
			commit = "35758e946a64376e0e9625a27469410b3d1f9223",
		},
	},

	["goolord/alpha-nvim"] = {
		config = function()
			require("configs.alpha")
		end,
	},

	["akinsho/toggleterm.nvim"] = {
		commit = "8f2e78d0256eba4896c8514aa150e41e63f7d5b2",
		config = function()
			require("configs.toggleterm")
		end,
	},

	["zbirenbaum/neodim"] = {
		event = "LspAttach",
		config = function()
			require("configs.neodim")
		end,
	},

	["onsails/lspkind.nvim"] = {},

	---------------------------------- UTIL ----------------------------------------
	["folke/which-key.nvim"] = {
		commit = "6885b669523ff4238de99a7c653d47b081b5506d",
		config = function()
			require("configs.whichkey")
		end,
	},

	["loctvl842/compile-nvim"] = {
		config = function()
			require("configs.compile")
		end,
	},

	["nvim-lua/plenary.nvim"] = {
		commit = "968a4b9afec0c633bc369662e78f8c5db0eba249",
	},

	["windwp/nvim-autopairs"] = {
		commit = "4a95b3982be7397cd8e1370d1a09503f9b002dbf",
		config = function()
			require("configs.autopairs")
		end,
	},

	["numToStr/Comment.nvim"] = {
		commit = "d30f2b059c0c03fcfab3842684212bac525a3d0b",
		config = function()
			require("configs.comment")
		end,
	},

	["kevinhwang91/rnvimr"] = {
		commit = "5877509cfdbf3a0382ff24198a3f730b476f8262",
		config = function()
			require("configs.ranger")
		end,
	},

	["moll/vim-bbye"] = {
		commit = "5d4d3c957e05a4478998e1f40f3b86d05bd72963",
	},

	["ahmedkhalf/project.nvim"] = {
		commit = "92166ca6cf94a6a793abbd2629652884f50b7364",
		config = function()
			require("configs.project")
		end,
	},

	["lewis6991/impatient.nvim"] = {
		commit = "969f2c5c90457612c09cf2a13fee1adaa986d350",
	},

	["lukas-reineke/indent-blankline.nvim"] = {
		commit = "052c880396076af074f1ff3d3eb687cb36018dfa",
		config = function()
			require("configs.indentline")
		end,
	},

	["nvim-telescope/telescope.nvim"] = {
		commit = "f174a0367b4fc7cb17710d867e25ea792311c418",
		config = function()
			require("configs.telescope")
		end,
	},

	["lewis6991/gitsigns.nvim"] = {
		commit = "9787c94178b4062f30d2f06b6d52984217196647",
		config = function()
			require("configs.gitsigns")
		end,
	},

	["mg979/vim-visual-multi"] = {
		commit = "e522dd192eb19d060a8bc312fb51fe4af49aadb1",
		branch = "master",
	},

	["norcalli/nvim-colorizer.lua"] = {
		commit = "36c610a9717cc9ec426a07c8e6bf3b3abcb139d6",
		config = function()
			require("configs.colorizer")
		end,
	},

	["filipdutescu/renamer.nvim"] = {
		branch = "master",
		config = function()
			require("configs.renamer")
		end,
	},

	["rcarriga/nvim-notify"] = {
		commit = "7caeaaef257ecbe95473ec79e5a82757b544f1fd",
		event = "UIEnter",
		config = function()
			require("configs.notify")
		end,
	},

	["iamcco/markdown-preview.nvim"] = {
		commit = "9becceee5740b7db6914da87358a183ad11b2049",
	},

	["rmagatti/auto-session"] = {
		commit = "50f5f2eaa7ff825c7036dc3c9981ebae7584b48e",
		config = function()
			require("configs.auto-session")
		end,
	},

	["loctvl842/session-lens"] = {
		config = function()
			require("configs.session-lens")
		end,
	},

	["kevinhwang91/nvim-ufo"] = {
		commit = "fdbb1f5d56cbe72f88ecf8aa1313ba7c0dc33725",
		requires = "kevinhwang91/promise-async",
		config = function()
			require("configs.ufo")
		end,
	},

	["kosayoda/nvim-lightbulb"] = {
		requires = "antoinemadec/FixCursorHold.nvim",
		config = function()
			require("configs.lightbulb")
		end,
	},

	["gorbit99/codewindow.nvim"] = {
		config = function()
			require("configs.codewindow")
		end,
	},

	-- Smooth escaping
	["max397574/better-escape.nvim"] = {
		-- event = "InsertCharPre",
		config = function()
			require("configs.better_escape")
		end,
	},
}

local user_plugin_opts = tvl.user_plugin_opts
packer.startup({
	function(use)
		for key, plugin in pairs(user_plugin_opts("plugins.init", tvl_plugins)) do
			if type(key) == "string" and not plugin[1] then
				plugin[1] = key
			end
			use(plugin)
		end
	end,

	config = user_plugin_opts("plugins.packer", {
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
	}),
})

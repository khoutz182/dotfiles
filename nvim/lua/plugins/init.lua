
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
	use("wbthomason/packer.nvim")

	use("nvim-lua/plenary.nvim")
	use("neovim/nvim-lspconfig")

	-- use("RRethy/nvim-base16")
	use("marko-cerovac/material.nvim")

	use({"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"})

	use("numToStr/Comment.nvim")

    use("SmiteshP/nvim-navic")

	-- completion
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/nvim-cmp")

	-- snippets
	use("saadparwaiz1/cmp_luasnip")
	use("L3MON4D3/LuaSnip")

	-- terraform
	use("hashivim/vim-terraform")

	-- terminal integration
	use("akinsho/toggleterm.nvim")

	-- status line
	use("nvim-lualine/lualine.nvim")
	use("kyazdani42/nvim-web-devicons")

	-- color helper
	use("norcalli/nvim-colorizer.lua")

	-- LaTeX editing
	use({"lervag/vimtex", opt=true})

	-- fuzzy finding
	use({'nvim-telescope/telescope.nvim', requires = {'nvim-lua/plenary.nvim'}})

	use({'kyazdani42/nvim-tree.lua', requires = {'kyazdani42/nvim-web-devicons'}})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require('packer').sync()
	end
end)


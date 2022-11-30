local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end

return require('packer').startup(function(use)
	use("wbthomason/packer.nvim")

	use("nvim-lua/plenary.nvim")
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("neovim/nvim-lspconfig")

	use({"briones-gabriel/darcula-solid.nvim", requires = "rktjmp/lush.nvim"})

	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

	use("SmiteshP/nvim-navic")

	-- completion
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/nvim-cmp")

	use("lewis6991/gitsigns.nvim")

	-- snippets
	use({
		"L3MON4D3/LuaSnip",
		requires = { "saadparwaiz1/cmp_luasnip" },
	})

	-- eww
	use("elkowar/yuck.vim")
	use("gpanders/nvim-parinfer")

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
	use({ "lervag/vimtex", opt = true })

	-- Commenting
	use("numToStr/Comment.nvim")

	-- fuzzy finding
	use({ 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } })

	use({ 'kyazdani42/nvim-tree.lua', requires = { 'kyazdani42/nvim-web-devicons' } })

	use({"sindrets/diffview.nvim", requires = { "nvim-lua/plenary.nvim" }})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require('packer').sync()
	end
end)

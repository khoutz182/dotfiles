

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
	use("wbthomason/packer.nvim")

	use("nvim-lua/plenary.nvim")
	use("neovim/nvim-lspconfig")
	use("williamboman/nvim-lsp-installer")

	use("RRethy/nvim-base16")

	use("nvim-treesitter/nvim-treesitter")

	-- completion
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/nvim-cmp")

	-- snippets
	use("saadparwaiz1/cmp_luasnip")
	use("L3MON4D3/LuaSnip")

	-- status line
	use("nvim-lualine/lualine.nvim")
	use("kyazdani42/nvim-web-devicons")

	-- color helper
	use({"rrethy/vim-hexokinase", run="make hexokinase"})

	-- LaTeX editing
	use({"lervag/vimtex", opt=true})

	-- fuzzy finding
	use({"nvim-telescope/telescope.nvim", run=":TSUpdate"})
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require('packer').sync()
	end
end)

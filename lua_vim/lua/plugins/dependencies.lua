
require "paq" {
	"sav1/paq-nvim";
	"nvim-lua/plenary.nvim";
	"neovim/nvim-lspconfig";
	"williamboman/nvim-lsp-installer";

	"RRethy/nvim-base16";

	"nvim-treesitter/nvim-treesitter";

	-- completion
	"hrsh7th/cmp-nvim-lsp";
	"hrsh7th/cmp-buffer";
	"hrsh7th/cmp-path";
	"hrsh7th/nvim-cmp";

	-- snippets
	"saadparwaiz1/cmp_luasnip";
	"L3MON4D3/LuaSnip";

    -- status line
	"nvim-lualine/lualine.nvim";
	"kyazdani42/nvim-web-devicons";

	-- color helper
	{"rrethy/vim-hexokinase", run="make hexokinase"};

	-- LaTeX editing
	{"lervag/vimtex", opt=true};

	-- fuzzy finding
	{"nvim-telescope/telescope.nvim", run=":TSUpdate"};
}


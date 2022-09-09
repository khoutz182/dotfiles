
local plugins = {
	"lspconfig",
	"mason",
	"lualine",
	"colorizer",
	"telescope",
 	"cmp",
	"treesitter",
	"nvimtree",
	"toggleterm",
	"comment",
	"colorscheme",
	"diffview",
}

for _, plugin in ipairs(plugins) do
	local ok, err = pcall(require, "plugins." .. plugin)
	if not ok then
		error("Error loading " .. plugin .. "\n\n" .. err)
	end
end

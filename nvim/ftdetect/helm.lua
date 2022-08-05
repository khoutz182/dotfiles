-- autocmd BufRead,BufNewFile */templates/*.yaml,*/templates/*.tpl,*.gotmpl,helmfile.yaml set ft=helm
--
-- " Use {{/* */}} as comments
-- autocmd FileType helm setlocal commentstring={{/*\ %s\ */}}

local group = vim.api.nvim_create_augroup("helm")
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
	pattern = {
		"*/templates/*.yaml",
		"*/templates/*.tpl",
		"*.gotmpl",
		"helmfile.yaml"
	},
	command = [[set ft=helm]],
	group = group
})

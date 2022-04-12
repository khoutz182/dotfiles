local map = vim.api.nvim_set_keymap

local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- "," is the <leader>
map('n', ',', '', {})
vim.g.mapleader = ','


-- fuzzy finder
map('', '<leader>f', ":lua require('telescope.builtin').find_files({layout_strategy='horizontal'})<cr>")
map('', '<leader>gf', ":lua require('telescope.builtin').git_files()<cr>")
map('', '<leader>gs', ":lua require('telescope.builtin').grep_string()<cr>")
map('', '<leader>ts', ":lua require('telescope.builtin').treesitter()<cr>")

map('', '<leader>sv', ':luafile $HOME/.config/nvim/init.lua<cr>')

map('', '<leader>,', '<c-^><cr>')

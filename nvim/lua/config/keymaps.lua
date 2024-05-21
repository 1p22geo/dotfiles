-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "S", "yyP", { noremap = true, silent = true })

-- J to move the current line down
vim.keymap.set("n", "<C-j>", ":m .+1<CR>==", { noremap = true, silent = true })
-- K to move the current line up
vim.keymap.set("n", "<C-k>", ":m .-2<CR>==", { noremap = true, silent = true })

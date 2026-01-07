-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

--[[
vim.keymap.set({ "n", "v" }, "<C-g>", ":Gen<CR>")

require("gen").prompts["Elaborate_Text"] = {
  prompt = "Elaborate the following text:\n$text",
  replace = true,
}
require("gen").prompts["Fix_Code"] = {
  prompt = "Fix the following code. Only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
  replace = true,
  extract = "```$filetype\n(.-)```",
}
]]

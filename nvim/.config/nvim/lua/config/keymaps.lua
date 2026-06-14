-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

-- For conciseness
local opts = { noremap = true, silent = true }

-- move instantly to the normal mode
vim.keymap.set("i", "jk", "<Esc>", opts)
vim.keymap.set("i", "kj", "<Esc>", opts)

-- delete character but not copy to register
vim.keymap.set("n", "x", '"_x')

-- Keep last yanked when pasting
vim.keymap.set("x", "p", '"_dP', opts)

-- change text but not copy to the register
vim.keymap.set({ "n", "x" }, "c", '"_c', opts)

-- Center screen when jumping
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Paste with Command-V
vim.keymap.set("n", "<D-v>", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set("i", "<D-v>", '<C-r>+', { desc = "Paste from system clipboard" })
vim.keymap.set("c", "<D-v>", '<C-r>+', { desc = "Paste from system clipboard" })

-- Grep in current file's directory
vim.keymap.set("n", "<leader>sG", function()
  Snacks.picker.grep({ dirs = { vim.fn.expand("%:p:h") } })
end, { desc = "Grep in current dir" })

-- Find files in current file's directory
vim.keymap.set("n", "<leader>fF", function()
  Snacks.picker.files({ dirs = { vim.fn.expand("%:p:h") } })
end, { desc = "Find files in current dir" })

-- Resize panes
vim.keymap.set('n', '<A-h>', ':vertical resize -2<CR>', { silent = true, desc = "Decrease pane width" })
vim.keymap.set('n', '<A-l>', ':vertical resize +2<CR>', { silent = true, desc = "Increase pane width" })
vim.keymap.set('n', '<A-j>', ':resize -2<CR>',          { silent = true, desc = "Decrease pane height" })
vim.keymap.set('n', '<A-k>', ':resize +2<CR>',          { silent = true, desc = "Increase pane height" })


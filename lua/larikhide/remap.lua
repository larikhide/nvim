vim.g.mapleader = " "
vim.keymap.set("n", "<leader>ef", vim.cmd.Ex)

-- cursor at the middle when searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- pressing Q does nothing 
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "q", "<nop>")

-- cursor at the middle when scropp by the <C-d/u>
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "<S-Tab>", "<C-w>w", { desc = "Cycle to next split" })
vim.keymap.set("n", "<leader>rn", ":set rnu!<CR>", { desc = "Toggle relative line numbers" })
vim.keymap.set("n", "<leader>fm", function() vim.lsp.buf.format { async = true } end, { desc = "Format current buffer" })

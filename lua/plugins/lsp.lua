
vim.keymap.set("n", "<leader>fm", function()
    vim.lsp.buf.format { async = true }
end, { desc = "Format current buffer" })


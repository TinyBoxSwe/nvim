require("nvim-tree").setup({
    sort = {
        sorter = "case_sensitive",
    },
    view = {
        width = 25,
    },
    renderer = {
        group_empty = true,
    },
    filters = {
    },
})

vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })

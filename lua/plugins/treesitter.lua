require("nvim-treesitter.configs").setup {
    ensure_installed = { "java", "lua" },
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
    },
}

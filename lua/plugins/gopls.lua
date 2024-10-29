-- lua/plugins/gopls.lua

local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Key mappings for LSP functionality
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)       -- Go to definition
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)             -- Show hover information
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)   -- Go to implementation
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts) -- Show signature help
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)    -- Rename symbol
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts) -- Code action
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)       -- Show references

    -- Format on save (if the server supports it)
    if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function() vim.lsp.buf.format({ async = false }) end,
        })
    end
end

-- Setup gopls with the on_attach function
require('lspconfig').gopls.setup({
    on_attach = on_attach,
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_dir = require('lspconfig.util').root_pattern("go.work", "go.mod", ".git"),
    settings = {
        gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
                unusedparams = true,
            },
        },
    },
})

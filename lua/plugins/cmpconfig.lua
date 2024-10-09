local cmp = require'cmp'

cmp.setup({
    completion = {
        completeopt = 'menu,menuone,noselect',
    },
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)  -- For snippet support
        end,
    },
    mapping = {
        ['<C-k>'] = cmp.mapping.select_prev_item(), -- Select previous item
        ['<C-j>'] = cmp.mapping.select_next_item(), -- Select next item
        ['<C-Space>'] = cmp.mapping.complete(),      -- Trigger completion
        ['<C-e>'] = cmp.mapping.close(),             -- Close completion
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Confirm selection
    },
    sources = {
        { name = 'nvim_lsp', dup = 0 },     -- Use LSP as a source
        { name = 'buffer', dup = 0 },       -- Use buffer words
        { name = 'path', dup = 0 },         -- Use filesystem paths
    },
})

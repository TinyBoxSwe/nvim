-- plugins/jdtls.lua

local jdtls = require('jdtls')

local config = {
    cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/jdtls") }, 
    root_dir = require('jdtls.setup').find_root({'gradlew', '.git', 'mvnw'}),
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
}

jdtls.start_or_attach(config)


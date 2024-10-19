-- plugins.lua

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    -- Theme
    { 
      'marko-cerovac/material.nvim', 
      name = "material", 
      priority = 1000,
      config = function()
        require("plugins.catppuccin")
        vim.g.material_style = "deep ocean"
      end
    },
    -- Telescope
    { 
      "nvim-telescope/telescope.nvim", 
      tag = "0.1.8", 
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        require("plugins.telescope")
      end
    },
    -- Treesitter
    { 
      "nvim-treesitter/nvim-treesitter", 
      build = ":TSUpdate",
      config = function()
        require("plugins.treesitter")
      end
    },
    -- Nvim-tree
    { 
      "nvim-tree/nvim-tree.lua", 
      dependencies = { "nvim-tree/nvim-web-devicons" },  -- Optional: for file icons
      config = function()
          require("plugins.nvimtree")
      end
    }, 
    -- Mason for managing LSP servers
    {
      "williamboman/mason.nvim",
      opts = {
        -- your options here, e.g.,
        ensure_installed = { "jdtls", "lua-language-server" },
        ui = {
            border = "rounded",
        },
      }
    },
    -- java
    {
      "nvim-java/nvim-java",
      config = function()
        require('java').setup()
        require('lspconfig').jdtls.setup({
            root_dir = require('lspconfig.util').root_pattern(".git", "mvnw", "gradlew", "pom.xml", "build.gradle"),
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
        })
      end      
    },
    { "neovim/nvim-lspconfig" }, -- LSP configurations
    { "hrsh7th/nvim-cmp" },      -- Autocompletion
    { "hrsh7th/cmp-nvim-lsp" },  -- LSP source for nvim-cmp
    { "L3MON4D3/LuaSnip" },      -- Snippet engine
}

local opts = {} 
require("lazy").setup(plugins, opts)
require("plugins.cmp")

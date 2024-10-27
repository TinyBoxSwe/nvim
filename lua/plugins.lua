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
      "catppuccin/nvim",
      name = "catppuccin",
      priority = 1000,
      config = function()
        require("plugins.catppuccin")
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
    {
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            require('plugins.dashboard')
        end,
        dependencies = { {'nvim-tree/nvim-web-devicons'}}
    },
    -- Lualine
    {
      'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = function()
          require("plugins.lualine")
      end
    },
    {
        'akinsho/bufferline.nvim',
        requires = 'nvim-tree/nvim-web-devicons', -- optional, for file icons
        config = function()
            require('bufferline').setup {}
        end
    },
    -- Gitsigns
    { 
      'lewis6991/gitsigns.nvim',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
            require("plugins.gitsigns")
        end
    },
    -- Mason for managing LSP servers
    {
      "williamboman/mason.nvim",
      opts = {
        ensure_installed = { "jdtls", "lua-language-server", "gopls" }, -- Added gopls here
        ui = {
            border = "rounded",
        },
      }
    },
    -- Autocompletion and Snippets
    { "hrsh7th/nvim-cmp", },     -- Autocompletion
    { "neovim/nvim-lspconfig" }, -- LSP configurations
    { "hrsh7th/cmp-nvim-lsp" },  -- LSP source for nvim-cmp
    { "L3MON4D3/LuaSnip" },      -- Snippet engine

    -- Java LSP setup
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

    -- Go LSP setup
    {
      "neovim/nvim-lspconfig",
      config = function()
        require('plugins.gopls')
      end,
    },
}

local opts = {} 
require("lazy").setup(plugins, opts)
require('plugins.cmp')

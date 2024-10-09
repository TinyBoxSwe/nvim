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
    -- Mason for managing LSP servers
    {
      "williamboman/mason.nvim",
      config = function()
          require("plugins.mason")
      end
    },
    -- LSP Configuration
    { "neovim/nvim-lspconfig" },
    -- Java Development Tools
    { 
      "mfussenegger/nvim-jdtls",
      config = function()
          require("plugins.jdtls")  -- Ensure you have a separate jdtls config
      end
    },
    -- Completion Plugins
    { 
        'hrsh7th/nvim-cmp',
        config = function() 
            require("plugins.cmpconfig") 
        end
    },         -- Completion plugin
    { 'hrsh7th/cmp-nvim-lsp' },     -- LSP source for nvim-cmp
    { 'hrsh7th/cmp-buffer' },       -- Buffer completions
    { 'hrsh7th/cmp-nvim-lua' },     -- Lua completions
    { 'L3MON4D3/LuaSnip' },         -- Snippet engine
    { 'saadparwaiz1/cmp_luasnip' }, -- Snippet source for nvim-cmp
}

local opts = {} 
require("lazy").setup(plugins, opts)

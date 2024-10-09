
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

-- List of plugins
local plugins = {
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    { 
      "nvim-telescope/telescope.nvim", 
      tag = "0.1.8", 
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        require("plugins.telescope")  -- Load Telescope-specific configuration
      end
    },
    { 
      "nvim-treesitter/nvim-treesitter", 
      build = ":TSUpdate",
      config = function()
        require("plugins.treesitter")  -- Load Treesitter-specific configuration
      end
    },
    { 
      "catppuccin/nvim", 
      name = "catppuccin", 
      priority = 1000,
      config = function()
        require("plugins.catppuccin")  -- Load Catppuccin-specific configuration
      end
    },
    -- Add other plugins here
}

local opts = {}  -- Any additional Lazy.nvim options

-- Initialize the plugin setup
require("lazy").setup(plugins, opts)

-- ~/.config/nvim/init.lua

-- Set leader key early
vim.g.mapleader = " "

require("keymaps")
require("settings")
require("plugins")
vim.cmd('filetype plugin on')

-- ~/.config/nvim/init.lua

-- Set leader key early
vim.g.mapleader = " "
vim.cmd('set rnu!')
vim.cmd('set nu!')

require("keymaps")
require("settings")
require("plugins")
vim.cmd('filetype plugin on')

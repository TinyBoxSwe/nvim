
-- Use system clipboard for yanking and pasting in normal, visual, and operator-pending modes.
vim.keymap.set({"n", "v"}, "y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set({"n", "v"}, "Y", '"+Y', { desc = "Yank line to system clipboard" })
vim.keymap.set({"n", "v"}, "p", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set({"n", "v"}, "P", '"+P', { desc = "Paste before from system clipboard" })

-- Map <C-d> to duplicate the current line down in both normal and insert modes, using system clipboard.
vim.keymap.set("n", "<C-d>", '"+yy"+p', { desc = "Duplicate current line down" })
vim.keymap.set("i", "<C-d>", "<Esc>'+yy'+pi", { desc = "Duplicate current line down in insert mode" })

-- Map <S-Tab> to cycle to the next split in normal and insert modes.
vim.keymap.set({"n", "i"}, "<S-Tab>", "<C-w>w", { desc = "Cycle to next split" })

-- Toggle relative line numbers in normal mode.
vim.keymap.set("n", "<leader>rn", ":set rnu!<CR>", { desc = "Toggle relative line numbers" })

-- Format the current buffer using LSP in normal mode.
vim.keymap.set("n", "<leader>fm", function() vim.lsp.buf.format { async = true } end, { desc = "Format current buffer" })

-- Select the whole line and copy to the system clipboard in normal, insert, and visual modes.
vim.keymap.set({"n", "i", "v"}, "<C-c>c", function()
  vim.cmd('normal! 0v$"+y')
end, { desc = "Select whole line and copy to clipboard" })

-- Select from the cursor to the end of the line and copy to the system clipboard in normal, insert, and visual modes.
vim.keymap.set({"n", "i", "v"}, "<C-c>e", function()
  vim.cmd('normal! v$"+y')
end, { desc = "Select until end and copy to clipboard" })

local function ejump()
    if vim.fn.mode() == 'i' then
        vim.cmd("normal! $")
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Right>", true, false, true), 'n', true)
    else 
        vim.cmd("normal! $")
    end
end

local function sjump()
    vim.cmd("normal! 0")
end

-- Jump to the end of the line in normal and visual modes.
vim.keymap.set({"n", "i", "v"}, "<C-e>", ejump, { desc = "Jump to end of line" })

-- Jump to the start of the line in normal and visual modes.
vim.keymap.set({"n", "i", "v"}, "<C-s>", sjump, { desc = "Jump to start of line" })

-- Delete whole to word start in all modes
vim.keymap.set("i", "<C-h>", "<C-w>", { desc = "Delete til word start" } )
vim.keymap.set("n", "<C-h>", "db", { desc = "Delete til word start" } )

local function undo()
    vim.cmd("normal! u")
end

vim.keymap.set({"n", "i"}, "C-z", undo, { desc = "Undo" } )

local function redo()
    vim.cmd("normal! <C-R>")
end

vim.keymap.set({"i", "n"}, "<C-r>", redo, { desc = "Redo" } )



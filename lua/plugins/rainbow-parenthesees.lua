local M = {}

local ns = vim.api.nvim_create_namespace("RainbowNamespace")

local function set_highlights()
    vim.api.nvim_set_hl(0, 'Red', { fg = "#FF5252", bold = true })       -- Material Red
    vim.api.nvim_set_hl(0, 'Pink', { fg = "#FF4081", bold = true })     -- Material Pink
    vim.api.nvim_set_hl(0, 'Purple', { fg = "#7E57C2", bold = true })   -- Material Purple
    vim.api.nvim_set_hl(0, 'DeepPurple', { fg = "#6200EA", bold = true }) -- Material Deep Purple
    vim.api.nvim_set_hl(0, 'Indigo', { fg = "#3F51B5", bold = true })   -- Material Indigo
    vim.api.nvim_set_hl(0, 'Blue', { fg = "#2196F3", bold = true })      -- Material Blue
    vim.api.nvim_set_hl(0, 'LightBlue', { fg = "#03A9F4", bold = true }) -- Material Light Blue
    vim.api.nvim_set_hl(0, 'Cyan', { fg = "#00BCD4", bold = true })      -- Material Cyan
    vim.api.nvim_set_hl(0, 'Teal', { fg = "#009688", bold = true })      -- Material Teal
    vim.api.nvim_set_hl(0, 'Green', { fg = "#4CAF50", bold = true })     -- Material Green
    vim.api.nvim_set_hl(0, 'LightGreen', { fg = "#8BC34A", bold = true }) -- Material Light Green
    vim.api.nvim_set_hl(0, 'Lime', { fg = "#CDDC39", bold = true })       -- Material Lime
    vim.api.nvim_set_hl(0, 'Yellow', { fg = "#FFEB3B", bold = true })     -- Material Yellow
    vim.api.nvim_set_hl(0, 'Amber', { fg = "#FFC107", bold = true })      -- Material Amber
    vim.api.nvim_set_hl(0, 'Orange', { fg = "#FF9800", bold = true })     -- Material Orange
    vim.api.nvim_set_hl(0, 'DeepOrange', { fg = "#FF5722", bold = true }) -- Material Deep Orange

    vim.api.nvim_set_hl(0, 'Fallback', { fg = "#FFFFFF", bold = true, bg = "#FF0000" }) -- White text on red background
end

local colours = {
    "Red",
    "Pink",
    "Purple",
    "DeepPurple",
    "Indigo",
    "Blue",
    "LightBlue",
    "Cyan",
    "Teal",
    "Green",
    "LightGreen",
    "Lime",
    "Yellow",
    "Amber",
    "Orange",
    "DeepOrange"
}

local function rainbow()
    local buffer = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(buffer, 0, -1, false)
    local counter = 0
    local in_string = false

    vim.api.nvim_buf_clear_namespace(buffer, ns, 0, -1)

    for i, line in ipairs(lines) do
        for j = 1, #line do
            local c = line:sub(j, j)

            if c == "'" then
                in_string = not in_string
                while j <= #line and c ~= "'" do
                    j = j + 1
                    c = line:sub(j, j)
                end
            end

            if in_string then
                goto continue
            end

            if c == '(' or c == '[' or c == '{' then
                counter = counter + 1
                local colour_index = (counter - 1) % #colours + 1
                vim.api.nvim_buf_set_extmark(buffer, ns, i - 1, j - 1, {
                    hl_group = colours[colour_index],
                    end_line = i - 1,
                    end_col = j,
                })
            elseif c == ')' or c == ']' or c == '}'  then
                local colour_index = counter % #colours
                vim.api.nvim_buf_set_extmark(buffer, ns, i - 1, j - 1, {
                    hl_group = colours[colour_index],
                    end_line = i - 1,
                    end_col = j,
                })
                counter = math.max(counter - 1, 0)
            end

            ::continue::
        end
    end
end

local function apply_rainbow()
    set_highlights()
    rainbow()
end

-- Register autocommands for buffer events
vim.api.nvim_create_autocmd({"BufEnter", "BufWritePost", "BufReadPost", "TextChanged", "TextChangedI"}, {
    callback = apply_rainbow,
    group = vim.api.nvim_create_augroup("RainbowParentheses", { clear = true }),
})

return M

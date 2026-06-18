-- Basic Settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.mouse = 'a'

-- creating a completely transparent look for Ghostty.
local highlights = {
    "Normal",       -- Main window bg
    "NormalNC",     -- Non-current window bg
    "NormalFloat",   -- Floating windows (The "box" thing)
    "FloatBorder",   -- Floating window borders
    "SignColumn",    -- Side gutter for line numbers
    "LineNr", 
    "CursorLineNr", 
    "EndOfBuffer"    -- The '~' at the end of files
}

for _, group in ipairs(highlights) do
    vim.api.nvim_set_hl(0, group, { bg = "none", ctermbg = "none" })
end

-- Force transparency for floating menus (like autocompletion)
vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#585b70" }) -- A slight highlight for selection

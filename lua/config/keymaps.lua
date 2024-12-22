local discipline = require("andrebrito.discipline")

discipline.cowboy()

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

local function bind(key, cmd, mode, opts_param)
	if opts_param == nil then
		opts_param = { noremap = true, silent = true }
	end
	if mode == nil then
		mode = { "n", "v" }
	end
	vim.keymap.set(mode, key, cmd, opts_param)
end

-- Do things without affecting the registers
keymap.set("n", "x", '"_x')
keymap.set("n", "<Leader>p", '"0p')
keymap.set("n", "<Leader>P", '"0P')
keymap.set("v", "<Leader>p", '"0p')
keymap.set("n", "<Leader>c", '"_c')
keymap.set("n", "<Leader>C", '"_C')
keymap.set("v", "<Leader>c", '"_c')
keymap.set("v", "<Leader>C", '"_C')
keymap.set("n", "<Leader>d", '"_d')
keymap.set("n", "<Leader>D", '"_D')
keymap.set("v", "<Leader>d", '"_d')
keymap.set("v", "<Leader>D", '"_D')

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- search and replace
bind("<leader>S", ":%s//g<Left><Left>", "n", { noremap = true })
bind("<leader>S", ":'<,'>s//g<Left><Left>", "v", { noremap = true })

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- terminal
bind("<leader>t", function()
	vim.cmd("new")
	vim.cmd("wincmd J")
	vim.cmd("horizontal resize " .. math.floor(vim.o.lines * 0.30))
	vim.cmd("terminal ")
end)
bind("<leader>T", function()
	vim.cmd("vnew")
	vim.cmd("terminal")
	vim.cmd("vertical resize " .. math.floor(vim.o.columns * 0.33))
end)

-- Github Copilot
vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true, script = true })
vim.api.nvim_set_keymap("i", "<C-]>", "copilot#Next()", { silent = true, expr = true })
vim.api.nvim_set_keymap("i", "<C-[>", "copilot#Previous()", { silent = true, expr = true })

-- Disable continuations
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- New tab
keymap.set("n", "te", ":tabedit")
-- keymap.set("n", "<tab>", ":tabnext<Return>", opts)
-- keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)
-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)
-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- search and replace

-- Diagnostics
keymap.set("n", "<C-j>", function()
	vim.diagnostic.goto_next()
end, opts)

keymap.set("n", "<leader>r", function()
	require("andrebrito.hsl").replaceHexWithHSL()
end)

keymap.set("n", "<leader>i", function()
	require("andrebrito.lsp").toggleInlayHints()
end)

local builtin = require('telescope.builtin')
local cmp = require('cmp')

vim.keymap.set("i", "<C-i>", function()
    if not cmp.visible() then
        cmp.complete()
    end
end)

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

vim.keymap.set("n", "<leader>pv",
    ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
    { noremap = true })

vim.keymap.set('n', '<leader>ff',
    function() builtin.find_files({ find_command = { 'rg', '--glob', '!.git/', '--files', '--hidden' } }) end, {})
vim.keymap.set('n', '<leader>pf', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > "), additional_args = { '--glob', '!.git/', '--hidden' } });
end)

-- move  lines up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- move line below to the end of current line
vim.keymap.set("n", "J", "mzJ`z")

-- go down/up half screen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- go to next/previous searhed occurrence
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- yank into system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- delete but don't put into nvim paste register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
-- paste over something but don't replace nvim's paste register with replaced lines
vim.keymap.set("x", "<leader>p", [["_dP]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- format file using lsp
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- go to next/previous error (I guess)
-- https://www.reddit.com/r/neovim/comments/xq7dnr/what_does_the_c_in_copencnext_stand_for/
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- search and replace
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

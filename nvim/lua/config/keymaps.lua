-- functional wrapper for keymaps
function map(m, k, v)
    vim.keymap.set(m, k, v, { silent = true })
end
-- function map(mode, lhs, rhs, opts)
--     local options = { noremap = true }
--     if opts then
--         options = vim.tbl_extend("force", options, opts)
--     end
--     vim.api.nvim_set_keymap(mode, lhs, rhs, options)
-- end

-- remap lead key
map('n', '<Space>', '<Nop>')

-- remap k and j keys to move between physical lines
-- normal mode
map('n', 'k', 'gk')
map('n', 'j', 'gj')
-- visual mode
map('v', 'k', 'gk')
map('v', 'j', 'gj')

-- automatically close a bracket when opening one
map('i', '(', '()<Esc>i')
map('i', '{', '{}<Esc>i')
map('i', '[', '[]<Esc>i')
map('i', '<', '<><Esc>i')
map('i', '"', '""<Esc>i')
map('i', "'", "''<Esc>i")

-- replace selected text
map("v", "<leader>r", "\"hy:%s/<C-r>h//g<left><left>")
-- sort highlighted list
map("v", "<C-s>", ":sort<CR>")

-- move selected line up or down
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '>-2<CR>gv=gv")

-- open new tab
map('n', '<leader>t', ':tabnew<CR>')
-- switch between tabs
map('n', 'K', ':tabn<CR>')
map('n', 'J', ':tabp<CR>')
-- open a file in current tab using fuzzy finder
map('n', '<leader>f', ':Files<CR>')

-- scroll down and center the cursor
map('n', '<C-d>', '<C-d>zz')
-- same for up
map('n', '<C-u>', '<C-u>zz')
-- quit insert mode
map('i', 'jk', '<Esc>')
map('i', 'kj', '<Esc>')
-- clean highlight of previous search
map('n', '<leader><leader>', ':noh<CR>')
-- toggle csv view
map('n', '<leader>c', ':CsvViewToggle<CR>')

-- make suggestions appear
map('i', '<C-Space>', '<C-x><C-n>')
map('i', '<C-j>', '<C-n>')
map('i', '<C-k>', '<C-p>')


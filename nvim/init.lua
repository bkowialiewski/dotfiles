--- generation options ----

-- display line numbers
vim.opt.number = true
-- allow mouse use in editor
vim.opt.mouse = 'a'
-- ignore case when searching for a string
vim.opt.ignorecase = true
-- case sensitive only if the searched term contains different cases
vim.opt.smartcase = true
-- highlight result of previous search
vim.opt.hlsearch = true
-- incremental search?
vim.opt.incsearch = true
-- makes the text of long lines always visible
vim.opt.wrap = false
-- preserve the indentation of a virtual line
vim.opt.breakindent = true
-- smart indentation
vim.opt.smartindent = true
-- amount of space taken by a tab character
vim.opt.tabstop = 4
-- amount for space taken for indentation
vim.opt.shiftwidth = 4
-- scrolloff - cursor doesn't go to the top or bottom of screen
vim.opt.scrolloff = 10
-- same with the side scroll
vim.opt.sidescrolloff = 8
-- highlight the current line
vim.opt.cursorline = true
-- does nvim transform a tab into spaces?
vim.opt.expandtab = true
-- wrap lines around
vim.opt.textwidth = 0
vim.opt.wrapmargin = 0
vim.opt.wrap = true
vim.opt.linebreak = true
-- term colors
vim.opt.termguicolors = true
-- disable syntax highlighting
vim.cmd("syntax on")

-- define mapleader
vim.g.mapleader = ' '
vim.g.maplocalleader = '§'
-- change size of the window in file explorer
vim.g.netrw_winsize = 30
-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- yank and paste between nvim sessions
vim.opt.clipboard = "unnamedplus"

-- vim.g.transparent_groups = vim.list_extend(vim.g.transparent_groups or {}, { "ExtraGroup" })

vim.opt.spelllang = 'en_us'

---- KEYMAPS ----

-- functional wrapper for keymaps
function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

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
-- paste last yanked object
map('n', '<C-p>', 'cw<C-r>0<Esc>')
--copy to clipboard
map('v', '<leader>y', '"+y')
-- open oil
map('n', '<leader>o', ':tabnew<CR>:Oil<CR>')

-- vim.api.nvim_create_autocmd("BufWritePost", {
--     pattern = "*.typ",
--     command = "silent! !typst compile %"
-- })
---- PLUGINS ----
require("config.lazy")
require("colorizer").setup()

---- COLOR SCHEME ----
vim.cmd.colorscheme('catppuccin-macchiato')

require("oil").setup()

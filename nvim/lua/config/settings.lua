local g = vim.g
local o = vim.opt
local c = vim.cmd

-- display line numbers
o.number = true
-- show title?
o.title = true
-- allow mouse use in editor
o.mouse = 'a'
-- ignore case when searching for a string
o.ignorecase = true
-- case sensitive only if the searched term contains different cases
o.smartcase = true
-- highlight result of previous search
o.hlsearch = true
-- incremental search?
o.incsearch = true
-- preserve the indentation of a virtual line
o.breakindent = true
-- smart indentation
o.smartindent = true
-- amount of space taken by a tab character
o.tabstop = 4
-- amount for space taken for indentation
o.shiftwidth = 4
-- scrolloff - cursor doesn't go to the top or bottom of screen
o.scrolloff = 10
-- same with the side scroll
o.sidescrolloff = 8
-- highlight the current line
o.cursorline = true
-- does nvim transform a tab into spaces?
o.expandtab = true
-- wrap lines around
o.textwidth = 0
o.wrapmargin = 0
o.wrap = true
o.linebreak = true
-- term colors
o.termguicolors = true

-- define mapleader
g.mapleader = ' '
-- disable netrw
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
-- yank and paste between nvim sessions
o.clipboard = "unnamedplus"

o.spelllang = 'en_us'

-- autocomplete menu
o.completeopt = { "menuone", "noselect" }

c("filetype plugin on")
c("set wildmenu")

-- enable syntax highlighting
c("syntax on")

c("set path+=**")

-- Create your custom theme here
-- require("xeno").new_theme("minimal", {
--
--     base = "#2e3440",
--     accent = "#bf616a",
--     contrast = -0.6,
--     variation = 0.0,
--
--     highlights = {
--         editor = {
--           Normal = { bg = "#2e3440" }, -- fixed
--         },
--     }
--
--
-- })
-- vim.cmd('colorscheme minimal')

c.colorscheme("nordfox")
-- c.colorscheme("oxocarbon")
-- c.colorscheme("dangion")

require("colorizer").setup()

-- vim.cmd [[
--   highlight Normal guibg=none
--   highlight NonText guibg=none
--   highlight Normal ctermbg=none
--   highlight NonText ctermbg=none
-- ]]

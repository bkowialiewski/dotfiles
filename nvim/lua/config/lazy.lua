-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({

    -- themes
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

    -- to indent automatically
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

    -- syntax highlighting
    { "nvim-treesitter/nvim-treesitter",

        build = ":TSUpdate",
        config = function () 
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html" , "julia"},
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },  
                additional_vim_regex_highlighting = false,
            })
        end
    },

    -- neovim tree
    -- {'nvim-tree/nvim-tree.lua'},
    ---@type LazySpec
    -- {
    --     "mikavilpas/yazi.nvim",
    --     event = "VeryLazy",
    --     keys = {
    --         -- 👇 in this section, choose your own keymappings!
    --         {
    --             "<leader>o",
    --             "<cmd>Yazi<cr>",
    --             desc = "Open yazi at the current file",
    --         },
    --         {
    --             -- Open in the current working directory
    --             "<leader>cw",
    --             "<cmd>Yazi cwd<cr>",
    --             desc = "Open the file manager in nvim's working directory" ,
    --         },
    --         {
    --             -- NOTE: this requires a version of yazi that includes
    --             -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
    --             '<c-up>',
    --             "<cmd>Yazi toggle<cr>",
    --             desc = "Resume the last yazi session",
    --         },
    --     },
    --     ---@type YaziConfig
    --     opts = {
    --         -- if you want to open yazi instead of netrw, see below for more info
    --         open_for_directories = false,
    --         keymaps = {
    --             show_help = '<f1>',
    --         },
    --     },
    -- },

    {
        'stevearc/oil.nvim',
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {},
        -- Optional dependencies
        dependencies = { { "echasnovski/mini.icons", opts = {} } },
        -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    },

    -- allows easy commenting
    { 'numToStr/Comment.nvim', opts = {}, lazy = false },
    -- syntax highlighting, autosuggest, etc...
    { 'neoclide/coc.nvim', branch = 'release'},
    -- fuzzy finder
    { 'junegunn/fzf' },
    { 'junegunn/fzf.vim' },
    -- used for icons
    -- { 'echasnovski/mini.nvim', version = false },
    -- { 'nvim-tree/nvim-web-devicons' },
    -- {'Olical/conjure'},
    -- used to enclose text in brackets, quotes, etc.
    {"kylechui/nvim-surround", versions = "*", event = "VeryLazy", config = function()
        require("nvim-surround").setup({

        })
    end
    },

    {"folke/zen-mode.nvim"},
    {"folke/twilight.nvim"},

    {'kaarmu/typst.vim'},

    { 'norcalli/nvim-colorizer.lua' },

    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {},
        -- stylua: ignore
        keys = {
            { "<leader>s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
        },
    }
})


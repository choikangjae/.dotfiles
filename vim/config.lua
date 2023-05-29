-- keymap
local options = { noremap = true, silent = true }
local map = vim.keymap
map.set("i", "<C-e>", "<esc>A;<cr>", options)

map.set("i", "jk", "<esc>", options)
map.set("i", "kj", "<esc>", options)

map.set("", "<Up>", "<c-p>", options)
map.set("", "<Down>", "<c-n>", options)
map.set("", "e", "$", options)
map.set("", "s", "^", options)

map.set("n", "k", "gk", options)
map.set("n", "j", "gj", options)
map.set("n", "gr", "gT", options)
map.set("n", "H", "<C-o>", options)
map.set("n", "L", "<C-i>", options)
map.set("n", "J", "7gjzz", options)
map.set("n", "K", "7gkzz", options)
map.set("n", "n", "nzz", options)
map.set("n", "N", "Nzz", options)
map.set("n", "S", "I", options)
map.set("n", "E", "A", options)
map.set("n", "U", "<C-r>", options)
map.set("n", "<tab>", "<C-w>w", options)
map.set("n", "Z", ":%s//<left>", options)
map.set("n", "gi", "mygg=G'y", options)

map.set("v", "<cr>", "<esc>", options)
map.set("v", "J", "7gjzzzv", options)
map.set("v", "K", "7gkzzzv", options)

map.set("", "gr", ":BufferLineCyclePrev<cr>", options)
map.set("", "gt", ":BufferLineCycleNext<cr>", options)

vim.api.nvim_create_autocmd("BufEnter",
    { callback = function() vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" } end, })

-- dap
lvim.builtin.dap.active = true

-- nvimtree
vim.api.nvim_set_keymap('n', '<c-d>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
lvim.builtin.nvimtree.setup.actions.open_file.quit_on_open = true
lvim.builtin.nvimtree.setup.view.width = 5

-- lsp
lvim.lsp.buffer_mappings.normal_mode['gR'] = lvim.lsp.buffer_mappings.normal_mode['gr']
lvim.lsp.buffer_mappings.normal_mode['gr'] = nil
lvim.builtin.terminal.open_mapping = "<c-t>"
lvim.lsp.buffer_mappings.normal_mode['gh'] = lvim.lsp.buffer_mappings.normal_mode['K']
lvim.lsp.buffer_mappings.normal_mode['K'] = nil

-- basic settings
vim.opt.backup = false                          -- creates a backup file
vim.opt.clipboard = "unnamedplus"               -- allows neovim to access the system clipboard
-- vim.opt.cmdheight = 2 -- more space in the neovim command line for displaying messages
vim.opt.colorcolumn = "99999"                   -- fixes indentline for now
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.conceallevel = 0                        -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8"                  -- the encoding written to a file
vim.opt.foldmethod = "manual"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
-- vim.opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
vim.opt.hidden = true                           -- required to keep multiple buffers and open multiple buffers
vim.opt.hlsearch = true                         -- highlight all matches on previous search pattern
vim.opt.ignorecase = true                       -- ignore case in search patterns
vim.opt.mouse = "a"                             -- allow the mouse to be used in neovim
vim.opt.pumheight = 5                           -- pop up menu height
vim.opt.showmode = false                        -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 2                         -- always show tabs
vim.opt.smartcase = true                        -- smart case
vim.opt.smartindent = true                      -- make indenting smarter again
vim.opt.splitbelow = true                       -- force all horizontal splits to go below current window
vim.opt.splitright = true                       -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false                        -- creates a swapfile
vim.opt.termguicolors = true                    -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 300                        -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.title = true                            -- set the title of window to the value of the titlestring
vim.opt.titlestring = "%<%F%=%l/%L - nvim"      -- what the title of the window will be set to
vim.opt.undodir = vim.fn.stdpath "cache" .. "/undo"
vim.opt.undofile = true                         -- enable persistent undo
vim.opt.updatetime = 300                        -- faster completion
vim.opt.writebackup = false                     -- if a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited
vim.opt.expandtab = true                        -- convert tabs to spaces
vim.opt.shiftwidth = 4                          -- the number of spaces inserted for each indentation
vim.opt.tabstop = 4                             -- insert 2 spaces for a tab
vim.opt.cursorline = true                       -- highlight the current line
vim.opt.cursorcolumn = false                    -- highlight the current line
vim.opt.number = true                           -- set numbered lines
vim.opt.relativenumber = true                   -- set relative numbered lines
vim.opt.numberwidth = 4                         -- set number column width to 2 {default 4}
-- vim.opt.signcolumn = "yes" -- always show the sign column otherwise it would shift the text each time
vim.opt.wrap = true                             -- display lines as one long line
vim.opt.spell = false
vim.opt.spelllang = "en"
vim.opt.scrolloff = 8 -- is one of my fav
vim.opt.sidescrolloff = 8

-- vim options
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.relativenumber = true

-- general
lvim.log.level = "info"
lvim.format_on_save = {
    enabled = true,
    pattern = "*.lua",
    timeout = 1000,
}

-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
lvim.plugins = {
    -- {
    --   "folke/trouble.nvim",
    --   cmd = "TroubleToggle",
    -- },
    {
        "phaazon/hop.nvim",
        event = "BufRead",
        config = function()
            require("hop").setup()
            vim.api.nvim_set_keymap("n", "<leader>j", ":HopWord<cr>", { silent = true })
        end,
    },
    {
        "Mofiqul/vscode.nvim",
    },
    -- {
    --   url = 'https://github.com/kana/vim-smartword.git',
    -- },
    -- {
    --   url = 'https://github.com/bkad/CamelCaseMotion.git',
    -- },
    -- {
    --   'mfussenegger/nvim-jdtls',
    -- },
    -- {
    --   "iamcco/markdown-preview.nvim",
    --   ft = "markdown",
    --   -- build = "cd app && yarn install",
    --   build = ":call mkdp#util#install()",
    -- },
}

-- Color Scheme
-- local c = require('vscode.colors').get_colors()
local black = '#080808'
require('vscode').setup({
    disable_nvimtree_bg = true,
    color_overrides = {
        vscBack = black,
    },
    group_overrides = {
        BufferLineIndicatorSelected = { fg = black, bg = black },
        BufferLineFill = { fg = black, bg = black },
    }

})
lvim.colorscheme = "vscode"

-- bufferline
local bufferline = require('bufferline')
bufferline.setup({
    options = {
        indicator = {
            style = 'underline',
        },
    },
})

-- lualine
lvim.builtin.lualine.style = "lvim" -- "default" "lvim" or "none"
lvim.builtin.lualine.sections.lualine_a = { "mode" }

local custom_vscode = require "lualine.themes.vscode"
local lualine_black = '#1F1F1F'
custom_vscode.insert.c = { bg = lualine_black }
custom_vscode.visual.c = { bg = lualine_black }
custom_vscode.replace.c = { bg = lualine_black }
custom_vscode.command.c = { bg = lualine_black }
custom_vscode.normal.c = { bg = lualine_black }
lvim.builtin.lualine.options.theme = custom_vscode

-- Remember last position.
-- adapted from https://github.com/ethanholz/nvim-lastplace/blob/main/lua/nvim-lastplace/init.lua
local ignore_buftype = { "quickfix", "nofile", "help" }
local ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" }

local function run()
    if vim.tbl_contains(ignore_buftype, vim.bo.buftype) then
        return
    end

    if vim.tbl_contains(ignore_filetype, vim.bo.filetype) then
        -- reset cursor to first line
        vim.cmd [[normal! gg]]
        return
    end

    -- If a line has already been specified on the command line, we are done
    --   nvim file +num
    if vim.fn.line(".") > 1 then
        return
    end

    local last_line = vim.fn.line([['"]])
    local buff_last_line = vim.fn.line("$")

    -- If the last line is set and the less than the last line in the buffer
    if last_line > 0 and last_line <= buff_last_line then
        local win_last_line = vim.fn.line("w$")
        local win_first_line = vim.fn.line("w0")
        -- Check if the last line of the buffer is the same as the win
        if win_last_line == buff_last_line then
            -- Set line to last line edited
            vim.cmd [[normal! g`"]]
            -- Try to center
        elseif buff_last_line - last_line > ((win_last_line - win_first_line) / 2) - 1 then
            vim.cmd [[normal! g`"zz]]
        else
            vim.cmd [[normal! G'"<c-e>]]
        end
    end
end

vim.api.nvim_create_autocmd({ 'BufWinEnter', 'FileType' }, {
    group    = vim.api.nvim_create_augroup('nvim-lastplace', {}),
    callback = run
})

-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- always installed on startup, useful for parsers without a strict filetype
-- lvim.builtin.treesitter.ensure_installed = { "comment", "markdown_inline", "regex" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })

-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("marksman", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "stylua" },
--   {
--     command = "prettier",
--     extra_args = { "--print-width", "100" },
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     command = "shellcheck",
--     args = { "--severity", "warning" },
--   },
-- }
-- vim.g.mkdp_open_to_the_world = 1
-- vim.g.mkdp_browser = 'firefox'

-- vim.g.nvim_tree_group_empty = 1

-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })

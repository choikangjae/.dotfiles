-- -- keymap
local options = { noremap = true, silent = true }
local map = vim.keymap
map.set("i", "<C-e>", "<esc>A;<cr>", options)

map.set("i", "jk", "<esc>", options)
map.set("i", "kj", "<esc>", options)

map.set("", "<Up>", "<c-p>", options)
map.set("", "<Down>", "<c-n>", options)
map.set("", "e", "$", options)
map.set("", "s", "^", options)

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
map.set("n", "M", "'", options)

map.set("v", "<cr>", "<esc>", options)
map.set("v", "J", "7gjzzzv", options)
map.set("v", "K", "7gkzzzv", options)

map.set("", "gr", ":BufferLineCyclePrev<cr>", options)
map.set("", "gt", ":BufferLineCycleNext<cr>", options)

lvim.keys.normal_mode["<leader>cn"] = "<cmd>lua vim.lsp.buf.rename()<CR>"
-- lvim.keys.normal_mode["<leader>so"] = ":so ~/.config/lvim/config.lua<CR>"

-- refactoring
map.set("v", "R", ":lua require('refactoring').select_refactor()<CR>",
    { noremap = true, silent = true, expr = false })

-- -- keymap DONE

vim.api.nvim_create_autocmd("BufEnter",
    { callback = function() vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" } end, })

lvim.builtin.which_key.mappings["t"] = {
    name = "Diagnostics",
    t = { "<cmd>TroubleToggle<cr>", "trouble" },
    w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace" },
    d = { "<cmd>TroubleToggle document_diagnostics<cr>", "document" },
    q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
    l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
    r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
}

-- -- lvim builtin
-- dap
lvim.builtin.dap.active = true

-- https://gist.github.com/mengwangk/9be5794515f0c56016a5b1fe4a2297e1
lvim.builtin.which_key.mappings["d"] = {
    name = "Debug",
    R = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to Cursor" },
    E = { "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", "Evaluate Input" },
    C = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", "Conditional Breakpoint" },
    U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
    b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
    c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
    e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
    g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
    h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
    S = { "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", "Scopes" },
    i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
    o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
    p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
    q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
    s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
    t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
    x = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
    u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
}

local dap = require('dap')
-- -- C/C++/Rust
dap.adapters.codelldb = {
    type = 'server',
    port = "${port}",
    executable = {
        command = '/home/user1/.local/share/lvim/mason/bin/codelldb',
        args = { "--port", "${port}" },
    }
}
dap.configurations.rust = {
    {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
    },
}
dap.configurations.cpp = dap.configurations.rust
dap.configurations.c = dap.configurations.rust
-- -- C/C++/Rust DONE

-- -- Python
-- local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
-- require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")

-- nvimtree
vim.api.nvim_set_keymap('n', '<c-d>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
lvim.builtin.nvimtree.setup.actions.open_file.quit_on_open = true
lvim.builtin.nvimtree.setup.view.width = 5

-- lsp
lvim.lsp.buffer_mappings.normal_mode['gR'] = lvim.lsp.buffer_mappings.normal_mode['gr']
lvim.lsp.buffer_mappings.normal_mode['gr'] = nil
lvim.lsp.buffer_mappings.normal_mode['gh'] = lvim.lsp.buffer_mappings.normal_mode['K']
lvim.lsp.buffer_mappings.normal_mode['K'] = nil

-- telescope
lvim.builtin.telescope.defaults.initial_mode = 'normal'

-- toggleterm https://github.com/akinsho/toggleterm.nvim
lvim.builtin.terminal.open_mapping = "<c-t>"
-- lvim.builtin.terminal.size = 6
-- lvim.builtin.terminal.direction = 'horizontal'
-- lvim.builtin.terminal.start_in_insert = true
map.set('t', 'g<esc>', [[<C-\><C-n>]], options)

-- -- lvim builtin DONE

-- -- vim basic settings
vim.opt.backup = false                          -- creates a backup file
vim.opt.clipboard = "unnamedplus"               -- allows neovim to access the system clipboard
-- vim.opt.cmdheight = 2 -- more space in the neovim command line for displaying messages
vim.opt.colorcolumn = "99999"                   -- fixes indentline for now
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.conceallevel = 0                        -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8"                  -- the encoding written to a file
vim.opt.foldmethod = "manual"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
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
vim.opt.wrap = true                             -- display lines as one long line
vim.opt.spell = false
vim.opt.spelllang = "en"
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.relativenumber = true
-- -- vim basic settings DONE

-- -- plugins
lvim.plugins = {
    -- {
    --     "Pocco81/auto-save.nvim",
    -- },
    "mfussenegger/nvim-dap-python",
    "nvim-neotest/neotest",
    "nvim-neotest/neotest-python",
    -- {
    --     "ThePrimeagen/refactoring.nvim",
    -- },
    {
        "TheLeoP/refactoring.nvim",
        branch = "fix_390"
    },
    {
        "folke/todo-comments.nvim",
        event = "BufRead",
        config = function()
            require("todo-comments").setup()
        end,
    },
    {
        "tpope/vim-surround",
    },
    {
        "folke/trouble.nvim"
    },
    {
        "phaazon/hop.nvim",
        event = "BufRead",
        config = function()
            require("hop").setup()
            vim.api.nvim_set_keymap("n", "t", ":HopWord<cr>", { silent = true })
        end,
    },
    -- vscode theme
    {
        "Mofiqul/vscode.nvim",
    },
    -- :MarkdownPreview to use it on markdown file.
    {
        "iamcco/markdown-preview.nvim",
        ft = "markdown",
        build = ":call mkdp#util#install()",
    },
}
-- -- plugins DONE

-- -- Plugin settings

-- -- MarkdownPreview
vim.g.mkdp_auto_start = 1

-- -- Color scheme
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
-- Color scheme DONE

-- -- bufferline
lvim.builtin.bufferline.options.indicator.style = "underline"
-- -- bufferline DONE

-- -- lualine
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
-- -- lualine DONE

-- -- Plugin settings DONE

-- Remember last position
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
-- Remember last position DONE

-- -- Autogenerated by Lunarvim until the EOF
-- general
lvim.log.level = "info"
lvim.format_on_save = {
    enabled = true,
}

lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.nvimtree.setup.view.width = 30

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true
-- -- created automatically DONE

-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- always installed on startup, useful for parsers without a strict filetype
-- lvim.builtin.treesitter.ensure_installed = { "comment", "markdown_inline", "regex" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false
-- lvim.lsp.installer.setup.automatic_installation.exclude = { "pyright" }

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--     return server ~= "pyright"
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
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    { name = "black" },
    {
        name = "prettier",
        args = { "--print-width", "100" },
        filetypes = { "typescript", "typescriptreact", "javascript" },
    },
    { name = "markdownlint" },
    { name = "rustfmt" },
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
    {
        command = "ruff",
        filetypes = { "python" },
    },
    {
        command = "shellcheck",
        filetypes = { "sh" },
        args = { "--severity", "warning" },
    },
    {
        command = "markdownlint",
        filetypes = { "markdown" },
    },
    {
        command = "eslint_d",
        filetypes = { "javascript", "typescript" },
    },
}

local opts = {} -- check the lspconfig documentation for a list of all possible options
require("lvim.lsp.manager").setup("marksman", opts)

-- add `pyright` to `skipped_servers` list
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- remove `jedi_language_server` from `skipped_servers` list
lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
    return server ~= "jedi_language_server"
end, lvim.lsp.automatic_configuration.skipped_servers)

-- vim.g.nvim_tree_group_empty = 1

-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })

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

map.set({ "n", "v" }, "gp", "\"0p", options)

map.set("v", "<cr>", "<esc>", options)
map.set("v", "J", "7gjzzzv", options)
map.set("v", "K", "7gkzzzv", options)

map.set("", "gr", ":BufferLineCyclePrev<cr>", options)
map.set("", "gt", ":BufferLineCycleNext<cr>", options)

lvim.keys.normal_mode["<leader>cn"] = "<cmd>lua vim.lsp.buf.rename()<CR>"

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
    q = { "<cmd>lua require'dapui'.close()<cr>", "Quit" },
    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
    s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
    t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
    x = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
    u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
}

-- require("dapui").open()
-- require("dapui").close()
-- require("dapui").toggle()

-- For more configurations, https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
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

-- -- typescript, javascript
local js_based_languages = { "typescript", "javascript", "typescriptreact" }

for _, language in ipairs(js_based_languages) do
    require("dap").configurations[language] = {
        {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
        },
        {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require 'dap.utils'.pick_process,
            cwd = "${workspaceFolder}",
        },
        {
            type = "pwa-chrome",
            request = "launch",
            name = "Start Chrome with \"localhost\"",
            url = "http://localhost:3000",
            webRoot = "${workspaceFolder}",
            userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir"
        }
    }
end

-- -- typescript, javascript DONE

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
lvim.builtin.telescope.defaults.initial_mode = 'normal' -- init telescope in normal mode, not insert mode
lvim.builtin.telescope.defaults.mappings = {
    n = {

        ["q"] = require('telescope.actions').close,
    }
}

lvim.builtin.which_key.mappings["f"] = {
    name = "Find",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    f = { "<cmd>Telescope find_files<cr>", "Find files" },
    t = { "<cmd>Telescope live_grep<cr>", "Find Text" },
    s = { "<cmd>Telescope grep_string<cr>", "Find String" },
    h = { "<cmd>Telescope help_tags<cr>", "Help" },
    H = { "<cmd>Telescope highlights<cr>", "Highlights" },
    i = { "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>", "Media" },
    l = { "<cmd>Telescope resume<cr>", "Last Search" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
}

-- toggleterm https://github.com/akinsho/toggleterm.nvim
lvim.builtin.terminal.open_mapping = "<c-t>"
map.set('t', 'g<esc>', [[<C-\><C-n>]], options)

-- -- lvim builtin DONE

-- -- vim basic settings
vim.opt.backup = false                     -- creates a backup file
vim.opt.clipboard = "unnamedplus"          -- allows neovim to access the system clipboard
-- vim.opt.cmdheight = 2 -- more space in the neovim command line for displaying messages
vim.opt.colorcolumn = "99999"              -- fixes indentline for now
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.conceallevel = 0                   -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8"             -- the encoding written to a file
vim.opt.hidden = true                      -- required to keep multiple buffers and open multiple buffers
vim.opt.hlsearch = true                    -- highlight all matches on previous search pattern
vim.opt.ignorecase = true                  -- ignore case in search patterns
vim.opt.mouse = "a"                        -- allow the mouse to be used in neovim
vim.opt.pumheight = 5                      -- pop up menu height
vim.opt.showmode = false                   -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 2                    -- always show tabs
vim.opt.smartcase = true                   -- smart case
vim.opt.smartindent = true                 -- make indenting smarter again
vim.opt.splitbelow = true                  -- force all horizontal splits to go below current window
vim.opt.splitright = true                  -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false                   -- creates a swapfile
vim.opt.termguicolors = true               -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 300                   -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.title = true                       -- set the title of window to the value of the titlestring
vim.opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to
vim.opt.undodir = vim.fn.stdpath "cache" .. "/undo"
vim.opt.undofile = true                    -- enable persistent undo
vim.opt.updatetime = 300                   -- faster completion
vim.opt.writebackup = false                -- if a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited
vim.opt.expandtab = true                   -- convert tabs to spaces
vim.opt.shiftwidth = 4                     -- the number of spaces inserted for each indentation
vim.opt.tabstop = 4                        -- insert 2 spaces for a tab
vim.opt.cursorline = true                  -- highlight the current line
vim.opt.cursorcolumn = false               -- highlight the current line
vim.opt.number = true                      -- set numbered lines
vim.opt.relativenumber = true              -- set relative numbered lines
vim.opt.numberwidth = 4                    -- set number column width to 2 {default 4}
vim.opt.wrap = true                        -- display lines as one long line
vim.opt.spell = false
vim.opt.spelllang = "en"
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.relativenumber = true
-- -- vim basic settings DONE

-- -- fold
vim.opt.foldenable = true
vim.opt.foldmethod = "expr"                     -- "expr" "manual"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
vim.opt.foldlevel = 99                          -- Using ufo provider need a large value, feel free to decrease the value
vim.opt.foldcolumn = '1'                        -- '0' is not bad
vim.opt.foldlevelstart = 99
-- -- fold DONE

-- -- plugins
lvim.plugins = {
    {
        "mfussenegger/nvim-dap",
        lazy = true,
        dependencies = {
            -- "rcarriga/nvim-dap-ui",
            "mxsdev/nvim-dap-vscode-js",
            -- lazy spec to build "microsoft/vscode-js-debug" from source
            {
                "microsoft/vscode-js-debug",
                version = "1.x",
                -- build = "npm i && npm run compile vsDebugServerBundle && mv dist out"
            }
        },
        keys = { ... },
        config = function()
            require("dap-vscode-js").setup({
                debugger_path =
                "/home/user1/.local/share/lunarvim/site/pack/lazy/opt/vscode-js-debug",
                adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
            })
            require("dapui").setup()
        end
    },
    {
        "ThePrimeagen/refactoring.nvim",
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
    -- python dap
    "mfussenegger/nvim-dap-python",
    "nvim-neotest/neotest",
    "nvim-neotest/neotest-python",
    -- python dap DONE
}
-- -- plugins DONE

-- -- Plugin settings

-- -- MarkdownPreview
vim.g.mkdp_auto_start = 0

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
lvim.builtin.treesitter.auto_install = true

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

-- Change python default lsp
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
    return server ~= "jedi_language_server"
end, lvim.lsp.automatic_configuration.skipped_servers)

-- autocmd augroup
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- https://github.com/NickP-real/.dotfile/blob/main/.config/nvim/lua/core/autocmd.lua#L31
-- Use 'q' to quit from common plugins
autocmd("FileType", {
    pattern = {
        "help",
        "man",
        "lspinfo",
        "trouble",
        "null-ls-info",
        "qf",
        "help",
        "notify",
        "startuptime",
    },
    callback = function(event)
        vim.opt_local.wrap = false
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})

-- https://github.com/NickP-real/.dotfile/blob/main/.config/nvim/lua/core/autocmd.lua#L51
-- Persistent Folds
local save_fold = augroup("Persistent Folds", { clear = true })
autocmd("BufWinLeave", {
    pattern = "*.*",
    callback = function()
        vim.cmd.mkview()
    end,
    group = save_fold,
})
autocmd("BufWinEnter", {
    pattern = "*.*",
    callback = function()
        vim.cmd.loadview({ mods = { emsg_silent = true } })
    end,
    group = save_fold,
})

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

autocmd({ 'BufWinEnter', 'FileType' }, {
    group    = augroup('nvim-lastplace', {}),
    callback = run
})
-- Remember last position DONE

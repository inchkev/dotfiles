-- Map leader key to space

vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- Load plugins

local Plug = vim.fn["plug#"]
vim.call("plug#begin", "~/.config/nvim/plugged")

    -- telescope file finder/picker
    Plug("nvim-lua/plenary.nvim")
    Plug("nvim-telescope/telescope.nvim", { tag = "0.1.3" })
    -- nvim language servers
    Plug("nvim-treesitter/nvim-treesitter", { ['do'] = vim.fn[":TSUpdate"] })
    Plug("neovim/nvim-lspconfig")
    -- autocompletion
    Plug("hrsh7th/cmp-nvim-lsp")
    Plug("hrsh7th/cmp-buffer")
    Plug("hrsh7th/cmp-path")
    Plug("hrsh7th/cmp-cmdline")
    Plug("hrsh7th/nvim-cmp")
    Plug("hrsh7th/cmp-vsnip")
    Plug("hrsh7th/vim-vsnip")
    Plug("simrat39/rust-tools.nvim")
    -- Plug("neoclide/coc.nvim", { branch = "release" })
    -- qol
    Plug("tpope/vim-commentary")
    Plug("tpope/vim-surround")
    Plug("tpope/vim-sensible")
    Plug("lukas-reineke/indent-blankline.nvim")
    -- color scheme!
    Plug("morhetz/gruvbox")
    -- status line
    Plug("nvim-lualine/lualine.nvim")
    -- smooth scrolling
    Plug("karb94/neoscroll.nvim")

vim.call("plug#end")

require("ibl").setup {
    scope = {
        show_start = false,
        show_end = false,
    }
}
require("neoscroll").setup()
require("lualine").setup {
    options = {
        icons_enabled = false,
        section_separators = "",
        component_separators = "",
    },
}

-- configure lsp and completion

vim.o.completeopt = "menuone,noinsert,noselect"

-- Avoid showing extra messages when using completion
vim.opt.shortmess = vim.opt.shortmess + "c"

require("rust-tools").setup {
  tools = {
    runnables = {
      use_telescope = true,
    },
    inlay_hints = {
      auto = true,
      show_parameter_hints = true,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
  },

  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
  server = {
    -- on_attach is a callback called when the language server attachs to the buffer
    on_attach = on_attach,
    settings = {
      -- to enable rust-analyzer settings visit:
      -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      ["rust-analyzer"] = {
        -- enable clippy on save
        checkOnSave = {
          command = "clippy",
        },
        rustfmt = {
            extraArgs = { "+nightly" },
        },
      },
    },
  },
}

local cmp = require("cmp")
cmp.setup({
    preselect = cmp.PreselectMode.None,
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        -- Add tab support
        -- ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        -- ["<Tab>"] = cmp.mapping.confirm(),
        -- ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        -- ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<Tab>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        }),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        }),
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "buffer" },
    },
})

require("nvim-treesitter.configs").setup {
    -- sync_install = false,
    ensure_installed = { "c", "lua", "vim", "vimdoc", "rust", "python", "javascript" },
    auto_install = true,
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})


-- Colorscheme

vim.g.gruvbox_contrast_dark = "medium"
vim.g.gruvbox_contrast_light = "medium"
vim.g.gruvbox_invert_selection = 1

vim.opt.termguicolors = true
vim.cmd.colorscheme("gruvbox")


-- Options

vim.opt.number = true           -- Show line number
vim.opt.relativenumber = true   -- Show relative line number

    -- "Tab" options
vim.opt.expandtab = true        -- Use spaces instead of tabs
vim.opt.shiftwidth = 4          -- Number of spaces to use for autoindent
vim.opt.softtabstop = 4
vim.opt.tabstop = 4

    -- search options
vim.opt.ignorecase = true       -- Ignore case when searching
vim.opt.smartcase = true        -- Ignore case if search pattern is all lowercase, case-sensitive otherwise

    -- visual stuff
vim.opt.list = true
vim.opt.listchars = { tab = "→  ", trail = "·", nbsp = "␣", extends = "⟩", precedes = "⟨" }
vim.opt.signcolumn = "number"
vim.opt.colorcolumn = { 80, 120 }

vim.wo.wrap = false


-- netrw

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3


-- Status line

-- vim.opt.statusline:append "%f"


-- Custom functions

local function setTabSize(n)
    vim.opt.tabstop = n
    vim.opt.shiftwidth = n
    vim.opt.softtabstop = n
end
vim.api.nvim_create_user_command("Tab",
    function(opts)
        setTabSize(tonumber(opts.fargs[1]))
    end,
    { nargs = 1 })


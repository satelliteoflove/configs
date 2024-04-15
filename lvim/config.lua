--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]
-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
vim.opt.colorcolumn = "80"

vim.opt.foldmethod = "expr" -- default is "manual"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- default is ""
vim.opt.foldenable = false -- if this option is true and fold method option is other than normal, every time a document is opened everything will be folded.

vim.opt.textwidth = 0 -- ensure no line breaks are automatically set
vim.opt.wrap = true -- enable line wrapping
vim.opt.linebreak = true -- break lines at word boundaries
vim.opt.showbreak = "↪"

-- Function to save the current view of the file before it is closed, and load
-- that view when the file is opened. Avoids errors in non-file buffers.
local function auto_save_view()
	vim.cmd([[
    augroup AutoSaveFolds
      autocmd!
      autocmd BufWinLeave * if expand('%') != '' && &buftype == '' | silent! mkview | endif
      autocmd BufWinEnter * if expand('%') != '' && &buftype == '' | silent! loadview | endif
    augroup END
  ]])
end

-- Call the function to setup the autosave view
auto_save_view()

-- Update color scheme when MacOS appearance changes
local function update_color_scheme()
	local handle = io.popen("~/Documents/the4ofus/repos/configs/lvim/check_appearance.sh")
	local result = handle:read("*a")
	handle:close()
	local scheme = "lunar" -- default to dark scheme
	if result:match("false") then
		scheme = "carbonized-light"
	end
	if vim.g.colors_name ~= scheme then
		-- use 'silent!' to suppress output from the command
		vim.cmd("silent! colorscheme " .. scheme)
	end
end

update_color_scheme() -- Call on startup to set initial color scheme

-- Update color scheme whenever a buffer is entered or changed
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "BufRead" }, {
	callback = function()
		update_color_scheme()
	end,
})

-- general
lvim.log.level = "info"
lvim.format_on_save = {
	enabled = true,
	pattern = "*.lua",
	timeout = 1000,
}
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- -- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.setup.plugins.presets.z = true

-- -- Change theme settings
lvim.colorscheme = "lunar"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true

-- Map <F5> to allow inserting current date/time
lvim.keys.insert_mode["<F5>"] = "<C-R>=strftime('%Y-%m-%d %H:%M:%S')<CR>"

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- always installed on startup, useful for parsers without a strict filetype
lvim.builtin.treesitter.ensure_installed = {
	"bash",
	"comment",
	"hcl",
	"markdown_inline",
	"python",
	"regex",
	"terraform",
}

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

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
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ command = "black", extra_args = { "--line-length 79" }, filetypes = { "python" } },
	{ command = "stylua" },
	{
		command = "prettier",
		extra_args = { "--print-width", "100" },
		filetypes = { "typescript", "typescriptreact" },
	},
})
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{ command = "flake8", filetypes = { "python" } },
	{
		command = "shellcheck",
		args = { "--severity", "warning" },
	},
})

-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
-- Prevent tab from completing Codeium suggestions
vim.g.codeium_no_map_tab = true

lvim.plugins = {
	{
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
	},
	{
		"simnalamburt/vim-mundo",
	},
	{
		"f-person/git-blame.nvim",
	},
	{
		"mfussenegger/nvim-dap-python",
	},
	{
		"fatih/vim-go",
	},
	{
		"Exafunction/codeium.vim",
		config = function()
			vim.keymap.set("i", "<C-g>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true })
		end,
	},
	{
		"rafi/awesome-vim-colorschemes",
	},
	{
		"rust-lang/rust.vim",
	},
	{
		"simrat39/rust-tools.nvim",
	},
}


require("rust-tools").setup({})

-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })

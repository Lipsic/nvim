require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {"lua_ls"}
})

require'lspconfig'.lua_ls.setup{}
vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})


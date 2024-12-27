require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {"lua_ls", "gopls"}
})

require'lspconfig'.lua_ls.setup{}
vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
vim.keymap.set({'n', 'v'}, '<space>ca', vim.lsp.buf.code_action, {})
vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, {})


require'lspconfig'.gopls.setup{
	cmd = {"gopls"},
	filetypes = {"go", "gomod", "gowork", "gotmpl"},
	settings = {
		gopls = {
			completeUnimported = true,
			usePlaceholders = true,
			analyses = {
				unusedparams = true,
			}

		}
	}
}

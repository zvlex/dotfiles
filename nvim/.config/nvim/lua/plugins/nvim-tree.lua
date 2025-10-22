vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return {
 'nvim-tree/nvim-tree.lua',
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
	  require("nvim-tree").setup({
		  git = { enable = true },
		  view = {
			  width = 30,
			  side = 'left',
		  },
	  })
      
	  vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
	  vim.keymap.set("n", "<leader>f", ":NvimTreeFocus<CR>", { noremap = true, silent = true })
  end
} 

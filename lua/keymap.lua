-- lsp related

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- region nvim_tree
vim.keymap.set('n', '<F5>', ':NvimTreeToggle<CR>', opts)
vim.keymap.set('n', '<F6>', ':NvimTreeFocus<CR>', opts)

-- region telescope
local builtin = require('telescope.builtin')
-- vim.keymap.set('n', '<leader>te', ':Telescope<CR>', opts)
vim.keymap.set('n', '<leader>te', builtin.builtin, opts)
vim.keymap.set('n', '<leader>ff', builtin.find_files, opts)
vim.keymap.set('n', '<leader>of', builtin.oldfiles, opts)
vim.keymap.set('n', '<leader>lg', builtin.live_grep, opts)

-- clipboard keymap
-- use unnamed clipboard('+' register)
vim.keymap.set('v', '<c-c>', '"+y', opts) -- visual mode: copy selection
vim.keymap.set('n', '<c-c>', '"+yy', opts) -- normal mode: copy line 
vim.keymap.set('n', '<c-v>', '"+p', opts) -- normal mode: paste

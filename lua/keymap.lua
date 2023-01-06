-- lsp related
local M = {}

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
M.setup = function()
    local opts = { noremap = true, silent = true }
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

    -- region nvim_tree
    local nvim_tree = require("nvim-tree")
    -- nvim_tree.
    vim.keymap.set('n', '<A-0>', function()
        local main_win_num = 1000
        vim.api.nvim_set_current_win(main_win_num)
    end, opts)

    vim.keymap.set('n', '<A-1>', nvim_tree.focus, opts)

    -- region telescope
    local builtin = require('telescope.builtin')
    local frecency = require('telescope').extensions.frecency
    -- vim.keymap.set('n', '<leader>te', ':Telescope<CR>', opts)
    vim.keymap.set('n', '<space>te', builtin.builtin, opts)
    vim.keymap.set('n', '<space>ff', builtin.find_files, opts)
    vim.keymap.set('n', '<space>of', builtin.oldfiles, opts)
    vim.keymap.set('n', '<space>lg', builtin.live_grep, opts)
    -- 'frecency' is better than 'oldfiles'
    vim.keymap.set('n', '<space>rf', frecency.frecency, opts)

    -- clipboard keymap
    -- use unnamed clipboard('+' register)
    vim.keymap.set('v', '<C-c>', '"+y', opts) -- visual mode: copy selection
    vim.keymap.set('n', '<C-c>', '"+yy', opts) -- normal mode: copy line
    vim.keymap.set('n', '<C-v>', '"+p', opts) -- normal mode: paste

    -- runtime keymap
    vim.keymap.set('n', '<A-r>', runtime.reload, { noremap = true, silent = false }) -- you dont want a 'silent' for this
end

-- Execute key-mapping for lsp on_attach
M.execute_lsp_attach_mapping = function(bufopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', '<C-b>', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<A-CR>', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<A-F7>', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

M.execute_terminal_mapping = function()
    local opts = { noremap = true, buffer = 0 }
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

-- Return mapping table for nvim_cmp
M.create_nvim_cmp_mapping = function()
    local luasnip = require('luasnip')
    local cmp = require('cmp')
    return {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }
end

-- Return mapping table for nvim_comment
M.create_comment_mapping = function()
    return {
        line_mapping = "<C-_>",
        -- operator_mapping = "<C-_>",
        comment_chunk_text_object = "<C-A-_>",
    }
end

return M

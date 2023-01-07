local utils = {}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
utils.default_on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    keymap.execute_lsp_attach_mapping(bufopts)
end

-- Add additional capabilities supported by nvim-cmp
utils.default_capabilities = require("cmp_nvim_lsp").default_capabilities()

utils.default_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}

-- if no additional settings, use this
utils.default_setup = {
    capabilities = utils.default_capabilities,
    on_attach = utils.default_on_attach,
    flags = utils.default_flags,
}

return utils

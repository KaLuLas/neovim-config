-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local default_on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    keymap.execute_lsp_attach_mapping(bufopts)
end

-- Add additional capabilities supported by nvim-cmp
local default_capabilities = require("cmp_nvim_lsp").default_capabilities()

local default_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}

-- if no additional settings, use this
local default_setup = {
    capabilities = default_capabilities,
    on_attach = default_on_attach,
    flags = default_flags,
}

return {
    default_on_attach = default_on_attach,
    default_capabilities = default_capabilities,
    default_flags = default_flags,
    default_setup = default_setup,
}

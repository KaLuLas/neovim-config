local function get_config(capabilities, on_attach, flags)
    -- sumneko_lua setup
    -- reference: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    return {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = flags,

        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = { 'vim' },
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                    enable = false,
                },
            },
        },
    }
end

return {
    get_config = get_config,
}

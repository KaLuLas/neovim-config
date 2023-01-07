local ensure_installed_lsp_list = {
    'pyright',
    'bashls',
    'clangd',
    'gopls',
    'marksman',
    'tsserver',
    'volar',
    'omnisharp',
    'sumneko_lua',
}

-- quick mason setup
require('mason').setup()
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require('lspconfig')
local lsp_utils = require('plugin.lsp.utils')

mason_lspconfig.setup({
    ensure_installed = ensure_installed_lsp_list,
})

mason_lspconfig.setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
        -- print(string.format("server %s setup with default_handler", server_name))
        lspconfig[server_name].setup(lsp_utils.default_setup)
    end,
    -- Next, you can provide a dedicated handler for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    ["sumneko_lua"] = function()
        -- print("sumneko_lua setup with dedicated handler")
        -- sumneko_lua setup
        local sumneko_settings = { settings = require('plugin.lsp.sumneko_lua').get_setting() }
        local sumneko_lua_setup = vim.tbl_deep_extend("force", lsp_utils.default_setup, sumneko_settings)
        lspconfig["sumneko_lua"].setup(sumneko_lua_setup)
    end
}

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert(keymap.create_nvim_cmp_mapping()),
    sources = cmp.config.sources(
        {
            { name = 'nvim_lsp' },
            -- { name = 'vsnip' }, -- For vsnip users.
            { name = 'luasnip' }, -- For luasnip users.
            -- { name = 'ultisnips' }, -- For ultisnips users.
            -- { name = 'snippy' }, -- For snippy users.
        },
        {
            { name = 'buffer' },
        }
    ),
}

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

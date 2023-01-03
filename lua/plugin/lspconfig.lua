-- quick mason setup
require('mason').setup()
require('mason-lspconfig').setup()

local lspconfig = require('lspconfig')
local lsp_utils = require('plugin.lsp.utils')
local default_lsp_capabilities = lsp_utils.default_capabilities
local default_lsp_on_attach = lsp_utils.default_on_attach
local default_lsp_flags = lsp_utils.default_flags

-- sumneko_lua setup
lspconfig.sumneko_lua.setup(require('plugin.lsp.sumneko_lua').get_config(default_lsp_capabilities, default_lsp_on_attach, default_lsp_flags))

local easy_lsp_list = {
    'pyright',
    'bashls',
    'clangd',
    'gopls',
    'marksman',
    'tsserver',
    'volar',
}

for _, lsp in ipairs(easy_lsp_list) do
    lspconfig[lsp].setup(lsp_utils.default_setup)
end

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
    mapping = cmp.mapping.preset.insert(require('keymap').create_nvim_cmp_mapping()),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
}

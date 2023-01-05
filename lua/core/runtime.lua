-- Personal neovim runtim API, this moudle should not be reloaded
local M = {}

-- return true is reload() is processing
M.is_reloading = false

-- moudles which are not reloaded
M.persisted_packages = {
    ["core.runtime"] = true,
    ["bit"] = true,
}

-- All available moudles in package.loaded will be reload
M.reload = function()
    local reload = require("plenary.reload").reload_module
    M.is_reloading = true
    for name, _ in pairs(package.loaded) do
        if M.persisted_packages[name] then
            vim.notify(string.format("[core.runtime.reload] loaded package '%s' is skipped", name), vim.log.levels.INFO)
        else
            reload(name)
        end
    end

    dofile(vim.env.MYVIMRC)
    M.is_reloading = false
    vim.notify("[core.runtime.reload] all loaded package reloaded!", vim.log.levels.INFO)
end

return M

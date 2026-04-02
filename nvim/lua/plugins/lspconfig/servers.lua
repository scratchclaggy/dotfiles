---@type table<string, vim.lsp.Config>
local servers = {
  lua_ls = {
    on_init = function(client)
      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
      end

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          version = 'LuaJIT',
          path = { 'lua/?.lua', 'lua/?/init.lua' },
        },
        workspace = {
          checkThirdParty = false,
          library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), {
            '${3rd}/luv/library',
            '${3rd}/busted/library',
          }),
        },
      })
    end,
    settings = {
      Lua = {},
    },
  },
  denols = {
    root_markers = { 'deno.json', 'deno.jsonc' },
    workspace_required = true,
  },
  biome = {
    root_markers = { 'biome.json' },
    workspace_required = true,
  },
  jsonls = {},
  tailwindcss = require 'plugins.lspconfig.tailwindcss',
  tsgo = {
    root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json' },
    workspace_required = true,
    on_attach = function(client, bufnr)
      if vim.fs.root(bufnr, { 'deno.json', 'deno.jsonc' }) then client.stop() end
    end,
  },
}

local ensure_installed = {
  'biome',
  'json-lsp',
  'lua-language-server',
  'stylua',
  'tailwindcss-language-server',
  'tsgo',
}

return {
  servers = servers,
  ensure_installed = ensure_installed,
}

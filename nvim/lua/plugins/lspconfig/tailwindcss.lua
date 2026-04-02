-- Async replacement for nvim-lspconfig's find_tailwind_global_css().
-- The upstream version synchronously walks the entire project tree
-- reading every CSS file, blocking the UI for seconds in large projects.
-- This version uses vim.uv async fs operations instead.

local css_extensions = { css = true, scss = true, pcss = true }

--- Async check whether a file contains `@import 'tailwindcss'`.
---@param path string
---@param cb fun(found: boolean)
local function read_and_check(path, cb)
  vim.uv.fs_open(path, 'r', 438, function(err_open, fd)
    if err_open or not fd then return cb(false) end
    vim.uv.fs_fstat(fd, function(err_stat, stat)
      if err_stat or not stat then
        vim.uv.fs_close(fd)
        return cb(false)
      end
      vim.uv.fs_read(fd, stat.size, 0, function(err_read, data)
        vim.uv.fs_close(fd)
        if err_read or not data then return cb(false) end
        cb(data:find("@import 'tailwindcss'", 1, true) ~= nil)
      end)
    end)
  end)
end

--- Async recursive directory scan for a Tailwind v4 entry CSS file.
--- Calls `on_found(path)` with the first match, from the libuv thread.
---@param dir string
---@param on_found fun(path: string)
local function scan_dir(dir, on_found)
  vim.uv.fs_opendir(dir, function(err, handle)
    if err or not handle then return end
    local function read_next()
      vim.uv.fs_readdir(handle, function(rerr, entries)
        if rerr or not entries then
          vim.uv.fs_closedir(handle)
          return
        end
        for _, entry in ipairs(entries) do
          if entry.name:sub(1, 1) ~= '.' and entry.name ~= 'node_modules' then
            local full = dir .. '/' .. entry.name
            if entry.type == 'directory' then
              scan_dir(full, on_found)
            elseif entry.type == 'file' then
              local ext = entry.name:match '%.([^%.]+)$'
              if ext and css_extensions[ext] then read_and_check(full, function(found)
                if found then on_found(full) end
              end) end
            end
          end
        end
        read_next()
      end)
    end
    read_next()
  end, 64)
end

---@type vim.lsp.Config
return {
  before_init = function(_, config)
    config.settings = vim.tbl_deep_extend('force', config.settings or {}, {
      editor = { tabSize = vim.lsp.util.get_effective_tabstop() },
    })
  end,
  on_attach = function(client, bufnr)
    -- Skip if the user has set configFile explicitly
    local tw = ((client.config or {}).settings or {}).tailwindCSS
    if tw and tw.experimental and tw.experimental.configFile then return end

    local root = vim.fs.root(bufnr, '.git') or vim.fn.getcwd()
    scan_dir(root, function(path)
      vim.schedule(function()
        client.settings = vim.tbl_deep_extend('force', client.settings or {}, {
          tailwindCSS = { experimental = { configFile = path } },
        })
        client:notify('workspace/didChangeConfiguration', { settings = client.settings })
      end)
    end)
  end,
}

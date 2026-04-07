-- Async replacement for nvim-lspconfig's find_tailwind_global_css().
-- The upstream version synchronously walks the entire project tree
-- reading every CSS file, blocking the UI for seconds in large projects.
-- This version uses vim.uv async fs operations instead.

local css_extensions = { css = true, scss = true, pcss = true }

-- Maximum number of concurrent libuv fs operations to avoid EMFILE errors.
local MAX_INFLIGHT = 20

--- Async check whether a file contains `@import 'tailwindcss'`.
---@param path string
---@param cb fun(found: boolean)
---@param sem { n: integer } semaphore table (decremented on entry, incremented on exit)
---@param queue { [integer]: fun() } pending work queue
local function read_and_check(path, cb, sem, queue)
  local function flush()
    while sem.n > 0 and #queue > 0 do
      local fn = table.remove(queue, 1)
      fn()
    end
  end

  local function do_open()
    sem.n = sem.n - 1
    vim.uv.fs_open(path, 'r', 438, function(err_open, fd)
      if err_open or not fd then
        sem.n = sem.n + 1
        flush()
        return cb(false)
      end
      vim.uv.fs_fstat(fd, function(err_stat, stat)
        if err_stat or not stat then
          vim.uv.fs_close(fd)
          sem.n = sem.n + 1
          flush()
          return cb(false)
        end
        vim.uv.fs_read(fd, stat.size, 0, function(err_read, data)
          vim.uv.fs_close(fd)
          sem.n = sem.n + 1
          flush()
          if err_read or not data then return cb(false) end
          cb(data:find("@import 'tailwindcss'", 1, true) ~= nil)
        end)
      end)
    end)
  end

  if sem.n > 0 then
    do_open()
  else
    queue[#queue + 1] = do_open
  end
end

--- Async recursive directory scan for a Tailwind v4 entry CSS file.
--- Calls `on_found(path)` with the first match, from the libuv thread.
--- Stops as soon as a match is found and respects the concurrency semaphore.
---@param dir string
---@param on_found fun(path: string)
---@param found_flag { done: boolean }
---@param sem { n: integer }
---@param queue { [integer]: fun() }
local function scan_dir(dir, on_found, found_flag, sem, queue)
  if found_flag.done then return end
  vim.uv.fs_opendir(dir, function(err, handle)
    if err or not handle or found_flag.done then
      if handle then vim.uv.fs_closedir(handle) end
      return
    end
    local function read_next()
      if found_flag.done then
        vim.uv.fs_closedir(handle)
        return
      end
      vim.uv.fs_readdir(handle, function(rerr, entries)
        if rerr or not entries then
          vim.uv.fs_closedir(handle)
          return
        end
        for _, entry in ipairs(entries) do
          if found_flag.done then break end
          if entry.name:sub(1, 1) ~= '.' and entry.name ~= 'node_modules' then
            local full = dir .. '/' .. entry.name
            if entry.type == 'directory' then
              scan_dir(full, on_found, found_flag, sem, queue)
            elseif entry.type == 'file' then
              local ext = entry.name:match '%.([^%.]+)$'
              if ext and css_extensions[ext] then
                read_and_check(full, function(found)
                  if found and not found_flag.done then
                    found_flag.done = true
                    on_found(full)
                  end
                end, sem, queue)
              end
            end
          end
        end
        read_next()
      end)
    end
    read_next()
  end, 64)
end

-- Track in-progress scans per root so multiple buffer attaches don't
-- each launch their own independent full-tree scan.
---@type table<string, true>
local scanning = {}

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

    -- Skip if a scan for this root is already in flight
    if scanning[root] then return end
    scanning[root] = true

    local found_flag = { done = false }
    local sem = { n = MAX_INFLIGHT }
    local queue = {}

    scan_dir(root, function(path)
      scanning[root] = nil
      vim.schedule(function()
        client.settings = vim.tbl_deep_extend('force', client.settings or {}, {
          tailwindCSS = { experimental = { configFile = path } },
        })
        client:notify('workspace/didChangeConfiguration', { settings = client.settings })
      end)
    end, found_flag, sem, queue)
  end,
}

---
name: vim-pack
description: Use when working with Neovim's builtin plugin manager (vim.pack), including vim.pack.add(), vim.pack.update(), vim.pack.del(), vim.pack.get(), managing the lockfile, PackChanged events, or migrating from lazy.nvim/packer to vim.pack.
---

# vim.pack — Neovim Builtin Plugin Manager

> **Experimental but stable for daily use** (Nvim 0.12+)

## Overview

`vim.pack` is Neovim's built-in plugin manager. It manages plugins exclusively
in a dedicated directory:

```
$XDG_DATA_HOME/nvim/site/pack/core/opt/
```

- Uses `git` under the hood — requires `git` in `$PATH`
- Each plugin's subdirectory name matches its `name` in the spec
- Lockfile lives at `$XDG_CONFIG_HOME/nvim/nvim-pack-lock.json`
- All managed plugins are loaded as `opt` packages (via `:packadd`)

## Quick Start

```lua
-- init.lua
vim.pack.add({
  -- string shorthand (uses repo name as plugin name)
  'https://github.com/user/plugin1',

  -- table form — allows extra options
  { src = 'https://github.com/user/plugin1' },

  -- custom name
  { src = 'https://github.com/user/generic-name', name = 'myplugin' },

  -- semver version constraint (uses vim.version.range())
  { src = 'https://github.com/user/plugin3', version = vim.version.range('1.0') },

  -- pin to a branch, tag, or commit hash
  { src = 'https://github.com/user/plugin4', version = 'main' },
})

-- Plugin code is available immediately after add()
local p = require('plugin1')
```

Restart Nvim after adding new plugins. On first restart, missing plugins are
cloned from their `src` at the revision from the lockfile (if present) or
inferred from `version`.

## Spec Fields (`vim.pack.Spec`)

| Field | Type | Default | Description |
|---|---|---|---|
| `src` | `string` | required | Git-clonable URI |
| `name` | `string?` | repo name from `src` | Directory name / plugin identifier |
| `version` | `string\|vim.VersionRange\|nil` | `nil` | Branch/tag/commit or semver range. `nil` = default branch |
| `data` | `any?` | `nil` | Arbitrary user data attached to the spec |

## API

### `vim.pack.add(specs, opts?)`

Adds plugins to the current session. Installs if not on disk (parallel clone).
Already-present plugins are not re-checked for revision — run `update()` to sync.

```lua
vim.pack.add({ 'https://github.com/user/plugin' }, {
  load = false,    -- false = :packadd! (don't load yet); true = load immediately; or a function
  confirm = true,  -- ask before initial install (default true)
})
```

### `vim.pack.update(names?, opts?)`

Downloads updates and shows a **confirmation buffer** in a new tabpage.

- `:write` in the buffer to confirm all updates
- `:quit` to discard
- `[[` / `]]` to navigate plugin sections
- `gO` — document symbol overview
- `K` — hover details (changelog, newer tag)
- `gra` — code actions (delete, update, skip)

```lua
-- Update all plugins
vim.pack.update()

-- Update specific plugins
vim.pack.update({ 'plugin1', 'plugin2' })

-- Offline mode — no download, just compute diffs
vim.pack.update(nil, { offline = true })

-- Skip confirmation
vim.pack.update(nil, { force = true })

-- Update to lockfile revision (for reverting/controlled update)
vim.pack.update({ 'plugin1' }, { offline = true, target = 'lockfile' })
```

### `vim.pack.del(names, opts?)`

Removes plugins from disk. Plugins must first be removed from `vim.pack.add()`
calls in `init.lua` or they will be reinstalled on next restart.

```lua
vim.pack.del({ 'plugin1', 'plugin2' })
vim.pack.del({ 'plugin1' }, { force = true })  -- delete even if active
```

To find all non-active (orphaned) plugins to delete:

```lua
local orphans = vim.iter(vim.pack.get())
  :filter(function(x) return not x.active end)
  :map(function(x) return x.spec.name end)
  :totable()
vim.pack.del(orphans)
```

### `vim.pack.get(names?, opts?)`

Returns info about managed plugins.

```lua
-- All plugins
local all = vim.pack.get()

-- Specific plugins
local info = vim.pack.get({ 'plugin1' })

-- Without extra git info (faster)
local fast = vim.pack.get(nil, { info = false })
```

Return value fields per plugin:

| Field | Type | Description |
|---|---|---|
| `active` | `boolean` | Was added via `add()` this session |
| `path` | `string` | Full path on disk |
| `rev` | `string` | Current Git revision |
| `spec` | `vim.pack.SpecResolved` | Spec with `name` resolved |
| `branches` | `string[]?` | Available branches (omitted if `info=false`) |
| `tags` | `string[]?` | Available tags (omitted if `info=false`) |

## Events

| Event | When |
|---|---|
| `PackChangedPre` | Before changing a plugin's state |
| `PackChanged` | After a plugin's state has changed |

Event data (`ev.data`):

| Key | Description |
|---|---|
| `active` | Whether plugin was added via `add()` |
| `kind` | `"install"`, `"update"`, or `"delete"` |
| `spec` | Resolved plugin spec |
| `path` | Full path to plugin directory |

### Example: Post-install build hook

```lua
-- Must be registered BEFORE vim.pack.add() to fire on install
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'plugin-with-make' and (kind == 'install' or kind == 'update') then
      vim.system({ 'make' }, { cwd = ev.data.path })
    end
  end,
})

vim.pack.add({ 'https://github.com/user/plugin-with-make' })
```

## Common Workflows

### Shorter source URLs (git insteadOf)

```sh
git config --global url."https://github.com/".insteadOf "gh:"
git config --global url."https://codeberg.org/".insteadOf "cb:"
```

```lua
local gh = function(x) return 'https://github.com/' .. x end
vim.pack.add({ gh('user/plugin1'), gh('user/plugin2') })
-- or after git config: vim.pack.add({ 'gh:user/plugin1' })
```

### Freeze a plugin at current revision

Get the current rev from the lockfile (`rev` field, looks like `abc12345`),
then set it as the `version`:

```lua
{ src = 'https://github.com/user/plugin', version = 'abc12345' }
```

Restart for the lockfile to update.

### Revert after a bad update

```sh
# If lockfile is in git:
git checkout HEAD -- nvim-pack-lock.json
```

Then restart and run:

```lua
vim.pack.update({ 'plugin' }, { offline = true, target = 'lockfile' })
```

### Sync config across machines

1. Add `nvim-pack-lock.json` to version control
2. On a new machine: pull, restart Nvim (installs from lockfile), then:
   ```lua
   vim.pack.update(nil, { target = 'lockfile' })
   ```
3. Manually delete plugins present locally but not in the lockfile using
   `vim.pack.del()`.

### Switch version or source

1. Update spec in `init.lua` with new `version` and/or `src`
2. `:restart` — lockfile is updated but disk is not yet changed
3. `vim.pack.update({ 'plugin' })` (add `{ offline = true }` if only switching version)
4. Review and confirm

## Lockfile

- Path: `$XDG_CONFIG_HOME/nvim/nvim-pack-lock.json`
- Do not edit by hand
- Commit to version control for reproducible installs
- On first `vim.pack` call, lockfile is aligned with what's on disk

## Plugin Directory Structure

All managed plugins live at:
```
~/.local/share/nvim/site/pack/core/opt/<plugin-name>/
```

The `site` subdirectory of the Nvim data path must be in `'packpath'`
(it is by default, unless using `--clean` or overriding `$XDG_DATA_HOME`).

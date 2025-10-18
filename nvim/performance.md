
  Startuptime: 433.47ms

  Based on the actual CPU time of the Neovim process till UIEnter.
  This is more accurate than `nvim --startuptime`.
    LazyStart 18.72ms
    LazyDone  354.82ms (+336.1ms)
    UIEnter   433.47ms (+78.66ms)

  Profile

  You can press <C-s> to change sorting between chronological order & time taken.
  Press <C-f> to filter profiling entries that took more time than a given threshold

    ●  lazy.nvim 261.13ms
      ➜  module 21.56ms
      ➜  config 0.62ms
      ➜  spec 60.21ms
        ★  pkg 1.88ms
        ★  plugins.ai 3.21ms
        ★  plugins.autopairs 2.88ms
        ★  plugins.blink 3.24ms
        ★  plugins.catppuccin 3.19ms
        ★  plugins.comment 2.43ms
        ★  plugins.conform 2.72ms
        ★  plugins.cutlass 2.47ms
        ★  plugins.gitsigns 2.07ms
        ★  plugins.lazydev 2.35ms
        ★  plugins.lspconfig 2.4ms
        ★  plugins.markdown-preview 2.4ms
        ★  plugins.oil 2ms
        ★  plugins.persisted 2.17ms
        ★  plugins.sleuth 1.93ms
        ★  plugins.smart-splits 2.1ms
        ★  plugins.snacks 2.17ms
        ★  plugins.spectre 1.94ms
        ★  plugins.substitute 1.95ms
        ★  plugins.surround 1.97ms
        ★  plugins.telescope 2.25ms
        ★  plugins.todo-comments 2.13ms
        ★  plugins.treesitter 2.11ms
        ★  plugins.ts-comments 2.09ms
        ★  resolve plugins 0.56ms
      ➜  state 0.6ms
      ➜  install 0.01ms
      ➜  handlers 167.96ms
    ●  startup 1333.4ms
      ➜  runtime/filetype.lua 4.65ms
      ➜  init 21.72ms
        ★  init  markdown-preview.nvim 0ms
        ★  init  catppuccin 21.63ms
          ‒  catppuccin 0.15ms
      ➜  start 1254.5ms
        ★  start  gitsigns.nvim 18.5ms
          ‒  gitsigns.nvim/plugin/gitsigns.lua 17.06ms
        ★  start  nvim-web-devicons 2.88ms
          ‒  nvim-web-devicons/plugin/nvim-web-devicons.vim 2.42ms
        ★  start  nvim-lspconfig 900.06ms
          ‒  mason.nvim 88.31ms
          ‒  mason-lspconfig.nvim 0.35ms
          ‒  mason-tool-installer.nvim 21.53ms
            ●  mason-tool-installer.nvim/plugin/mason-tool-installer.lua 13.95ms
          ‒  fidget.nvim 110.04ms
          ‒  blink.cmp 346.41ms
            ●  LuaSnip 143.19ms
              ➜  LuaSnip/plugin/luasnip.lua 129.92ms
              ➜  LuaSnip/plugin/luasnip.vim 10ms
            ●  lazydev.nvim 14.04ms
            ●  blink.cmp/plugin/blink-cmp.lua 143.52ms
          ‒  nvim-lspconfig/plugin/lspconfig.lua 20.73ms
        ★  start  nvim-treesitter 152.08ms
          ‒  nvim-treesitter/plugin/nvim-treesitter.lua 132.68ms
        ★  start  smart-splits.nvim 98.65ms
          ‒  smart-splits.nvim/plugin/init.lua 13.65ms
          ‒  smart-splits.nvim/plugin/smart-splits.lua 83.3ms
        ★  start  plenary.nvim 5.34ms
          ‒  plenary.nvim/plugin/plenary.vim 3.44ms
        ★  start  vim-sleuth 16.74ms
          ‒  vim-sleuth/plugin/sleuth.vim 13.61ms
        ★  start  oil.nvim 18.97ms
        ★  start  cutlass.nvim 3.65ms
        ★  start  conform.nvim 9.91ms
          ‒  conform.nvim/plugin/conform.lua 6.02ms
        ★  start  todo-comments.nvim 4.3ms
          ‒  todo-comments.nvim/plugin/todo.vim 3.56ms
        ★  start  mini.ai 3.91ms
        ★  start  substitute.nvim 9.65ms
        ★  start  nvim-spectre 9.46ms
          ‒  nvim-spectre/plugin/spectre.lua 5.39ms
      ➜  rtp plugins 51.95ms
        ★  runtime/plugin/editorconfig.lua 3.58ms
        ★  runtime/plugin/gzip.vim 3.09ms
        ★  runtime/plugin/man.lua 5.57ms
        ★  runtime/plugin/matchit.vim 11.21ms
        ★  runtime/plugin/matchparen.vim 3.2ms
        ★  runtime/plugin/netrwPlugin.vim 1.72ms
        ★  runtime/plugin/osc52.lua 4.55ms
        ★  runtime/plugin/rplugin.vim 3.72ms
        ★  runtime/plugin/shada.vim 2.17ms
        ★  runtime/plugin/spellfile.vim 1.72ms
        ★  runtime/plugin/tarPlugin.vim 2.34ms
        ★  runtime/plugin/tohtml.lua 3.65ms
        ★  runtime/plugin/tutor.vim 2.24ms
        ★  runtime/plugin/zipPlugin.vim 2.61ms
      ➜  after 0.54ms
    ●  VimEnter 124.52ms
      ➜  telescope.nvim 124.47ms
        ★  telescope-fzf-native.nvim 1.53ms
        ★  telescope-ui-select.nvim 0.83ms
        ★  telescope.nvim/plugin/telescope.lua 6.51ms
    ●  startuptime 433.47ms
    ●  VeryLazy 41.57ms
      ➜  nvim-surround 9.17ms
      ➜  ts-comments.nvim 9.68ms

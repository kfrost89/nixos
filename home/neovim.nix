{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      # LSP servers
      astro-language-server
      typescript-language-server
      nodePackages.vscode-langservers-extracted  # html, css, json
      marksman                                    # markdown LSP
      nil                                         # nix LSP
    ];

    plugins = with pkgs.vimPlugins; [
      # file finder
      telescope-nvim
      plenary-nvim

      # syntax
      (nvim-treesitter.withPlugins (p: [
        p.nix
        p.lua
        p.javascript
        p.typescript
        p.astro
        p.html
        p.css
        p.json
        p.yaml
        p.markdown
        p.markdown_inline
        p.bash
        p.fish
      ]))

      # LSP
      nvim-lspconfig

      # autocomplete
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      luasnip
      cmp_luasnip

      # ui
      lualine-nvim
      which-key-nvim

      # markdown
      render-markdown-nvim

      # git
      gitsigns-nvim
      lazygit-nvim

      # file explorer
      oil-nvim
      nvim-web-devicons

      # editing
      comment-nvim
      nvim-autopairs

      # formatting
      conform-nvim
    ];

    extraLuaConfig = ''
      vim.g.mapleader = " "

      -- options
      vim.opt.number = true
      vim.opt.relativenumber = false
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.expandtab = true
      vim.opt.smartindent = true
      vim.opt.wrap = false
      vim.opt.ignorecase = true
      vim.opt.smartcase = true
      vim.opt.termguicolors = true
      vim.opt.signcolumn = "yes"
      vim.opt.clipboard = "unnamedplus"
      vim.opt.scrolloff = 8
      vim.opt.updatetime = 250

      vim.cmd.colorscheme("default")

      local map = vim.keymap.set

      -- general
      map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
      map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
      map("n", "<leader>e", "<cmd>Oil<CR>", { desc = "File explorer" })
      map("n", "<Esc>", "<cmd>noh<CR>", { silent = true, desc = "Clear search" })

      -- move lines
      map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
      map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

      -- centered scrolling
      map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
      map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })

      -- mdx filetype
      vim.filetype.add({ extension = { mdx = 'mdx' } })
      vim.treesitter.language.register('markdown', 'mdx')

      -- prose mode for markdown
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "markdown", "mdx" },
        callback = function()
          vim.opt_local.wrap = true
          vim.opt_local.linebreak = true
          vim.opt_local.conceallevel = 2
          vim.opt_local.textwidth = 80
          vim.opt_local.formatoptions:append('t')
        end,
      })

      -------------------------------------------
      -- plugins
      -------------------------------------------

      -- telescope
      require('telescope').setup{}
      map('n', '<leader>ff', require('telescope.builtin').find_files, { desc = "Find files" })
      map('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = "Live grep" })
      map('n', '<leader>fb', require('telescope.builtin').buffers, { desc = "Buffers" })

      -- lualine
      require('lualine').setup{}

      -- gitsigns
      require('gitsigns').setup{}

      -- comment
      require('Comment').setup{}

      -- which-key
      require('which-key').setup{}

      -- render-markdown
      require('render-markdown').setup{
        file_types = { 'markdown', 'mdx' },
      }

      -- autopairs
      require('nvim-autopairs').setup{}

      -- oil (only opens with Space e)
      require('oil').setup({
        default_file_explorer = false,
        keymaps = {
          ["q"] = "actions.close",
        },
      })

      -- lazygit
      map('n', '<leader>gg', '<cmd>LazyGit<CR>', { silent = true, desc = "LazyGit" })

      -- conform (formatting)
      require('conform').setup({
        formatters_by_ft = {
          javascript = { 'prettier' },
          typescript = { 'prettier' },
          html = { 'prettier' },
          css = { 'prettier' },
          json = { 'prettier' },
          yaml = { 'prettier' },
          markdown = { 'prettier' },
          mdx = { 'prettier' },
          astro = { 'prettier' },
        },
        format_on_save = {
          timeout_ms = 2000,
          lsp_format = 'fallback',
        },
      })
      map('n', '<leader>cf', function() require('conform').format({ lsp_format = 'fallback' }) end, { desc = "Format file" })

      -- LSP
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local servers = { 'astro', 'ts_ls', 'html', 'cssls', 'jsonls', 'marksman', 'nil_ls' }
      for _, server in ipairs(servers) do
        vim.lsp.config(server, { capabilities = capabilities })
      end
      vim.lsp.enable(servers)

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local function opts(desc) return { buffer = args.buf, desc = desc } end
          map('n', 'gd', vim.lsp.buf.definition, opts("Go to definition"))
          map('n', 'gr', vim.lsp.buf.references, opts("Find references"))
          map('n', 'K', vim.lsp.buf.hover, opts("Hover docs"))
          map('n', '<leader>rn', vim.lsp.buf.rename, opts("Rename symbol"))
          map('n', '<leader>ca', vim.lsp.buf.code_action, opts("Code action"))
          map('n', '<leader>d', vim.diagnostic.open_float, opts("Diagnostics"))
        end,
      })

      -- autocomplete
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      cmp.setup({
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        }),
      })
    '';
  };
}

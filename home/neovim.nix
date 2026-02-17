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

    extraLuaConfig = ''
      vim.g.mapleader = " "

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

      -- keymaps
      vim.keymap.set("n", "<leader>w", ":w<CR>")
      vim.keymap.set("n", "<leader>q", ":q<CR>")
      vim.keymap.set("n", "<leader>e", ":Oil<CR>")
      vim.keymap.set("n", "<Esc>", ":noh<CR>")

      -- move lines
      vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
      vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

      vim.cmd.colorscheme("default")

      -- keep cursor centered
      vim.keymap.set("n", "<C-d>", "<C-d>zz")
      vim.keymap.set("n", "<C-u>", "<C-u>zz")

      -- register mdx as a filetype
      vim.filetype.add({ extension = { mdx = 'mdx' } })

      -- soft wrap for markdown
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "markdown", "mdx" },
        callback = function()
          vim.opt_local.wrap = true
          vim.opt_local.linebreak = true
          vim.opt_local.conceallevel = 2
        end,
      })
    '';

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
      indent-blankline-nvim
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

    extraConfig = ''
      lua << EOF
      require('telescope').setup{}
      require('lualine').setup{}
      require('gitsigns').setup{}
      require('Comment').setup{}
      require('ibl').setup{}
      require('render-markdown').setup{
        file_types = { 'markdown', 'mdx' },
      }
      require('nvim-autopairs').setup{}
      require('oil').setup()
      require('which-key').setup{}

      -- lazygit
      vim.keymap.set('n', '<leader>gg', ':LazyGit<CR>', { silent = true })

      -- format
      vim.keymap.set('n', '<leader>cf', function() require('conform').format({ lsp_format = 'fallback' }) end, { desc = 'Format file' })

      require('conform').setup({
        formatters_by_ft = {
          javascript = { 'prettier' },
          typescript = { 'prettier' },
          html = { 'prettier' },
          css = { 'prettier' },
          json = { 'prettier' },
          yaml = { 'prettier' },
          markdown = { 'prettier' },
          astro = { 'prettier' },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_format = 'fallback',
        },
      })

      -- telescope keymaps
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files)
      vim.keymap.set('n', '<leader>fg', builtin.live_grep)
      vim.keymap.set('n', '<leader>fb', builtin.buffers)

      -- LSP setup
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local servers = { 'astro', 'ts_ls', 'html', 'cssls', 'jsonls', 'marksman', 'nil_ls' }
      for _, server in ipairs(servers) do
        vim.lsp.config(server, { capabilities = capabilities })
      end
      vim.lsp.enable(servers)

      -- LSP keymaps
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local opts = { buffer = args.buf }
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
        end,
      })

      -- Autocomplete
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
      EOF
    '';
  };
}

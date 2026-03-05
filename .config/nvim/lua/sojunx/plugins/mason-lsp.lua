local on_attach = function(_, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
end

return {
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        "lua_ls",
        "vtsls",
        "tailwindcss",
        "html",
        "cssls",
        "gopls",
        "jdtls",
        "pyright",
        "jsonls",
        "yamlls",
        "marksman",
        "bashls",
        "lemminx",
        "dockerls",
        "docker_compose_language_service",
        "nil_ls",
      },
    },
    config = function(_, opts)
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      require("mason-lspconfig").setup(opts)

      for _, server in ipairs(opts.ensure_installed) do
        vim.lsp.config(server, {
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "stylua",
        "prettier",
        "eslint",
        "stylelint",
        "golangci-lint",
        "goimports",
        "google-java-format",
        "checkstyle",
        "ruff",
        "yamllint",
        "jsonlint",
        "shellcheck",
        "nixpkgs-fmt",
        -- "xmlformatter",
      },
    },
  },
}

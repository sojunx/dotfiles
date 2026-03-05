return {
  "stevearc/conform.nvim",
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        lua = { "stylua" },
        xml = { "lemminx" },
        nix = { "nixpkgs-fmt" },
      },

      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 300,
      },
    })

    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function(args)
        require("conform").format({ bufnr = args.buf })
      end,
    })

    vim.keymap.set("n", "<leader>fm", function()
      conform.format({ async = true, lsp_fallback = true })
    end, { desc = "Format code" })
  end,
}

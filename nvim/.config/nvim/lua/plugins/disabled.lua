return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>gh", hidden = true },
      },
    },
  },
  {
    "pwntester/octo.nvim",
    opts = {
      default_to_projects_v2 = false,
      suppress_missing_scope = { projects_v2 = true },
    },
    keys = {
      { "<leader>gP", false },
      { "<leader>gI", false },
      { "<leader>gS", false },
      { "<leader>gr", false },
    },
  },
  {
    "windwp/nvim-ts-autotag",
    enabled = false,
  },
  {
    "folke/persistence.nvim",
    enabled = false,
  },
  {
    "folke/trouble.nvim",
    enabled = false
  },
  {
    "catppuccin/nvim",
    enabled = false,
  },
  {
    "folke/tokyonight.nvim",
    enabled = false,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = false,
      },
    },
  },
}

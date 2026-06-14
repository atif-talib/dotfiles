return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>o", group = "obsidian", icon = { icon = "󰂺", color = "green" } },
      },
    },
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      workspaces = {
        {
          name = "mp-noon-catalog-api",
          path = vim.fn.expand("~/Library/Mobile Documents/iCloud~md~obsidian/Documents/mp-noon-catalog-api"),
        },
        {
          name = "Infrastructure",
          path = vim.fn.expand("~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Infrastructure.md"),
        },
      },
      ui = { enable = false },
    },
    keys = {
      { "<leader>on", "<cmd>ObsidianNew<cr>", desc = "New note" },
      { "<leader>oo", "<cmd>ObsidianOpen<cr>", desc = "Open in app" },
      { "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "Search notes" },
      { "<leader>oq", "<cmd>ObsidianQuickSwitch<cr>", desc = "Quick switch" },
      { "<leader>od", "<cmd>ObsidianToday<cr>", desc = "Daily note" },
      { "<leader>oy", "<cmd>ObsidianYesterday<cr>", desc = "Yesterday" },
      { "<leader>ob", "<cmd>ObsidianBacklinks<cr>", desc = "Backlinks" },
      { "<leader>ol", "<cmd>ObsidianLinks<cr>", desc = "Links" },
      { "<leader>ot", "<cmd>ObsidianTags<cr>", desc = "Tags" },
      { "<leader>op", "<cmd>ObsidianPasteImg<cr>", desc = "Paste image" },
    },
  },
}

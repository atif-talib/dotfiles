return {
  {
    "gitsigns.nvim",
    opts = {
      signcolumn = true,
      watch_gitdir = { interval = 1000, follow_files = true },
      attach_to_untracked = true,
      current_line_blame = false,
      update_debounce = 100,
      preview_config = { border = "rounded", style = "minimal", relative = "cursor", row = 0, col = 1 },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = buffer, desc = desc, silent = true })
        end
        map("n", "]h", function() gs.nav_hunk("next") end, "Next Hunk")
        map("n", "[h", function() gs.nav_hunk("prev") end, "Prev Hunk")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select Hunk")
      end,
    },
    config = function(_, opts)
      require("gitsigns").setup(opts)
      local gs = require("gitsigns")

      Snacks.toggle({
        name = "Git Blame",
        get = function()
          local cfg = require("gitsigns.config").config
          return cfg and cfg.current_line_blame or false
        end,
        set = function(state) gs.toggle_current_line_blame(state) end,
      }):map("<leader>uB")

      vim.keymap.set("n", "<leader>ga", gs.stage_hunk, { desc = "Accept hunk (stage)" })
      vim.keymap.set("n", "<leader>gA", gs.stage_buffer, { desc = "Accept all hunks" })
      vim.keymap.set("n", "<leader>gx", gs.reset_hunk, { desc = "Reject hunk (reset)" })
      vim.keymap.set("n", "<leader>gX", gs.reset_buffer, { desc = "Reject all hunks" })
      vim.keymap.set("n", "<leader>gP", gs.preview_hunk, { desc = "Preview hunk" })
      vim.keymap.set("n", "<leader>gu", function() gs.stage_hunk() end, { desc = "Undo stage hunk (toggle)" })

      local function visual_range()
        local s = vim.fn.getpos("v")[2]
        local e = vim.fn.getpos(".")[2]
        if s > e then s, e = e, s end
        return { s, e }
      end

      vim.keymap.set("v", "<leader>ga", function()
        gs.stage_hunk(visual_range())
      end, { desc = "Accept selection" })
      vim.keymap.set("v", "<leader>gx", function()
        gs.reset_hunk(visual_range())
      end, { desc = "Reject selection" })
    end,
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory", "DiffviewToggleFiles", "DiffviewRefresh" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Review all changes (diffview)" },
      { "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "File history (diffview)" },
      { "<leader>gm", "<cmd>DiffviewOpen origin/main...HEAD<cr>", desc = "Review vs origin/main" },
    },
    opts = {
      enhanced_diff_hl = true,
      view = {
        default = { winbar_info = true },
        merge_tool = { layout = "diff3_mixed", disable_diagnostics = true },
      },
      file_panel = { listing_style = "tree", win_config = { position = "left", width = 32 } },
      keymaps = {
        view = {
          { "n", "<tab>",   "<cmd>DiffviewToggleFiles<cr>", { desc = "Toggle file panel" } },
          { "n", "q",       "<cmd>DiffviewClose<cr>",       { desc = "Close diffview" } },
        },
        file_panel = {
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
        },
      },
    },
  },
  {
    'tpope/vim-fugitive',
    dependencies = { 'tpope/vim-rhubarb' },
    cmd = { 'Git', 'G', 'GBrowse' },
    keys = {
      { '<leader>gv', function()
          local s = vim.fn.getpos("v")[2]
          local e = vim.fn.getpos(".")[2]
          if s > e then s, e = e, s end
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "x", false)
          vim.cmd(string.format("Git log -L%d,%d:%%", s, e))
        end, desc = 'Git selection history', mode = 'v' },
    },
    config = function()
      vim.api.nvim_create_autocmd('BufReadPost', {
        group = vim.api.nvim_create_augroup('FugitiveSettings', { clear = true }),
        pattern = 'fugitive://*',
        callback = function()
          vim.opt_local.bufhidden = 'delete'
          vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = true })
        end,
      })
    end,
  }
}

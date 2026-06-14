return {
  "okuuva/auto-save.nvim",
  event = "VeryLazy",
  opts = {
    trigger_events = {
      immediate_save = { "BufLeave", "FocusLost", "QuitPre", "VimSuspend" },
      defer_save = { "InsertLeave", "TextChanged" },
      cancel_deferred_save = { "InsertEnter" },
    },
  },
}

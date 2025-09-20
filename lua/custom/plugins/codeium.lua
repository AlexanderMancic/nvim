return {
  "Exafunction/codeium.nvim",
  cmd = "Codeium",
  event = "InsertEnter",
  build = ":Codeium Auth",
  opts = {
    enable_cmp_source = vim.g.ai_cmp,
    virtual_text = {
      enabled = not vim.g.ai_cmp,
      key_bindings = {
        accept = false, -- handled by nvim-cmp / blink.cmp
        next = "<M-]>",
        prev = "<M-[>",
      },
    },
  },

  {
    "Exafunction/codeium.nvim",
    opts = function()
      -- Define your own accept action (Kickstart version)
      local function ai_accept()
        local vt = require("codeium.virtual_text")
        if vt.get_current_completion_item() then
          -- create undo point
          vim.cmd("undojoin") -- safe alternative to LazyVim.create_undo()
          vim.api.nvim_input(vt.accept())
          return true
        end
      end

    end, -- opts = function()
  },

}
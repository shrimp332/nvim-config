return {
  "github/copilot.vim",
  init = function()
    vim.g.copilot_enabled = 0

    local toggle = function()
      if vim.g.copilot_enabled == 0 then
        vim.g.copilot_enabled = 1
      else
        vim.g.copilot_enabled = 0
      end
    end

    vim.keymap.set("n", "<leader>cp", toggle, { desc = "Toggle Copilot" })
  end
}

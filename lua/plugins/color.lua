return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    style = "night",
    transparent = true,
  },
  init = function()
    vim.cmd.colorscheme("tokyonight")
  end
}

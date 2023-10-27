return {
  "kylechui/nvim-surround",
  enabled = true,
  event = "VeryLazy",
  vscode = true,
  config = function()
    require("nvim-surround").setup(
      -- Configuration here, or leave empty to use defaults
      -- keymaps = {
      --   insert = "<C-g>s",
      --   insert_line = "<C-g>S",
      --   normal = "ys",
      --   normal_cur = "yss",
      --   normal_line = "gsa",
      --   normal_cur_line = "ySS",
      --   visual = "S",
      --   visual_line = "gS",
      --   delete = "gsd",
      --   change = "gsr",
      -- },
    )
  end,
}

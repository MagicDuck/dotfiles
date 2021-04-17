require("bqf").setup {
  auto_enable = true,
  magic_window = false, -- this creates issues when it's on and you have multiple splits
  preview = {
    win_height = 12,
    win_vheight = 12,
    delay_syntax = 80,
    border_chars = {"┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█"}
  },
  func_map = {
    vsplit = "",
    ptogglemode = "z,",
    stoggleup = ""
  },
  filter = {
    fzf = {
      extra_opts = {"--bind", "ctrl-o:toggle-all", "--prompt", "> "}
    }
  }
}

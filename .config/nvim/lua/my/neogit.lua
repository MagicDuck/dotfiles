local neogit = require("neogit")
neogit.setup({
  disable_commit_confirmation = false, -- might want to set this to true
  integrations = {
    diffview = true
  },
  mappings = {
    status = {
      ["q"] = "Close",
      ["1"] = "Depth1",
      ["2"] = "Depth2",
      ["3"] = "Depth3",
      ["4"] = "Depth4",
      ["o"] = "Toggle",
      ["x"] = "Discard",
      ["s"] = "",
      ["S"] = "",
      ["a"] = "Stage",
      ["A"] = "StageUnstaged",
      ["<c-s>"] = "StageAll",
      ["u"] = "Unstage",
      ["U"] = "UnstageStaged",
      ["d"] = "DiffAtFile",
      ["$"] = "CommandHistory",
      ["#"] = "Console",
      ["<c-r>"] = "RefreshBuffer",
      ["<enter>"] = "GoToFile",
      ["<c-v>"] = "VSplitOpen",
      ["<c-x>"] = "SplitOpen",
      ["<c-t>"] = "TabOpen",
      ["?"] = "HelpPopup",
      ["D"] = "DiffPopup",
      ["P"] = "PullPopup",
      ["r"] = "RebasePopup",
      ["p"] = "PushPopup",
      ["c"] = "CommitPopup",
      ["L"] = "LogPopup",
      ["t"] = "StashPopup",
      ["b"] = "BranchPopup",
    }
  }
})

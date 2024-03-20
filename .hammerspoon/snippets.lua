local M = {}
local chooser

local function onChooserComplete(option)
  hs.fnutils.each(option.keys, function(key)
    if type(key) == "table" then
      hs.eventtap.keyStroke(key.mods or {}, key.char)
    else
      hs.eventtap.keyStrokes(key)
    end
  end)
end

function M.init(items)
  local choices = hs.fnutils.map(items, function(item)
    return { text = item.description, subText = item.example or hs.inspect(item.keys), keys = item.keys }
  end)
  chooser = hs.chooser.new(onChooserComplete)
  chooser:choices(choices)
end

function M.show()
  chooser:show()
end

return M

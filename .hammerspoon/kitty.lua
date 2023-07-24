local M = {}

--------------------------------------------------------------------------------
-- kitty term interaction
--------------------------------------------------------------------------------

local function str_split_space(str)
  local parts = {}
  for i in string.gmatch(str, "%S+") do
    print(i)
    table.insert(parts, i)
  end

  return parts
end

function M.exec(cmd, cb)
  local task = hs.task.new(
    "/Applications/kitty.app/Contents/MacOS/kitty",
    -- "/usr/local/bin/kitty",
    cb,
    str_split_space("@ --to unix:/tmp/mykitty " .. cmd)
  )
  task:start()
end

function M.launchWindow(window)
  M.exec(
    "launch --type=os-window --os-window-title="
    .. window.title
    .. " --title="
    .. window.title
    .. " "
    .. window.command,
    function(exitCode)
      if exitCode ~= 0 then
        print("Could not launch kitty window: " .. window.title .. " with command: " .. window.command)
        return
      end
    end
  )
end

return M

-- old code just in case:
-- local function switchToKittyWindow(windowTitle, windowCommand, initializeWinFn)
-- 	local win = hs.window.frontmostWindow()
-- 	if win:title() == windowTitle then
-- 		-- window already focused, focus prev in stack
-- 		local orderedWindows = hs.window.orderedWindows()
-- 		if orderedWindows[2] then
-- 			orderedWindows[2]:focus()
-- 		end
-- 		return
-- 	end
--
-- 	local function launchWindow()
-- 		kittyDo(
-- 			"launch --type=os-window --os-window-title="
-- 				.. windowTitle
-- 				.. " --title="
-- 				.. windowTitle
-- 				.. " "
-- 				.. windowCommand,
-- 			function(exitCode)
-- 				if exitCode ~= 0 then
-- 					print("Could not launch kitty window: " .. windowTitle .. " with command: " .. windowCommand)
-- 					return
-- 				end
-- 				if initializeWinFn ~= nil then
-- 					local newWin = hs.window.frontmostWindow()
-- 					initializeWinFn(newWin)
-- 				end
-- 			end
-- 		)
-- 	end
--
-- 	local app = hs.application.get("kitty")
-- 	if app == nil then
-- 		hs.application.open("kitty")
-- 	end
--
-- 	kittyDo("focus-window --match=title:" .. windowTitle, function(exitCode, stdout, stderr)
-- 		print("cmd", "focus-window --match=title:" .. windowTitle)
-- 		if exitCode ~= 0 then
-- 			-- not found, try launching
-- 			launchWindow()
-- 		end
-- 	end)
-- end

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import XMonad.Hooks.EwmhDesktops (ewmh, fullscreenEventHook)
import XMonad.Layout.Spacing
import XMonad.Hooks.SetWMName
import XMonad.Util.SpawnOnce
import qualified XMonad.Layout.Fullscreen as FS
import qualified Data.Map as M
import Data.List
import XMonad.Config.Desktop
import Graphics.X11.ExtraTypes.XF86
import XMonad.Actions.CycleWS
import XMonad.Layout.ResizableTile
import Data.List (sortBy)
import Data.Function (on)
import Control.Monad (forM_, join)
import XMonad.Util.Run (safeSpawn)
import XMonad.Util.NamedWindows (getName)
import qualified XMonad.StackSet as W
import XMonad.Hooks.InsertPosition
import XMonad.Layout.SimpleDecoration
import XMonad.Layout.NoFrillsDecoration
import XMonad.Util.Themes
import XMonad.Util.NamedScratchpad

-- useful to copy from: https://github.com/ruhatch/.dotfiles/blob/master/.xmonad/xmonad.hs
-- https://github.com/jonhoo/configs/blob/14e0e155d28c83504e28f3c5bf0f9fc939b12a1e/xmonad/xmonad.hs#L154L157
-- https://gist.github.com/gilbertw1/2fa89193d3bd83cec5378dc9dd481c30
-- https://gist.github.com/master-q/1136051/bc1b7d9721b7e0a6e6132f4c07a48e524e7bf6db

------------------------------------------------------------------------
-- general

myModMask = mod4Mask   -- super
myWorkspaces = ["web","a","b","c","d","e","f"]
myTerminal = "kitty"
myScreenLocker = "betterlockscreen -l dim"
myFont = "xft:NotoSans-Regular:size=10"

color_bg = "#efefef"
color_fg = "#252525"
color_activebg = "#546e7a"
color_activefg = "#f5f5f5"
color_urgent = "#e53935"

windowBarTheme = def
    { fontName              = myFont
    , inactiveBorderColor   = color_bg
    , inactiveColor         = color_bg
    , inactiveTextColor     = color_fg
    , activeBorderColor     = color_activebg
    , activeColor           = color_activebg
    , activeTextColor       = color_activefg
    , urgentBorderColor     = color_urgent
    , urgentTextColor       = color_urgent
    , decoHeight            = 25
    }
-- baseWindowTheme = robertTheme
-- windowBarTheme = (theme baseWindowTheme)
--     { fontName   = myFont
--     , decoHeight = 23
--     , activeColor = "#546e7a"
--     , activeTextColor = "#252525"
--     , inactiveColor = "#ddeeeeee"
--     , inactiveTextColor = "#f5f5f5"
--     }

------------------------------------------------------------------------
-- scratchpads

scratchpads = [
    NS "terminal" "kitty --class scratchpad" (className =? "scratchpad")
        (customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3))
    ]

------------------------------------------------------------------------
-- keybindings
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((0, xK_Print), (spawn "flameshot gui"))
    , ((controlMask, xK_Return), (namedScratchpadAction scratchpads "terminal"))
    , ((mod1Mask, xK_Return), (spawn myTerminal))
    , ((mod1Mask, xK_space), (spawn "rofi -combi-modi window,drun,run -show combi -modi combi"))
    , ((modm .|. controlMask, xK_l), (spawn myScreenLocker))

    , ((controlMask .|. modm, xK_k), nextWS)
    , ((controlMask .|. modm, xK_j), prevWS)
    , ((controlMask .|. modm .|. shiftMask, xK_k), shiftToNext >> nextWS)
    , ((controlMask .|. modm .|. shiftMask, xK_j), shiftToPrev >> prevWS)

    -- expand resizable tall current window
    , ((modm, xK_u),  sendMessage MirrorExpand)

    -- shrink resizble tall current window
    , ((modm, xK_i),  sendMessage MirrorShrink)

    -- rotate through available layouts
    , ((modm, xK_r),  sendMessage NextLayout)
    ]

------------------------------------------------------------------------
-- layouts

myLayout =
  -- adds window titles
  noFrillsDeco shrinkText windowBarTheme -- adds window titles
  -- adds spaces around windows
  $ (spacingRaw True (Border 0 5 5 5) True (Border 5 5 5 5) True)
  -- the layouts
  $ tiled ||| (Mirror tiled) ||| Full
  where
     -- default tiling algorithm partitions the screen into two panes
     -- tiled   = Tall nmaster delta ratio
     tiled   = ResizableTall nmaster delta ratio []

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = toRational (2 / (1 + sqrt 5 :: Double))

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100


------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = insertPosition End Newer <+> composeAll
    [ className =? "Gimp"           --> doFloat
    , className =? "xfreerdp"       --> doFullFloat
    , resource  =? "desktop_window" --> doIgnore
    , fmap (isInfixOf "display") appCommand --> doFloat
    , fmap (isInfixOf "feh") appCommand --> doFloat
    --, (className =? "" <&&> title =? "") --> doShift "sfx" -- Spotify: https://bbs.archlinux.org/viewtopic.php?id=204636
    , (stringProperty "WM_WINDOW_ROLE" =? "GtkFileChooserDialog") --> doFullFloat
    , isFullscreen                  --> doFullFloat
    , FS.fullscreenManageHook
    ]
    where
    appCommand = stringProperty "WM_COMMAND"


------------------------------------------------------------------------
-- status bar - logging stuff to be read by it

myLogHook = do
  winset <- gets windowset
  title <- maybe (return "") (fmap show . getName) . W.peek $ winset
  let currWs = W.currentTag winset
  let wss = map W.tag $ W.workspaces winset
  let wsStr = join $ map (fmt currWs) $ sort' wss

  io $ appendFile "/tmp/.xmonad-title-log" (title ++ "\n")
  io $ appendFile "/tmp/.xmonad-workspace-log" (wsStr ++ "\n")

  where fmt currWs ws
          | currWs == ws = "[" ++ ws ++ "]"
          | otherwise    = " " ++ ws ++ " "
        sort' = sortBy (compare `on` (!! 0))

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

myStartupHook = do
    setWMName "LG3D"
    spawnOnce "/usr/bin/xmodmap ~/.Xmodmap" -- map Home to Esc
    spawnOnce "feh --bg-scale ~/Pictures/goats_in_space.jpg"
    spawnOnce "dunst" -- notification server
    spawnOnce "nm-applet" -- network monitor applet
    spawnOnce "redshift-gtk" -- brightness manager
    spawnOnce "dropbox"
    -- TODO: do we need to send this info anymore, we don't use it in polybar?
    forM_ [".xmonad-workspace-log", ".xmonad-title-log"] $ \file -> do safeSpawn "mkfifo" ["/tmp/" ++ file]
    spawnOnce "polybar -r main -c ~/.config/polybar/config.ini"
    spawnOnce "compton -b"
    spawnOnce "google-chrome-stable"
    spawnOnce ("xautolock -time 5 -locker \"" ++ myScreenLocker ++ "\"")

main = xmonad $ ewmh desktopConfig
    { borderWidth        = 2
    , normalBorderColor  = "#cccccc"
    , focusedBorderColor = "#cd8b00"
    , terminal           = myTerminal
    , modMask            = myModMask
    , workspaces         = myWorkspaces
    , keys               = \c -> myKeys c `M.union` keys XMonad.def c
    , layoutHook         = desktopLayoutModifiers $ myLayout
    , manageHook         = myManageHook
        <+> namedScratchpadManageHook scratchpads
        <+> manageHook desktopConfig
    , handleEventHook    = fullscreenEventHook <+> handleEventHook desktopConfig
    , startupHook        = myStartupHook <+> startupHook desktopConfig
    , logHook            = myLogHook
    }

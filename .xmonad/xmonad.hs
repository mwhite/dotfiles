import XMonad
import XMonad.Config.Gnome

import XMonad.Layout.Spacing
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.SimplestFloat
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.PerWorkspace

import XMonad.Hooks.ManageDocks

import XMonad.Actions.CycleWindows

import XMonad.Util.EZConfig

myTerminal = "gnome-terminal"

myLayoutHook = smartBorders $ avoidStruts $ 
        onWorkspaces ["web","music"] (highSpacing (toggleFull oneTall)) $
        onWorkspace "chat" (highSpacing oneTall) $
        onWorkspace "term" (lowSpacing goldenTall) $
        onWorkspace "term2" (lowSpacing goldenTall) $
        onWorkspace "float" simplestFloat $
        highSpacing goldenTall
        where
                defaultHook = layoutHook defaultConfig
                toggleFull = toggleLayouts Full
                lowSpacing = spacing 5
                highSpacing = spacing 15
                goldenTall = ResizableTall 1 delta (toRational (2/(1 + sqrt 5 :: Double))) []
                oneTall = ResizableTall 1 delta (toRational (4/5)) []
                twoTall = ResizableTall 1 delta (toRational 1/2) []
                delta = 5/100
                ratio = toRational (2/(1 + sqrt 5 :: Double))

myWorkspaces = [ "web"
               , "term"
               , "term2"
               , "chat"
               , "music"
               , "float"
               ]


myManageHook = composeAll       [ resource =? "vim" --> doShift "term"
                                , resource =? "term" --> doShift "term"
                                , resource =? "skype" --> doShift "chat"
                                , resource =? "pidgin" --> doShift "chat"
                                , resource =? "chromium" --> doShift "web"
                                , resource =? "pms" --> doShift "music"
                                , resource =? "ario" --> doShift "music"
                                , resource =? "sonata" --> doShift "music"
                                , resource =? "spotify" --> doShift "music"
                                , manageDocks
                                ] <+> manageHook defaultConfig

main = do
        xmonad $ gnomeConfig
                { terminal = myTerminal
                , workspaces = myWorkspaces
                , layoutHook = myLayoutHook
                , manageHook = myManageHook
                {-, modMask = mod4Mask-}
                }
                 `additionalKeys`
                [ ((mod1Mask, xK_Tab), cycleRecentWindows [xK_Alt_L] xK_Tab (xK_Tab .|. xK_Shift_L))
                , ((mod1Mask .|. shiftMask, xK_l), sendMessage ToggleLayout)
                ]

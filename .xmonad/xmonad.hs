import XMonad
import XMonad.Config.Gnome

import XMonad.Layout.Spacing
import XMonad.Layout.Fullscreen
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.SimplestFloat
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.PerWorkspace

import XMonad.Hooks.ManageDocks

import XMonad.Actions.CycleWS
import XMonad.Actions.CycleWindows

import XMonad.Util.EZConfig

myTerminal = "gnome-terminal"

myLayoutHook = smartBorders $ avoidStruts $ 
        onWorkspaces ["web","music"] (highSpacing (toggleFull oneTall)) $
        onWorkspace "chat" (highSpacing oneTall) $
        onWorkspace "term" (lowSpacing (toggleFull goldenTall)) $
        highSpacing goldenTall
        where
                toggleFull = toggleLayouts Full {-fullscreenFull-}
                lowSpacing = spacing 5
                highSpacing = spacing 15
                goldenTall = ResizableTall 1 delta (toRational (2/(1 + sqrt 5 :: Double))) []
                oneTall = ResizableTall 1 delta (toRational (4/5)) []
                twoTall = ResizableTall 1 delta (toRational 1/2) []
                delta = 5/100
                ratio = toRational (2/(1 + sqrt 5 :: Double))

myWorkspaces = [ "web"
               , "term"
               , "chat"
               , "music"
               ]


myManageHook = composeAll       [ resource =? "skype" --> doShift "chat"
                                , resource =? "pidgin" --> doShift "chat"
                                , resource =? "ario" --> doShift "music"
                                , resource =? "sonata" --> doShift "music"
                                , resource =? "spotify" --> doShift "music"
                                , manageDocks
                                {-, fullscreenManageHook-}
                                ] <+> manageHook defaultConfig

main = do
        xmonad $ gnomeConfig
                { terminal = myTerminal
                , workspaces = myWorkspaces
                , layoutHook = myLayoutHook
                , manageHook = myManageHook
                {-, handleEventHook = XMonad.Hooks.EwmhDesktops.fullscreenEventHook <+>-}
                        {-XMonad.Layout.Fullscreen.fullscreenEventHook <+> handleEventHook gnomeConfig-}
                , modMask = mod4Mask
                }
                 `additionalKeys`
                [ ((mod4Mask, xK_Tab), cycleRecentWindows [xK_Alt_L] xK_Tab (xK_Tab .|. xK_Shift_L))
                , ((mod4Mask .|. shiftMask, xK_l), sendMessage ToggleLayout)
                , ((mod4Mask, xK_q), prevScreen)
                , ((mod4Mask, xK_w), nextScreen)
                {-, ((mod4Mask, xK_e), swapNextScreen)-}
                {-, ((mod4Mask .|. shiftMask, xK_q), shiftPrevScreen)-}
                , ((mod4Mask .|. shiftMask, xK_w), shiftNextScreen)
                , ((mod4Mask .|. shiftMask, xK_q), nextScreen >> shiftNextScreen)
                ]

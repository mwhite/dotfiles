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
        onWorkspaces ["1:web","5:music"] (highSpacing (toggleFull oneTall)) $
        onWorkspaces ["3:skype","4:chat"] (highSpacing oneTall) $
        onWorkspace "2:term" (lowSpacing (toggleFull goldenTall)) $
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

myWorkspaces = [ "1:web"
               , "2:term"
               , "3:skype"
               , "4:chat"
               , "5:music"
               ]


myManageHook = composeAll       [ resource =? "skype" --> doShift "3:skype"
                                , className =? "Pidgin" --> doShift "4:chat"
                                , resource =? "ario" --> doShift "5:music"
                                , resource =? "sonata" --> doShift "5:music"
                                , resource =? "spotify" --> doShift "5:music"
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

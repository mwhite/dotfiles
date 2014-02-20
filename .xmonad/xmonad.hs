import XMonad
import XMonad.Config.Gnome

import XMonad.Layout.Accordion
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
{-import XMonad.Layout.SimplestFloat-}
import XMonad.Layout.Tabbed
import XMonad.Layout.ToggleLayouts
{-import XMonad.Layout.PerWorkspace-}
import XMonad.Layout.WindowNavigation

import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers

import XMonad.Actions.GridSelect
import XMonad.Actions.CycleRecentWS
import XMonad.Actions.CycleWindows

import XMonad.Util.EZConfig

import qualified XMonad.StackSet as W

import XMonad.Prompt
import XMonad.Prompt.AppendFile
import XMonad.Prompt.Man
import XMonad.Prompt.Shell
import XMonad.Prompt.Window
import XMonad.Prompt.Workspace
import XMonad.Prompt.XMonad

myTerminal = "gnome-terminal"

myLayoutHook = smartBorders $ avoidStruts $ toggle $ windowNavigation $ tiled
        ||| Mirror tiled
        ||| Accordion
        ||| tabbed shrinkText defaultTheme
        where
                toggle = toggleLayouts (noBorders Full)
                highSpacing = spacing 15
                tiled = highSpacing $ ResizableTall 1 delta (toRational 1/2) []
                delta = 5/100

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
                                , isFullscreen --> doFullFloat
                                ] <+> manageHook gnomeConfig

myXPConfig = greenXPConfig 
        { font = "xft:Lucida Grande:pixelsize=24:autohint=true"
        , position = Top
        , height = 24
        , fgColor = "#E5DFD9"
        , bgColor = "#292929"
        }

main = do
        xmonad $ gnomeConfig
                { terminal = myTerminal
                , workspaces = myWorkspaces
                , layoutHook = myLayoutHook
                , manageHook = myManageHook
                , modMask = mod4Mask
                , borderWidth = 2
                , focusedBorderColor = "black"
                , normalBorderColor = "gray"
                }
                 `additionalKeysP`
                [ 
                {-("M1-<Tab>", cycleRecentWindows [xK_Alt_L] xK_Tab xK_Tab )-}
                  ("M-S-l", sendMessage ToggleLayout)
                {-, ("M-q", prevScreen)-}
                {-, ("M-w", nextScreen)-}
                {-, ((mod4Mask, xK_e), swapNextScreen)-}
                {-, ((mod4Mask .|. shiftMask, xK_q), shiftPrevScreen)-}
                {-, ("M-S-w", shiftNextScreen)-}
                {-, ("M-S-q", nextScreen >> shiftNextScreen)-}
                {-, ("M-S-m", manPrompt myXPConfig)-}
                {-, ("M-S-m", (workspacePrompt defaultXPConfig (windows . W.shift)))-}
                , ("M-w-h", sendMessage $ Go L)
                , ("M-w-l", sendMessage $ Go R)
                , ("M-w-j", sendMessage $ Go D)
                , ("M-w-k", sendMessage $ Go U)
                , ("M-S-w-h", sendMessage $ Swap L)
                , ("M-S-w-l", sendMessage $ Swap R)
                , ("M-S-w-j", sendMessage $ Swap D)
                , ("M-S-w-k", sendMessage $ Swap U)

                , ("M-s", (goToSelected defaultGSConfig))
                , ("M-d", (bringSelected defaultGSConfig))
                , ("M-x", (windowPromptGoto myXPConfig))
                , ("M-c", (windowPromptBring myXPConfig))
                , ("M-r", (shellPrompt myXPConfig))
                , ("M-n", (appendFilePrompt myXPConfig "/home/mwhite/personal/Dropbox/notes.txt"))
                , ("M-z", (xmonadPrompt myXPConfig))

                ]

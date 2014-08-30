import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.FadeWindows
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeysP)
import System.IO


main = do
    xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmobarrc"
    xmonad $ defaultConfig {
        terminal = "urxvt",
        logHook = fadeWindowsLogHook fadeHook,
        handleEventHook = fadeWindowsEventHook,
        manageHook = manageDocks <+> manageHook defaultConfig,
        layoutHook = avoidStruts  $  layoutHook defaultConfig,
        modMask = mod4Mask
        }
        `additionalKeysP`
        [
            ("M-c", spawn "chromium")
        ]

fadeHook = composeAll [
    isUnfocused --> transparency 0.2]

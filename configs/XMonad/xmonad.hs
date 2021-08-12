import XMonad
import XMonad.Actions.SpawnOn
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.ResizableTile
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig
import XMonad.Util.SpawnOnce
import Graphics.X11.ExtraTypes.XF86
import qualified XMonad.StackSet as W

myStartupHook = do
	spawnOnOnce "main" "firefox"
	spawnOnOnce "social" "discord"
	spawnOnOnce "social" "spotify"
	spawnOnOnce "social" "slack"
	spawnOnce "polybar -r default"

myLayouts = myDefaultLayouts
	where
		myDefaultLayouts = tiledLayout ||| Mirror tiledLayout ||| Full
		tiledLayout = ResizableTall 1 (5/100) (1/2) []

myManageHook = manageSpawn <+> manageHook def <+> manageDocks <+> (fmap not isDialog --> doF avoidMaster)
	where
		avoidMaster :: W.StackSet i l a s sd -> W.StackSet i l a s sd
		avoidMaster = W.modify' $ \c -> case c of
			W.Stack t [] (r:rs) -> W.Stack r [] (t:rs)
			otherwise -> c

main = do
	xmonad $ docks $ ewmh def
		{
			terminal = "alacritty",
			borderWidth = 0,
			workspaces = ["main", "social", "development", "scratch-1", "scratch-2"],
			layoutHook = avoidStruts $ spacingRaw True (Border 8 8 8 8) True (Border 8 8 8 8) True $ myLayouts,
			manageHook = myManageHook,
			handleEventHook = handleEventHook def <+> fullscreenEventHook,
			startupHook = startupHook def <+> myStartupHook
		}
		`additionalKeys`
		[
			((0, xF86XK_AudioLowerVolume), spawn "pactl set-sink-mute @DEFAULT_SINK@ false;pactl set-sink-volume @DEFAULT_SINK@ -5%"),
			((0, xF86XK_AudioRaiseVolume), spawn "pactl set-sink-mute @DEFAULT_SINK@ false;pactl set-sink-volume @DEFAULT_SINK@ +5%"),
			((0, xF86XK_AudioMute), spawn "amixer set Master toggle"),
			((0, xF86XK_AudioPlay), spawn "playerctl play-pause --ignore-player=firefox"),
			((0, xF86XK_AudioNext), spawn "playerctl next --ignore-player=firefox"),
			((0, xF86XK_AudioPrev), spawn "playerctl previous --ignore-player=firefox")
		]

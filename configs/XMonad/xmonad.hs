{-# LANGUAGE MultiParamTypeClasses, FlexibleInstances #-}
import XMonad
import XMonad.Actions.SpawnOn
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.Decoration
import XMonad.Layout.Spacing
import XMonad.StackSet (integrate)
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

data SideDecoration a = SideDecoration Direction2D deriving (Show, Read)

instance Eq a => DecorationStyle SideDecoration a where

	shrink b (Rectangle _ _ dw dh) (Rectangle x y w h)
		| SideDecoration U <- b = Rectangle x (y + fi dh) w (h - dh)
		| SideDecoration R <- b = Rectangle x y (w - dw) h
		| SideDecoration D <- b = Rectangle x y w (h - dh)
		| SideDecoration L <- b = Rectangle (x + fi dw) y (w - dw) h

	pureDecoration b dw dh _ st _ (win, Rectangle x y w h)
		| win `elem` integrate st && dw < w && dh < h = Just $ case b of
			SideDecoration U -> Rectangle x y w dh
			SideDecoration R -> Rectangle (x + fi (w - dw)) y dw h
			SideDecoration D -> Rectangle x (y + fi (h - dh)) w dh
			SideDecoration L -> Rectangle x y dw h
		| otherwise = Nothing

myLayouts = myDefaultLayouts
	where
		myDefaultLayouts = tiledLayout ||| Mirror tiledLayout ||| Full
		tiledLayout = Tall 1 (5/100) (1/2)

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

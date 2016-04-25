import XMonad
import XMonad.ManageHook
import XMonad.Util.Dmenu
import System.Exit
import Control.Monad
import XMonad.Layout.NoBorders
import XMonad.Hooks.ManageHelpers
import qualified Data.Map as M
import qualified XMonad.StackSet as W
import XMonad.Layout.ResizableTile
import XMonad.Layout.SimpleFloat
import XMonad.Layout.PerWorkspace

myModMask = mod4Mask

startup :: X ()
startup = do
   spawn "zsh ~/.xmonad/xmonad.startup"

quitWithWarning :: X ()
quitWithWarning = do
    let m = "confirm quit"
    s <- dmenu [m]
    when (m == s) (spawn "rm -r ~/.xmonad/started")
    when (m == s) (io exitSuccess)

myKeys conf = M.fromList $
  [ --rebindings
    -- launch a terminal
    ((myModMask .|. shiftMask, xK_Return ), spawn $ XMonad.terminal conf)
    -- launch dmenu
  , ((myModMask,               xK_l      ), spawn "exe=`dmenu_run | dmenu -i` && eval 'exec $exe'")
    -- lock screen
  , ((myModMask,               xK_z      ), spawn "slock")
    -- close focused window 
  , ((myModMask,               xK_c      ), kill)
    -- Rotate through the available layout algorithms
  , ((myModMask,               xK_space  ), sendMessage NextLayout)
    --  Reset the layouts on the current workspace to default
  , ((myModMask .|. shiftMask, xK_space  ), setLayout $ XMonad.layoutHook conf)
    -- Resize viewed windows to the correct size
  , ((myModMask,               xK_b      ), refresh)
    -- Move focus to the next window
  , ((myModMask,               xK_Tab    ), windows W.focusDown)
    -- Move focus to the previous window
  , ((myModMask .|. shiftMask, xK_Tab    ), windows W.focusUp)
    -- Move focus to the masterh window
  , ((myModMask,               xK_m      ), windows W.focusMaster  )
    -- Swap the focused window and the master window
  , ((myModMask .|. shiftMask, xK_m      ), windows W.swapMaster)
    -- Swap the focused window with the next window
  , ((myModMask              , xK_j      ), windows W.swapDown  )
    -- Swap the focused window with the previous window
  , ((myModMask              , xK_k      ), windows W.swapUp    )
    -- Shrink the master area
  , ((myModMask,               xK_h      ), sendMessage Shrink)
    -- Expand the master area
  , ((myModMask,               xK_t      ), sendMessage Expand)
    -- Push window back into tiling
  , ((myModMask,               xK_y      ), withFocused $ windows . W.sink)
    -- Increment the number of windows in the master area
  , ((myModMask              , xK_w      ), sendMessage (IncMasterN 1))
    -- Deincrement the number of windows in the master area
  , ((myModMask              , xK_v      ), sendMessage (IncMasterN (-1)))
    -- Quit xmonad
  , ((myModMask .|. shiftMask, xK_q      ), quitWithWarning)
    -- Restart xmonad
  , ((myModMask,               xK_q      ),
      broadcastMessage ReleaseResources >> restart "xmonad" True)
    -- Lower audio volume
  , ((0,                       0x1008ff11), spawn "amixer sset Master 1%-")
    -- Higher audio volume
  , ((0,                       0x1008ff13), spawn "amixer sset Master 1%+")
    -- Mute/unmute
  , ((0,                       0x1008ff12), spawn "amixer sset Master toggle") ]
    ++
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
  [ ((m .|. myModMask, k), windows $ f i)
    | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
  , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
    --
    -- mod-{ , , . , p}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{foo}, Move client to screen 1, 2, or 3
    --
  [ ((m .|. myModMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
    | (key, sc) <- zip [xK_comma, xK_period] [0..]
  , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

myWorkspaces = [ "1:term"
               , "2:utilities"
               , "3:web"
               , "4:mail"
               , "5:skype"
               , "6:vm"
               , "7"
               , "8"
               , "9"
               , "0"]

myManageHook :: ManageHook
myManageHook = composeAll
    [  className =? "URxvt" <&&> title =? "htop"    --> doShift "2:utilities"  
    ,  className =? "URxvt"                         --> doShift "1:term"  
    --,  className =? "Xfce4-terminal"              --> doShift "2:utilities"   
    ,  className =? "Iceweasel"                     --> doShift "3:web"   
    ,  className =? "Icedove"                       --> doShift "4:mail"  
    ,  className =? "Skype"                         --> doShift "5:skype" 
    ,  className =? "VirtualBox"                    --> doShift "6:vm" 
    ,  className =? "Xfce4-notifyd"                 --> doF W.focusDown
    ,  isFullscreen                                 --> doFullFloat
    ]

customLayout  =   Mirror tiled ||| Full
 where
     tiled   = ResizableTall 1 (1/100) (1/5) []

myLayoutHook  =   onWorkspace "2:utilities" customLayout $ 
                  layoutHook defaultConfig
                  

main = do
  xmonad $ defaultConfig
    { terminal            = "urxvt -e byobu"
    , modMask             = myModMask
    , workspaces          = myWorkspaces
    , manageHook          = myManageHook -- <+> manageHook defaultConfig
    , layoutHook          = smartBorders(myLayoutHook)
    , startupHook         = startup
    , keys                = myKeys
    , normalBorderColor   = "#334466"
    , focusedBorderColor  = "#82c0ca"
    , borderWidth         = 3
    }

-- ~/.config/hypr/hyprland.lua

----------------- MONITORS -----------------
-- Laptop internal panel auto; add externals as needed.
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto", mirror = "eDP-1"})
hl.monitor({ output = "eDP-1", mode = "preferred", position = "0x0",  scale = "1" })
hl.monitor({
    output = "desc:Philips Consumer Electronics Company PHL 241B4 AU11525001762",
    mode = "preferred",
    position = "1920x0",
    scale = "1"
})
hl.monitor({
    output = "desc:Synaptics Inc Non-PnP 0x00BC614E",
    mode = "1920x1080@60.00Hz",
    position = "3840x0",
    scale = "1",
    transform = 1
})
----------------- WORKSPACE -> MONITOR BINDING -----------------
hl.workspace_rule({
    workspace = 1,
    monitor = "desc:Philips Consumer Electronics Company PHL 241B4 AU11525001762",
    default = true
})
hl.workspace_rule({
    workspace = 2,
    monitor = "desc:Synaptics Inc Non-PnP 0x00BC614E",
    default = true
})
hl.workspace_rule({ workspace = 3, monitor = "eDP-1", default = true })


----------------- ENV -----------------
hl.env("XCURSOR_THEME", "Nordzy-cursors-solarized-dark")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "Nordzy-hyprcursors-solarized-dark")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("SSH_AUTH_SOCK", os.getenv("XDG_RUNTIME_DIR").."/ssh-agent.socket")
-- hl.env("QT_QPA_PLATFORMTHEME", "hyprqt6engine")

----------------- INPUT (Dvorak!) -----------------
hl.config({
    input = {
        resolve_binds_by_sym = 1, --important otherwise commands do not follow
        kb_layout = "us",
        kb_variant = "altgr-intl",
        kb_options = "caps:escape,compose:rctrl",
        follow_mouse = 1,
        touchpad = {
            natural_scroll        = true,
            tap_to_click          = true,
            clickfinger_behavior  = true,
            disable_while_typing  = true,
        },
    },
})

-- Internal T14 keyboard -> Dvorak
hl.device {
    name = "at-translated-set-2-keyboard",
    kb_layout = "us,us",
    kb_variant = "dvorak-alt-intl,altgr-intl",
    kb_options = "grp:alt_shift_toggle,caps:escape,compose:rctrl",
}

----------------- LOOK & FEEL (Solarized Dark) -----------------
hl.config({
    general = {
        gaps_in  = 1,
        gaps_out = 4,
        border_size = 0,
        layout = "master",
    },
    decoration = {
        rounding = 10,
        active_opacity = 1.0,
        inactive_opacity = 0.85,
        dim_inactive = true,
        dim_strength = 0.2,
        blur = { enabled = false },
    },
    master = {
        new_status = "slave",
        orientation = "left",
    },
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
    },
})

hl.window_rule({
    match = { class = "firefox" },
    opacity = "1.0 override 1.0 override",

})

hl.window_rule({
    match = { class = "firefox", modal = true },
    opaque = true,
    no_dim = true,
})

----------------- PROGRAMS -----------------
local term = "foot -T main -e byobu"
local menu = "wofi --show run"

----------------- KEYBINDINGS -----------------
local M = "SUPER"

-- Launch / core
hl.bind(M .. " + SHIFT + Return", hl.dsp.exec_cmd(term))
hl.bind(M .. " + Return",         hl.dsp.exec_cmd("foot"))
hl.bind(M .. " + L",              hl.dsp.exec_cmd(menu))
hl.bind(M .. " + Z",              hl.dsp.exec_cmd("hyprlock"))
hl.bind(M .. " + C",              hl.dsp.window.close())

-- Focus up/down the stack
hl.bind(M .. " + Tab",         hl.dsp.window.cycle_next({ next = true }))
hl.bind(M .. " + SHIFT + Tab", hl.dsp.window.cycle_next({ next = false }))

-- Swap window up/down
hl.bind(M .. " + J",           hl.dsp.window.swap({ next = true }))
hl.bind(M .. " + K",           hl.dsp.window.swap({ prev = true }))

-- "Full" layout feel
hl.bind(M .. " + space",       hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(M .. " + SHIFT + space", hl.dsp.exec_cmd("hyprctl reload"))

-- Master controls
hl.bind(M .. " + M",         hl.dsp.layout("focusmaster"))
hl.bind(M .. " + SHIFT + M", hl.dsp.layout("swapwithmaster"))
hl.bind(M .. " + W",         hl.dsp.layout("addmaster"))
hl.bind(M .. " + V",         hl.dsp.layout("removemaster"))
hl.bind(M .. " + H",         hl.dsp.layout("mfact -0.05"))  -- Dvorak h, shrink
hl.bind(M .. " + T",         hl.dsp.layout("mfact +0.05"))  -- Dvorak t, expand

-- Float / sink
hl.bind(M .. " + Y",         hl.dsp.window.float({ action = "toggle" }))

-- Monitors
hl.bind(M .. " + comma",          hl.dsp.focus({ monitor = 0 }))
hl.bind(M .. " + period",         hl.dsp.focus({ monitor = 1 }))
hl.bind(M .. " + P",              hl.dsp.focus({ monitor = 2 }))
hl.bind(M .. " + SHIFT + comma",  hl.dsp.window.move({ monitor = 0 }))
hl.bind(M .. " + SHIFT + period", hl.dsp.window.move({ monitor = 1 }))
hl.bind(M .. " + SHIFT + P",      hl.dsp.window.move({ monitor = 2 }))


-- Session
hl.bind(M .. " + Q",           hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(M .. " + SHIFT + Q",   hl.dsp.exit())
hl.bind(M .. " + SHIFT + S",   hl.dsp.exec_cmd("systemctl poweroff"))

-- Workspaces 1..9,0
for i = 1, 10 do
    local key = i % 10
    hl.bind(M .. " + " .. key,          hl.dsp.focus({ workspace = i, on_current_monitor = true }))
    hl.bind(M .. " + SHIFT + " .. key,  hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Monitors: comma / period / p  (your screen keys) -- NATIVE best guess
hl.bind(M .. " + comma",          hl.dsp.focus({ monitor = 0 }))
hl.bind(M .. " + period",         hl.dsp.focus({ monitor = 2 }))
hl.bind(M .. " + P",              hl.dsp.focus({ monitor = 1 }))
hl.bind(M .. " + SHIFT + comma",  hl.dsp.window.move({ monitor = 0 }))
hl.bind(M .. " + SHIFT + period", hl.dsp.window.move({ monitor = 2 }))
hl.bind(M .. " + SHIFT + P",      hl.dsp.window.move({ monitor = 1 }))

-- hidden waybar + keyboard-driven hardware control
hl.bind(M .. " + SHIFT + B",           hl.dsp.exec_cmd("killall -SIGUSR1 waybar"))
hl.bind(M .. " + N",           hl.dsp.exec_cmd("foot -T nmtui -e nmtui"))
hl.bind(M .. " + B",           hl.dsp.exec_cmd("foot -T bt -e bluetui"))
hl.bind(M .. " + A",           hl.dsp.exec_cmd("foot -T audio -e wiremix"))
hl.bind(M .. " + S",           hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | wl-copy"))
hl.bind(M .. " + R",           hl.dsp.exec_cmd("foot -T btop -e btop"))

-- Media / brightness keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Mouse drag
hl.bind(M .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(M .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

--------------------------- WINDOW RULES --------------------------
hl.window_rule({ name = "term-ws1", match = { class = "Alacritty", title = "main" }, workspace = "1 silent" })
hl.window_rule({ name = "web-ws2",  match = { class = "firefox", title = "negative:.*(Settings|Preferences|Page Setup|Print|Save File|Open File|Library).*" },   workspace = "2 silent" })
hl.window_rule({ name = "keepass-ws10",  match = { class = "org.keepassxc.KeePassXC", title = "negative:.*(Access Request|Unlock Database).*" },   workspace = "10 silent" })

----------------------------- AUTOSTART ---------------------------
hl.on("hyprland.start", function()
    hl.exec_cmd("mako")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("waybar")
    hl.exec_cmd(term)
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("firefox")
    hl.exec_cmd("/usr/libexec/polkit-gnome-authentication-agent-1")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'NumixSolarizedDarkBlue'")
    hl.exec_cmd("keepassxc")
end)

hl.on("hyprland.shutdown", function()
    hl.exec_cmd("systemctl --user stop hyprland-session.target")
end)

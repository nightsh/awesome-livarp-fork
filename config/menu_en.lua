-- {{{ Menu
-- submenu

-- Graph submenu -------------------------------------------------------
capture = {
{"now", "scrot"},
{"in 5s", "scrot -d5"},
{"in 10s", "scrot -d10"},
{"in a Zone", "scrot -s"}
 }
------------------------------------------------------------------------

local beautiful = require('beautiful')

-- Preferences submenu -------------------------------------------------
awesomemenu = {
    { "themes", mythememenu },
    { "wallpapers", mywallmenu },
    { "-----------"},   
    { "edit config.lua", editor_cmd .." ".. config_dir .."/config.lua"},    
    { "-----------"},
    { "edit keys.lua", editor_cmd .." ".. config_dir .."/config/keys.lua"},
    { "edit menu.lua", editor_cmd .." ".. config_dir .."/config/menu.lua"},
    { "edit mouse.lua", editor_cmd .." ".. config_dir .."/config/mouse.lua"},
    { "edit rules_dynamic.lua", editor_cmd .." ".. config_dir .."/config/rules_dynamic.lua"},
    { "edit rules_static.lua", editor_cmd .." ".. config_dir .."/config/rules_static.lua"},
    { "edit signals.lua", editor_cmd .." ".. config_dir .."/config/signals.lua"},
    { "edit tags_dynamic.lua", editor_cmd .." ".. config_dir .."/config/tags_dynamic.lua"},
    { "edit tags_static.lua", editor_cmd .." ".. config_dir .."/config/tags_static.lua"},
    { "edit widgets_text.lua", editor_cmd .." ".. config_dir .."/config/widgets_text.lua"},
    { "edit widgets_graph.lua", editor_cmd .." ".. config_dir .."/config/widgets_graph.lua"},
    { "-----------"},
    { "edit awesome_start", editor_cmd .." bin/start/awesome_start.sh" },
    { "-----------"},
    { "man page", terminal .." -e man awesome" },
    { "edit .xinitrc", editor_cmd .." .xinitrc" },
    { "-----------"},
    { "reload", awesome.restart },
    { "exit", awesome.quit },
}

conky = {
    { "edit .conkyrc", editor_cmd .." .conky/.conkyrc_awesome" },
    { "man page", terminal .." -e man conky" },
    { "wiki page", webcli .." http://arpinux.org/x/doku.php/start:conky" },
}
composite = {
    { "no effect", "xcompmgr_livarp -s" },
    { "light effect", "xcompmgr_livarp -l" },
    { "medium effect", "xcompmgr_livarp -m" },
    { "full effect", "xcompmgr_livarp -f" },
    { "standard xcompmgr", "xcompmgr" },
}
------------------------------------------------------------------------

prefs = {
    { "awesome", awesomemenu },
    { "conky", conky },
    { "display", "grandr" },
    { "interface", "lxappearance" },
    { "wallpaper", "nitrogen " },
    { "web startpage", editor_cmd.." .startpage/index.html" },
    { "composite", composite},
}
accessoires = {
    { "terminal", "urxvtc" },
    { "search util", "catfish" },
    { "rename", "pyrenamer" },
    { "file-roller", "file-roller" },
    { "text editor", "geany" },
    { "file-manager", "rox-filer" },
    { "root file-manager", "gksudo rox-filer" },
}
multimedia = {
   { "multimedia player", "gnome-mplayer" },
   { "music player (cli)", terminal.." -e mocp" },
   { "cd/dvd burner", "brasero" },
   { "control volume", terminal .." -e alsamixer" },
}
internet = {
   { "luakit browser", "luakit" },
   { "firefox browser", "firefox" },
   { "IRC client weechat", terminal.." -e weechat-ncurses" },
   { "jabber client mcabber", terminal.." -e mcabber" },
   { "mail cient claws-mail", "claws-mail" },
   { "FTP client filezilla", "filezilla" },
   { "torrent client transmission", "transmission" },
}
bureautique = {
   { "text editor", "geany" },
   { "abiword", "abiword" },
   { "gnumeric", "gnumeric" },
   { "calculate", "xcalc" },
   { "PDF viewer", "evince" },
}
graphismmenu = {
    { "the gimp", "gimp" },
    { "image viewer", "gpicview" },
    { "gcolor2", "gcolor2" },
    { "screenshot", capture },
}
applications = {
    { "internet", internet },
    { "multimedia", multimedia },
    { "graphics", graphismmenu },
    { "bureautique", bureautique },
    { "accessories", accessoires },
}
systemmenu = {
    { "packages manager", "gksudo synaptic" },
    { "partition editor", "gksudo gparted" },
    { "default applications", terminal.." -e sudo update-alternatives --all" },
    { "disks usage", "baobab" },
    { "boot-up manager", "gksudo bum" },
    { "root terminal", terminal.." -e su" },
    { "livarp-xs-maker", "/usr/local/bin/livarp-xs.sh" },
}
helpmenu = {
    { "livarp-help-center", webcli.." /usr/share/livarp/help_center/index.html" },
    { "livarp wiki", webcli.." http://arpinux.org/x/doku.php/start:livarp:livarp_039_gb" },
}
------------------------------------------------------------------------

-- Main Menu -----------------------------------------------------------
mymainmenu = awful.menu({ items = { { "run", "dmenu_run -i -p 'exec :' -nb '" .. 
										beautiful.bg_normal .. "' -nf '" .. beautiful.fg_normal .. 
										"' -sb '" .. beautiful.bg_focus .. 
										"' -sf '" .. beautiful.fg_focus .. "'" },
									{ "--------" },
									{ "terminal", terminal },
									{ "web browser", "luakit" },
									{ "file-manager", manager },
                                    { "text editor", "geany" },
                                    { "media player", "gnome-mplayer" },
                                    { "--------" },
                                    { "applications", applications },
									{ "preferences", prefs },
                                    { "system", systemmenu },
                                    { "help", helpmenu },
                                    { "--------" },
                                    { "lock screen", "xscreensaver-command --lock" },
                                    { "exit", "shutdown.sh" }
                                  }
                        })
------------------------------------------------------------------------

-- Launcher Menu -------------------------------------------------------
mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = mymainmenu })
------------------------------------------------------------------------

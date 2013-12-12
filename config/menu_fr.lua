-- {{{ Menu
-- submenu

-- Graph submenu -------------------------------------------------------
capture = {
{"maintenant", "scrot"},
{"dans 5s", "scrot -d5"},
{"dans 10s", "scrot -d10"},
{"sélection", "scrot -s"}
 }
------------------------------------------------------------------------

-- Preferences submenu -------------------------------------------------
awesomemenu = {
    { "themes", mythememenu },
    { "wallpapers", mywallmenu },
    { "-----------"},
    { "edit config.lua", editor_cmd .." ".. config_dir .."/config.lua"},
    { "-----------"},
    { "éditer keys.lua", editor_cmd .." ".. config_dir .."/config/keys.lua"},
    { "éditer menu.lua", editor_cmd .." ".. config_dir .."/config/menu.lua"},
    { "éditer mouse.lua", editor_cmd .." ".. config_dir .."/config/mouse.lua"},
    { "éditer rules_dynamic.lua", editor_cmd .." ".. config_dir .."/config/rules_dynamic.lua"},
    { "éditer rules_static.lua", editor_cmd .." ".. config_dir .."/config/rules_static.lua"},
    { "éditer signals.lua", editor_cmd .." ".. config_dir .."/config/signals.lua"},
    { "éditer tags_dynamic.lua", editor_cmd .." ".. config_dir .."/config/tags_dynamic.lua"},
    { "éditer tags_static.lua", editor_cmd .." ".. config_dir .."/config/tags_static.lua"},
    { "éditer widgets_text.lua", editor_cmd .." ".. config_dir .."/config/widgets_text.lua"},
    { "éditer widgets_graph.lua", editor_cmd .." ".. config_dir .."/config/widgets_graph.lua"},
    { "-----------"},
    { "éditer awesome_start", editor_cmd .." bin/start/awesome_start.sh" },
    { "-----------"},
    { "page de manuel", terminal .." -e man awesome" },
    { "éditer .xinitrc", editor_cmd .." .xinitrc" },
    { "-----------"},
    { "relancer", awesome.restart },
    { "déconnexion", awesome.quit },
}

conky = {
    { "éditer .conkyrc", editor_cmd .." .conky/.conkyrc_awesome" },
    { "page de manuel", terminal .." -e man conky" },
    { "page de wiki", webcli .." http://arpinux.org/x/doku.php/start:conky" },
}
composite = {
    { "pas d'effet", "xcompmgr_livarp -s" },
    { "effet léger", "xcompmgr_livarp -l" },
    { "effet classique", "xcompmgr_livarp -m" },
    { "effet complet", "xcompmgr_livarp -f" },
}
------------------------------------------------------------------------

prefs = {
    { "awesome", awesomemenu },
    { "conky", conky },
    { "affichage", "grandr" },
    { "interface", "lxappearance" },
    { "fond d'ecran", "nitrogen " },
    { "page d'accueil web", editor_cmd.." .startpage/index.html" },
    { "composite", composite},
}
accessoires = {
    { "terminal", "urxvtc" },
    { "rechercher", "catfish" },
    { "renommer", "pyrenamer" },
    { "gestionnaire d'archive", "file-roller" },
    { "éditeur de texte", "geany" },
    { "gestion de fichiers", "rox-filer" },
    { "gestion de fichiers (root)", "gksudo rox-filer" },
}
multimedia = {
   { "lecteur multimedia", "gnome-mplayer" },
   { "lecteur musique (cli)", terminal.." -e mocp" },
   { "graveur de cd/dvd", "brasero" },
   { "contrôleur de volume", terminal .." -e alsamixer" },
}
internet = {
   { "navigateur luakit", "luakit" },
   { "navigateur firefox", "firefox" },
   { "client IRC weechat", terminal.." -e weechat-ncurses" },
   { "client jabber mcabber", terminal.." -e mcabber" },
   { "client mail claws-mail", "claws-mail" },
   { "client FTP filezilla", "filezilla" },
   { "client torrent transmission", "transmission" },
}
bureautique = {
   { "éditeur de texte", "geany" },
   { "traitement de texte", "abiword" },
   { "tableur", "gnumeric" },
   { "calculatrice", "xcalc" },
   { "visionneur PDF", "evince" },
}
graphismmenu = {
    { "the gimp", "gimp" },
    { "visionneur d'images", "gpicview" },
    { "choix de couleurs", "gcolor2" },
    { "capture d'écran", capture },
}
applications = {
    { "internet", internet },
    { "multimedia", multimedia },
    { "graphisme", graphismmenu },
    { "bureautique", bureautique },
    { "accessoires", accessoires },
}
systemmenu = {
    { "gestionnaire de paquets", "gksudo synaptic" },
    { "éditeur de partition", "gksudo gparted" },
    { "applications par défaut", terminal.." -e sudo update-alternatives --all" },
    { "utilisation du disque", "baobab" },
    { "gestionnaire de services", "gksudo bum" },
    { "terminal administrateur", terminal.." -e su" },
    { "livarp-xs-maker", "/usr/local/bin/livarp-xs.sh" },
}
helpmenu = {
    { "centre d'aide livarp", webcli.." /usr/share/livarp/help_center/index-fr.html" },
    { "wiki livarp", webcli.." http://arpinux.org/x/doku.php/start:livarp:livarp_039" },
}
------------------------------------------------------------------------

-- Main Menu -----------------------------------------------------------
mymainmenu = awful.menu({ items = { { "lancer", "dmenu_run -i -p 'exec :' -nb '" .. 
										beautiful.bg_normal .. "' -nf '" .. beautiful.fg_normal .. 
										"' -sb '" .. beautiful.bg_focus .. 
										"' -sf '" .. beautiful.fg_focus .. "'" },
									{ "--------" },
									{ "terminal", terminal },
									{ "navigateur internet", "luakit" },
									{ "navigateurs de fichiers", manager },
                                    { "éditeur de texte", "geany" },
                                    { "lecteur multimedia", "gnome-mplayer" },
                                    { "--------" },
                                    { "applications", applications },
									{ "préférences", prefs },
                                    { "système", systemmenu },
                                    { "aide", helpmenu },
                                    { "--------" },
                                    { "verrouiller l'ecran", "xscreensaver-command --lock" },
                                    { "quitter", "shutdown.sh" }
                                  }
                        })
------------------------------------------------------------------------

-- Launcher Menu -------------------------------------------------------
mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon), menu = mymainmenu })
------------------------------------------------------------------------
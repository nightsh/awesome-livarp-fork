-- folders
wallpapers = "/usr/share/backgrounds"
screenshots = home .. "/tmp/"

-- mono font for widget popups (mandatory for popup to work)
monofont = "UbuntuMono 8"

--awesome menu
menu_icon = true --if true the Awesome menu icon will show on top left corner menu still accessible with right clic and Alt+p
menu_lang = "en" --support fr and en

--taglists
taglist = "static" --support static/dynamic
-- if static select taglists_type
taglist_style = "arabic" -- we support awesome (a,w,e,s,o,m,e...), arabic (1,2,3...),east_arabic (١, ٢, ٣,...), persian_arabic(٠,١,٢,٣,۴,....}, roman (I, II, III, IV,)

--clients
enable_titlebar = false --enable clients titlebar
enable_floatbar = false --enable clients titlebar only when client is floating
tasklist_icon_enable = true --enable client tasklist icons

--wibox
widget_mode = "graph" --support text/graph
show_icons = true --support true or false -- if icons not in theme, default icons set will be used
top_bar_visible = true -- support true/false -- toggle with ctrl+alt+t -- only work on primary screen
bottom_bar_visible = false --support true/false -- toggle with ctrl+alt+b -- only work on primary screen
invert_bar = false --invert widgets bar (top is bottom and bottom is top)
wibox_opacity = 1 --wibox bar opacity (transparency between 0 and 1)

--date widget
date_lang = "ro_RO.UTF-8" --en_EN.UTF-8 for english -- fr_FR.UTF-8 for french
date_format = "%a %d %b %Y %R" -- refer to http://en.wikipedia.org/wiki/Date_(Unix) specifiers

--cpu widget
cpu_enable = true -- Show CPU info
cputemp_enable = true --Show CPU temp

--mem widget
mem_enable = true -- Show memory bar
memtext_enable = true -- Show memtext --need mem to be enable too (don't change anything in widget mode 'text')
memtext_format = " $2" -- %1 percentage, %2 used %3 total %4 free

--disk widget
diskbootbar_enable = false --show boot partition bar
diskrootbar_enable = false --show root partition bar
diskhomebar_enable = false --show home partition bar

--system
uptime_enable = true -- show uptime and load

--network widget
net_enable = false --show net traffic
apt_enable = false --show apt update if any
gmail_enable = false --show unread mail in gmail box (need ~/.netrc with -> machine mail.google.com login <e-mail address> password <password>)
weather_enable = true --show weather info
weather_code = "LRBS" --if show weather is enable use this code

--volume widget
vol_enable = true --enable volume widget

-- music widget
mpd_enable = false --show mpd widget (need mpd and mpc to be installed)
moc_enable = false --show moc widget

--bat widget
battery_enable = true -- Show battery state

--info help icon
infoicon_enable = true -- Show help on awesome wm shortcuts

--default icons if not in theme
default_cal_img = os.getenv("HOME").."/.config/awesome/icons/dzen/clock.png"
default_cpu_img = os.getenv("HOME").."/.config/awesome/icons/dzen/cpu.png"
default_mem_img = os.getenv("HOME").."/.config/awesome/icons/dzen/mem.png"
default_bat_img = os.getenv("HOME").."/.config/awesome/icons/dzen/bat_full_01.png"
default_fs_img = os.getenv("HOME").."/.config/awesome/icons/dzen/fs_01.png"
default_info_img = os.getenv("HOME").."/.config/awesome/icons/dzen/info_01.png"
default_vol_img = os.getenv("HOME").."/.config/awesome/icons/dzen/spkr_01.png"
default_music_img = os.getenv("HOME").."/.config/awesome/icons/dzen/note.png"
default_netup_img = os.getenv("HOME").."/.config/awesome/icons/dzen/net_up_01.png"
default_netdn_img = os.getenv("HOME").."/.config/awesome/icons/dzen/net_down_01.png"





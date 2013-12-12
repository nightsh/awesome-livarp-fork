-- Widgets Library -------
local vicious = require("vicious")
local couth   = require("couth.couth")
local popups  = require ("popups")

-- popups color scheme
green = "#7fb219"
cyan  = "#7f4de6"
red   = "#e04613"
lblue = "#6c9eab"
dblue = "#00ccff"
black = "#000000"
lgrey = "#d2d2d2"
dgrey = "#333333"
white = "#ffffff"

notify_font_color_1 = white
notify_font_color_2 = lgrey
notify_font_color_3 = red

-- call tasklist menu
local menu = require('menu')

-- Create a systray
mysystray = wibox.widget.systray()

-- Create Wibox ------------------------------------------------------------------------------
mywibox = {}
my_bottom_wibox ={}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button( k_m , 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button( k_m, 3, function(t) menu.create.tags(nil, t) end),
                    awful.button({ }, 8, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
                
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1,
			function (c)
			if not c:isvisible() then awful.tag.viewonly(c:tags()[1]) end
				if client.focus == c then
				c.minimized = not c.minimized
				else
				client.focus = c
				c:raise()
				end
			end
			),
			awful.button({ }, 2, function (c) c:kill() end),
			awful.button({ }, 3,
			function (c)
			if instance then
				instance:hide()
				instance = nil
				else
				instance = menu.create.clients(nil, c)
				end
			end
			),
			awful.button({ }, 4,
				function ()
				awful.client.focus.byidx(1)
				if client.focus then client.focus:raise() end
				end
			),
			awful.button({ }, 5,
				function ()
				awful.client.focus.byidx(-1)
				if client.focus then client.focus:raise() end
				end
			)
)
for s = 1, screen.count() do
-----------------------------------------------------------------------------------------------
os.setlocale(date_lang)

if show_icons then
		calicon = wibox.widget.imagebox()
		if beautiful.widget_cal then
			calicon:set_image(beautiful.widget_cal)
		else
			calicon:set_image(default_cal_img)
		end
	end

-- Create a textclock widget
datewidget = wibox.widget.textbox()
vicious.register(datewidget, vicious.widgets.date, "<span color=\""..beautiful.fg_normal.."\" size=\"small\">"..date_format.."</span>", 60)

-- Calendar widget to attach to the textclock
require('calendar2')
calendar2.addCalendarToWidget(datewidget)

------------------------------------------------------------------

-- Promptbox ------------------------------------------------------------------------------
mypromptbox[s] = awful.widget.prompt()
-------------------------------------------------------------------------------------------

-- Layout Box ----------------------------------------------------------------------------------
mylayoutbox[s] = awful.widget.layoutbox(s)
mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
------------------------------------------------------------------------------------------------

-- Taglist ------------------------------------------------------------------------------
mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)
-----------------------------------------------------------------------------------------

-- Tasklist ----------------------------------------------------------------------------------
if tasklist_icon_enable then
	mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)
else
	mytasklist[s] = awful.widget.tasklist(s, function(c)
		--remove tasklist-icon without modifying the original tasklist.lua
		local tmptask = { awful.widget.tasklist.filter.currenttags }
		return tmptask[1], tmptask[2], tmptask[3], nil
	end, mytasklist.buttons)
end
----------------------------------------------------------------------------------------------

-- Systray -----------------------------
mysystray = wibox.widget.systray()
----------------------------------------

-- Separator left ------------------------
separatorl = wibox.widget.textbox()
separatorl.text = ' [ '
-------------------------------------------
-- Separator right ------------------------
separatorr = wibox.widget.textbox()
separatorr.text = ' ] '
-------------------------------------------
-- Separator ------------------------------
separator = wibox.widget.textbox()
separator.text = ' | '
-------------------------------------------
-- Spacer ---------------------------------------------------------------
spacer = wibox.widget.textbox()
spacer.text = " "
-------------------------------------------------------------------------

	
-- {{{ CPU usage

-- check for cpugraph_enable == true in config
if cpu_enable then
	-- CPU widget
	if show_icons then
		cpuicon = wibox.widget.imagebox()
		if beautiful.widget_cpu then
			cpuicon:set_image(beautiful.widget_cpu)
		else
			cpuicon:set_image(default_cpu_img)
		end
	end
	cpuwidget = wibox.widget.textbox()

	vicious.register(cpuwidget, vicious.widgets.cpu,
		function (widget, args)
			if show_icons then
				if args[1] >= 50 and args[1] <= 75 then
					return "<span color=\""..beautiful.bg_urgent.."\" size=\"small\">" .. args[1] .. "%</span>"
				elseif args[1] > 75 then
					return "<span color=\"red\" size=\"small\">" .. args[1] .. "%</span>"
				else
					return "<span color=\""..beautiful.fg_normal.."\" size=\"small\">" .. args[1] .. "%</span>"
				end
			else
				if args[1] >= 50 and args[1] <= 75 then
					return "<span color=\""..beautiful.bg_urgent.."\" size=\"small\">Cpu : " .. args[1] .. "%</span>"
				elseif args[1] > 75 then
					return "<span color=\"red\" size=\"small\">Cpu : " .. args[1] .. "%</span>"
				else
					return "<span color=\""..beautiful.fg_normal.."\" size=\"small\">Cpu : " .. args[1] .. "%</span>"
				end
			end
		end )
	cpuwidget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn ( terminal .. " -e htop --sort-key PERCENT_CPU") end ) ) )
	popups.htop(cpuwidget,{ title_color = beautiful.notify_font_color_1, user_color= beautiful.notify_font_color_2, root_color=beautiful.notify_font_color_3, terminal = "lxterminal"})
end

-- temperature
if cputemp_enable then
	tzswidget = wibox.widget.textbox()
	vicious.register(tzswidget, vicious.widgets.thermal,
		function (widget, args)
			if args[1] > 0 then
				tzfound = true
				return " <span color=\""..beautiful.fg_normal.."\" size=\"small\">".. args[1] .. "C°</span>"
			else return "" 
			end
		end
		, 19, "thermal_zone0")
end
-- }}}

-- {{{ Memory usage

-- icon
if show_icons then
	memicon = wibox.widget.imagebox()
	if beautiful.widget_mem then
		memicon:set_image(beautiful.widget_mem)
	else
		memicon:set_image(default_mem_img)
	end
end


if mem_enable then
	-- Memory usage (progress bar) -----------------------------------------
	-- Initialize widget
	memwidget = wibox.widget.textbox()
	memwidget_t = awful.tooltip({ objects = { memwidget },})

	vicious.cache(vicious.widgets.mem)
	vicious.register(memwidget, vicious.widgets.mem, 
	function (widget, args)
		if show_icons then
			memwidget_t:set_text("Utilisé : " .. args[2] .. "/" .. args[3] .. "\nLibre : " .. args[4] .. "\n\nSwap : " .. args[5] .."/" .. args[7])
			return "<span color=\""..beautiful.fg_normal.."\" size=\"small\">" .. args[1] .. "%</span>"
		else
			memwidget_t:set_text("Utilisé : " .. args[2] .. "/" .. args[3] .. "\nLibre : " .. args[4] .. "\n\nSwap : " .. args[5] .."/" .. args[7])
			return "<span color=\""..beautiful.fg_normal.."\" size=\"small\">Mem : " .. args[1] .. "%</span>"
		end
	end, 59)
end

-- mem text output
if memtext_enable then
	memtext = wibox.widget.textbox()
	vicious.register(memtext, vicious.widgets.mem, "<span color=\""..beautiful.fg_normal.."\" size=\"small\"> " ..memtext_format.. "</span>", 30)
end
-- }}}

-- {{{ Filesystem widgets
if show_icons then
	fsicon = wibox.widget.imagebox()
	if beautiful.widget_fs then
		fsicon:set_image(beautiful.widget_fs)
	else
		fsicon:set_image(default_fs_img)
	end
end

-- fs
  fsb = wibox.widget.textbox()
  fsr = wibox.widget.textbox()
  fsh = wibox.widget.textbox()

-- Enable caching
vicious.cache(vicious.widgets.fs)
-- Register widgets
if diskbootbar_enable then
	vicious.register(fsb, vicious.widgets.fs,
	function (widget, args)
		if args["{/boot used_p}"] >= 93 and args["{/boot used_p}"] < 97 then
			return "<span color=\""..beautiful.bg_focus.."\" size=\"small\">boot " .. args["{/boot used_p}"] .. "% used (" .. args["{/boot avail_gb}"] .. " GiB free) </span>"
		elseif args["{/boot used_p}"] >= 97 and args["{/ used_p}"] < 99 then
			return "<span color=\"purple\" size=\"small\">boot " .. args["{/boot used_p}"] .. "% used (" .. args["{/boot avail_gb}"] .. " GiB free)</span>"
		elseif args["{/boot used_p}"] >= 99 and args["{/boot used_p}"] <= 100 then
			naughty.notify({ 
				title = "Avertissement Disque dur", 
				text = "Plus d'espace libre sur boot!\nFaite de la place.", 
				timeout = 10, position = "top_right", 
				fg = beautiful.fg_urgent, 
				bg = beautiful.bg_urgent 
			})
			return "<span color=\"red\" size=\"small\">root " .. args["{/ used_p}"] .. "% used (" .. args["{/ avail_gb}"] .. " GiB free)</span>"
		else
			return "<span color=\""..beautiful.fg_normal.."\" size=\"small\">root " .. args["{/ used_p}"] .. "% used (" .. args["{/ avail_gb}"] .. " GiB free)</span>"
		end
	end, 621)
	popups.disk(fsb,{ title_color = notify_font_color_1})
end

if diskrootbar_enable then
	vicious.register(fsr, vicious.widgets.fs,
	function (widget, args)
		if args["{/ used_p}"] >= 93 and args["{/ used_p}"] < 97 then
			return "<span color=\""..beautiful.bg_focus.."\" size=\"small\">root " .. args["{/ used_p}"] .. "% used (" .. args["{/ avail_gb}"] .. " GiB free) </span>"
		elseif args["{/ used_p}"] >= 97 and args["{/ used_p}"] < 99 then
			return "<span color=\"purple\" size=\"small\">root " .. args["{/ used_p}"] .. "% used (" .. args["{/ avail_gb}"] .. " GiB free)</span>"
		elseif args["{/ used_p}"] >= 99 and args["{/ used_p}"] <= 100 then
			naughty.notify({ 
				title = "Avertissement Disque dur", 
				text = "Plus d'espace libre sur root!\nFaite de la place.", 
				timeout = 10, position = "top_right", 
				fg = beautiful.fg_urgent, 
				bg = beautiful.bg_urgent 
			})
			return "<span color=\"red\" size=\"small\">root " .. args["{/ used_p}"] .. "% used (" .. args["{/ avail_gb}"] .. " GiB free)</span>"
		else
			return "<span color=\""..beautiful.fg_normal.."\" size=\"small\">root " .. args["{/ used_p}"] .. "% used (" .. args["{/ avail_gb}"] .. " GiB free)</span>"
		end
	end, 621)
	popups.disk(fsr,{ title_color = notify_font_color_1})
end

if diskhomebar_enable then
vicious.register(fsh, vicious.widgets.fs,
	function (widget, args)
		if args["{/home used_p}"] >= 93 and args["{/home used_p}"] < 97 then
			return "<span color=\""..beautiful.bg_focus.."\" size=\"small\">home " .. args["{/home used_p}"] .. "% used (" .. args["{/home avail_gb}"] .. " GiB free) </span>"
		elseif args["{/home used_p}"] >= 97 and args["{/ used_p}"] < 99 then
			return "<span color=\"purple\" size=\"small\">home " .. args["{/home used_p}"] .. "% used (" .. args["{/home avail_gb}"] .. " GiB free)</span>"
		elseif args["{/home used_p}"] >= 99 and args["{/home used_p}"] <= 100 then
			naughty.notify({ 
				title = "Avertissement Disque dur", 
				text = "Plus d'espace libre sur home!\nFaite de la place.", 
				timeout = 10, position = "top_right", 
				fg = beautiful.fg_urgent, 
				bg = beautiful.bg_urgent 
			})
			return "<span color=\"red\" size=\"small\">root " .. args["{/ used_p}"] .. "% used (" .. args["{/ avail_gb}"] .. " GiB free)</span>"
		else
			return "<span color=\""..beautiful.fg_normal.."\" size=\"small\">root " .. args["{/ used_p}"] .. "% used (" .. args["{/ avail_gb}"] .. " GiB free)</span>"
		end
	end, 621)
	popups.disk(fsh,{ title_color = notify_font_color_1})
end
-- }}}

-- {{{ Battery state

-- Initialize widget
batwidget = wibox.widget.textbox()
baticon = wibox.widget.imagebox()
bat_t = awful.tooltip({ objects = { batwidget },})

--Battery name detection
local cmd = "ls -1 /sys/class/power_supply/"
local f = io.popen(cmd)
local fh = ""
for l in f:lines() do
	local fh= io.open("/sys/class/power_supply/".. l .."/present", "r")
	if fh == nil then
	else
		Battery = l
	end
end
f:close()

-- Register widget
vicious.register(batwidget, vicious.widgets.bat,
	function (widget, args)
		if args[2] == 0 then return ""
		else
			if args[2] < 15 then
				naughty.notify({
				title = "Avertissement Batterie",
				text = "Batterie faible ! "..args[2].."% restant!\nBranchez vous sur le secteur.",
				timeout = 10,
				fg = beautiful.fg_urgent,
				bg = beautiful.bg_urgent
				})
			end
			bat_t:set_text("Niveau: " .. args[2] .. "% restant !\nEtat: " .. args[1] .. "\nTemps restant: " .. args[3] .."")
			if show_icons then
				if beautiful.widget_cpu then
					baticon.image = image(beautiful.widget_bat)
					return "<span color=\""..beautiful.fg_normal.."\" size=\"small\">".. args[2] .. "%</span>"
				else
					baticon.image = image(default_bat_img)
					return "<span color=\""..beautiful.fg_normal.."\" size=\"small\">".. args[2] .. "%</span>"
				end
			else
				return "<span color=\""..beautiful.bg_urgent.."\" size=\"small\">".. args[2] .. "%</span>"
			end
		end
	end, 61, Battery
)
-- }}}

-- {{{ Livarp Info HelpIcon
infoicon = wibox.widget.imagebox()
if infoicon_enable then
	if show_icons then
		if beautiful.widget_info then
			infoicon:set_image(beautiful.widget_info)
		else
			infoicon:set_image(default_info_img)
		end
		popups.help(infoicon,{ title_color = notify_font_color_1, lang = menu_lang})
	end
end
--}}}

-- {{{ Volume level
-- Sound Control
if vol_enable then
	require('couth.alsa')
	couth.CONFIG.ALSA_CONTROLS = {
		 'Master',
		 'PCM',
	}
	couth.CONFIG.NOTIFIER_FONT = monofont
	-----------------------------------------
	volicon = wibox.widget.imagebox()
	if vol_enable then
		if show_icons then
			if beautiful.widget_info then
				volicon:set_image(beautiful.widget_vol)
			else
				volicon:set_image(default_vol_img)
			end
		end

	volwidget = wibox.widget.textbox()
	vicious.register(volwidget, vicious.widgets.volume,
	function (widget, args)
		if args[1] == 0 or args[2] == "♩" then
			return "<span color=\""..beautiful.bg_urgent.."\" size=\"small\">mute</span>"
		else
			return "<span color=\""..beautiful.fg_normal.."\" size=\"small\">" .. args[1] .. "</span>"
		end
	end, 2, "Master" )

	volwidget:buttons(awful.util.table.join(
	awful.button({ }, 1, function () exec(couth.notifier:notify( couth.alsa:setVolume('Master','toggle'))) end),
	awful.button({ }, 4, function () exec(couth.notifier:notify( couth.alsa:setVolume('Master','3dB+'))) end),
	awful.button({ }, 5, function () exec(couth.notifier:notify( couth.alsa:setVolume('Master','3dB-'))) end),
	awful.button({ "Control" }, 1, function () exec(couth.notifier:notify( couth.alsa:setVolume('PCM','toggle'))) end),
	awful.button({ "Control" }, 4, function () exec(couth.notifier:notify( couth.alsa:setVolume('PCM','3dB+'))) end),
	awful.button({ "Control" }, 5, function () exec(couth.notifier:notify( couth.alsa:setVolume('PCM','3dB-'))) end),
	awful.button({ }, 3, function () exec(teardrop("urxvtc -T alsamixer -e alsamixer","center","center",800,390)) end)
	))
	volwidget:add_signal('mouse::enter', function () couth.notifier:notify( couth.alsa:getVolume() ) end)
	end
end
-- }}}

--{{{ MPD control widget
if mpd_enable then
local awesompd = require("awesompd/awesompd")
  musicwidget = awesompd:create() -- Create awesompd widget
  musicwidget.font = monofont -- Set widget font 
  musicwidget.scrolling = true -- If true, the text in the widget will be scrolled
  musicwidget.output_size = 30 -- Set the size of widget in symbols
  musicwidget.update_interval = 10 -- Set the update interval in seconds
  -- Set the folder where icons are located (change username to your login name)
  musicwidget.path_to_icons = os.getenv("HOME") .."/.config/awesome/awesompd/icons" 
  -- Set the default music format for Jamendo streams. You can change
  -- this option on the fly in awesompd itself.
  -- possible formats: awesompd.FORMAT_MP3, awesompd.FORMAT_OGG
  musicwidget.jamendo_format = awesompd.FORMAT_MP3
  -- If true, song notifications for Jamendo tracks and local tracks will also contain
  -- album cover image.
  musicwidget.show_album_cover = true
  -- Specify how big in pixels should an album cover be. Maximum value
  -- is 100.
  musicwidget.album_cover_size = 50
  -- This option is necessary if you want the album covers to be shown
  -- for your local tracks.
  musicwidget.mpd_config = os.getenv("HOME").."/.mpdconf"
  -- Specify the browser you use so awesompd can open links from
  -- Jamendo in it.
  musicwidget.browser = "firefox"
  -- Specify decorators on the left and the right side of the
  -- widget. Or just leave empty strings if you decorate the widget
  -- from outside.
  musicwidget.ldecorator = " "
  musicwidget.rdecorator = " "
  -- Set all the servers to work with (here can be any servers you use)
  musicwidget.servers = {
     { server = "localhost",
          port = 6600 } }
  -- Set the buttons of the widget
  musicwidget:register_buttons({ { "", awesompd.MOUSE_LEFT, musicwidget:command_toggle() },
      			         { "Control", awesompd.MOUSE_SCROLL_UP, musicwidget:command_prev_track() },
						 { "Control", awesompd.MOUSE_SCROLL_DOWN, musicwidget:command_next_track() },
						 { "", awesompd.MOUSE_SCROLL_UP, musicwidget:command_volume_up() },
						 { "", awesompd.MOUSE_SCROLL_DOWN, musicwidget:command_volume_down() },
						 { "", awesompd.MOUSE_RIGHT, musicwidget:command_show_menu() },
                         { "", "XF86AudioLowerVolume", musicwidget:command_volume_down() },
                         { "", "XF86AudioRaiseVolume", musicwidget:command_volume_up() },
                         { modkey, "Pause", musicwidget:command_playpause() } })
  musicwidget:run() -- After all configuration is done, run the widget
  
  musicwidget:append_global_keys()
  root.keys(globalkeys)
end
--}}}

--{{{ Moc Widget
-- Enable mocp*
musicicon = wibox.widget.imagebox()
	if show_icons then
		if beautiful.widget_music then
			musicicon:set_image(beautiful.widget_music)
		else
			musicicon:set_image(default_music_img)
		end
	end
	
tb_moc = wibox.widget.textbox()
tb_moc:set_align(right)

	function moc_control (action)
		local moc_info,moc_state
		 
		if action == "next" then
			io.popen("mocp --next")
		elseif action == "previous" then
			io.popen("mocp --previous")
		elseif action == "stop" then
			io.popen("mocp --stop")
		elseif action == "play_pause" then
			moc_info = io.popen("mocp -i"):read("*all")
			moc_state = string.gsub(string.match(moc_info, "State: %a*"),"State: ","")
		 
			if moc_state == "PLAY" then
				io.popen("mocp --pause")
			elseif moc_state == "PAUSE" then
				io.popen("mocp --unpause")
			elseif moc_state == "STOP" then
				io.popen("mocp --play")
			end
		end
	end

	function hook_moc()
		  fpid = io.popen("pgrep -o mocp")
		  pid = fpid:read("*n")
	fpid:close()

		  if pid then
		   moc_info = io.popen("mocp -i"):read("*all")
		   moc_state = string.gsub(string.match(moc_info, "State: %a*"),"State: ","")
		   if moc_state == "PLAY" or moc_state == "PAUSE" then
			   moc_artist = string.gsub(string.match(moc_info, "Artist: %C*"), "Artist: ","")
			   moc_title = string.gsub(string.match(moc_info, "SongTitle: %C*"), "SongTitle: ","")
			   moc_curtime = string.gsub(string.match(moc_info, "CurrentTime: %d*:%d*"), "CurrentTime: ","")
			   moc_totaltime = string.gsub(string.match(moc_info, "TotalTime: %d*:%d*"), "TotalTime: ","")
			   if moc_artist == "" then
				   moc_artist = "artiste inconnu"
			   end
			   if moc_title == "" then
				   moc_title = "titre inconnu"
			   end
				-- moc_title = string.format("%.5c", moc_title)
			   moc_string = "<span color=\""..beautiful.fg_normal.."\" size=\"small\">"..moc_artist .. " - " .. moc_title .. "(" .. moc_curtime .. "/" .. moc_totaltime .. ")</span>"
			   if moc_state == "PAUSE" then
				   moc_string = "<span color=\""..beautiful.fg_normal.."\" size=\"small\">PAUSE - " .. moc_string .. "</span>"
			   end
		   else
			   moc_string = "<span color=\""..beautiful.fg_normal.."\" size=\"small\">-- Lecture stoppée --</span>"
		   end
	else
		   moc_string = "<span color=\""..beautiful.fg_normal.."\" size=\"small\">Moc Stopped</span>"
		  end
		  return moc_string
	end
if moc_enable then	 
	-- refresh Moc widget
	moc_timer = timer({timeout = 1})
	moc_timer:add_signal("timeout", function() tb_moc.text = ' ' .. hook_moc() .. ' ' end)
	moc_timer:start()

	--moc widget buttons
	tb_moc:buttons(awful.util.table.join(
	awful.button({ }, 1, function () moc_control("play_pause") end),
	awful.button({ }, 2, function () exec(teardrop("urxvtc -T moc -e mocp","center","center",800,600)) end),
	awful.button({ }, 3, function () moc_control("stop") end),
	awful.button({ }, 4, function () moc_control("next") end),
	awful.button({ }, 5, function () moc_control("previous") end)	
	))
end
--}}}

--{{{ uptime widget
uptime = wibox.widget.textbox()
if uptime_enable then
	uptime_t = awful.tooltip({ objects = { uptime },})
	vicious.register(uptime, vicious.widgets.uptime,
	function (widget, args)
	uptime_t:set_text("Load : [".. args[4] .."/".. args[5] .."/".. args[6] .."]")
	return "<span color=\""..beautiful.fg_normal.."\" size=\"small\">Uptime : " .. args[1] .. "d " .. args[2] .. "h " .. args[3] .. "m </span>"
	end,60)
end
--}}}

--{{{Network widget
netupicon = wibox.widget.imagebox()
netdnicon = wibox.widget.imagebox()
	if show_icons then
		if beautiful.widget_netup then
			netupicon:set_image(beautiful.widget_netup)
			netdnicon:set_image(beautiful.widget_net)
		else
			netupicon:set_image(default_netup_img)
			netdnicon:set_image(default_netdn_img)
		end
	end
net = wibox.widget.textbox()
if net_enable then
	vicious.register(net, vicious.widgets.net,
	function (widget, args)
		local out = "<span color=\""..beautiful.fg_normal.."\" size=\"small\">Net :</span>"
		for line in io.lines("/proc/net/dev") do
			local name = string.match(line, "^[%s]?[%s]?[%s]?[%s]?([%w]+):")
			local received = tonumber(string.match(line, ":[%s]*([%d]+)"))
			if name ~= nil then
				if name ~= "lo" then
					if received ~= 0 then
						out = out .. " <span color=\""..beautiful.fg_normal.."\" size=\"small\">" .. name .."</span> <span color=\"red\" size=\"x-small\">up </span><span color=\"red\" size=\"small\">" .. args["{" .. name .." up_kb}"] .. "KB</span> / <span color=\"green\" size=\"small\">" .. args["{" .. name .." down_kb}"] .. "KB</span><span color=\"green\" size=\"x-small\"> dn</span>"
					end
				end
			end
		end
		return out
	end, 1)
	popups.netstat(net,{ title_color = notify_font_color_1, established_color= notify_font_color_2, listen_color=notify_font_color_3})	
end
--}}}

--{{{ Mail widget
-- put your gmail credentials in ~/.netrc file
-- syntax :
-- #machine mail.google.com login <e-mail address> password <password>

mygmail = wibox.widget.textbox()
gmail_t = awful.tooltip({ objects = { mygmail },})
if gmail_enable then
	vicious.register(mygmail, vicious.widgets.gmail,
					function (widget, args)
						gmail_t:set_text(args["{subject}"])
						return "<span color=\""..beautiful.fg_normal.."\" size=\"small\">Mail : " .. args["{count}"] .. "</span>"
					 end, 120)
					 --the '120' here means check every 2 minutes.
	mygmail:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn ( webcli .. " https://mail.google.com") end ) ) )
end
--}}}


--{{{ Apt Widget
aptwidget = wibox.widget.textbox()
aptwidget_t = awful.tooltip({ objects = { aptwidget},})

if apt_enable then
	vicious.register(aptwidget, vicious.widgets.pkg,
					function(widget,args)
						local io = { popen = io.popen }
						local s = io.popen("apt-show-versions -u -b")
						local str = ''

						for line in s:lines() do
							str = str .. line .. "\n"
						end
						aptwidget_t:set_text(str)
						s:close()
						return "<span color=\""..beautiful.fg_normal.."\" size=\"small\">Upd : " .. args[1] .. "</span>"
					end, 1800, "Debian")

					--'1800' means check every 30 minutes
	aptwidget:buttons(awful.util.table.join(awful.button({}, 3, function () teardrop("urxvtc -e update.sh", "bottom","center",800,100,true) end ) ) )
end
--}}}

--{{ Weather widget
-- Weather Widget ----------------------
weatherwidget = wibox.widget.textbox()
if weather_enable then 
	weather_t = awful.tooltip({ objects = { weatherwidget },})
	vicious.register(weatherwidget, vicious.widgets.weather,
					function (widget, args)
						weather_t:set_text("Ville: " .. args["{city}"] .."\nVent: " .. args["{windkmh}"] .. "km/h " .. args["{wind}"] .. "\nCiel: " .. args["{sky}"] .. "\nHumidité: " .. args["{humid}"] .. "%")
						return "<span color=\""..beautiful.fg_normal.."\" size=\"small\">" .. args["{tempc}"] .. "C</span>"
					end, 1800, weather_code)
					--'1800': check every 30 minutes.
					--'LFMK': the Carcassonne ICAO code.

	weatherwidget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn ( webcli .. " http://www.meteociel.fr/") end ) ) )                
end
--}}
--==============================================================--

-- PANEL CREATION --

--==============================================================--
-- Panel Config ----------------------------------------------
if invert_bar then
	mywibox[s] = awful.wibox({
		   position = "bottom",
		   screen = s,
		   height = beautiful.wibox_height,
		   border_color = beautiful.border_panel,
		   border_width = beautiful.border_width,
		   opacity = wibox_opacity
	 })
	 my_bottom_wibox[s] = awful.wibox({
		   position = "top",
		   screen = s,
		   height = beautiful.wibox_height,
		   border_color = beautiful.border_panel,
		   border_width = beautiful.border_width,
		    opacity = wibox_opacity
	 })
else
	mywibox[s] = awful.wibox({
		   position = "top",
		   screen = s,
		   height = beautiful.wibox_height,
		   border_color = beautiful.border_panel,
		   border_width = beautiful.border_width,
		    opacity = wibox_opacity
	 })
	 my_bottom_wibox[s] = awful.wibox({
		   position = "bottom",
		   screen = s,
		   height = beautiful.wibox_height,
		   border_color = beautiful.border_panel,
		   border_width = beautiful.border_width,
		    opacity = wibox_opacity
	 })
end
--------------------------------------------------------------

 mywibox[s].widgets = {
        {
            mylauncher,mytaglist[s],mylayoutbox[s],mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        spacer,
        s == 1 and mysystray or nil,
        spacer,
		datewidget,spacer,calicon,
		infoicon_enable and separator, infoicon or nil,
		vol_enable and separator or nil, vol_enable and volwidget or nil, vol_enable and volicon or nil,
		battery_enable and separator or nil, battery_enable and batwidget or nil, battery_enable and baticon or nil,
		separator, diskhomebar_enable and fsh or nil, diskrootbar_enable and fsr or nil, diskbootbar_enable and fsb or nil, diskrootbar_enable and fsicon or nil,
        mem_enable and separator or nil, memtext_enable and memtext or nil, mem_enable and memwidget or nil, mem_enable and memicon or nil,
        cputemp_enable and separator or nil, cputemp_enable and tzfound and tzswidget or nil,
		cpu_enable and separator or nil, cpu_enable and cpuwidget or nil, cpuicon,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }
    
    -- Add Widgets to the Panel ----------------------------------
    my_bottom_wibox[s].widgets = {
        {
        net_enable and net or nil, 
        net_enable and separator or nil, 
        apt_enable and aptwidget or nil, 
        apt_enable and separator or nil,
        gmail_enable and mygmail or nil, 
        gmail_enable and separator or nil, 
		weather_enable and weatherwidget or nil, 
		weather_enable and separator or nil,
		mpd_enable and musicicon or nil,
		mpd_enable and musicwidget.widget or nil,
		mpd_enable and separator or nil,
		moc_enable and musicicon or nil,
		moc_enable and tb_moc or nil,
		moc_enable and separator or nil,
		layout = awful.widget.layout.horizontal.leftright
        },
        uptime_enable and uptime or nil,
        layout = awful.widget.layout.horizontal.rightleft
    }
end
--------------------------------------------------------------

-- Wibox visibility
mywibox [1].visible = top_bar_visible
my_bottom_wibox[1].visible = bottom_bar_visible


-- SHIFTY: initialize shifty
-- the assignment of shifty.taglist must always be after its actually
-- initialized with awful.widget.taglist.new()
shifty.taglist = mytaglist
shifty.init()

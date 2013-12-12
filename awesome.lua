-- {{{ License
--
-- Awesome configuration, using awesome 3.4.6 on Livarp_0.3.9
--   * By Aphelion
--
-- This work is licensed under the GNU GPL version 3 
-- based off Adrian C. <anrxc@sysphere.org>'s rc.lua
--
-- }}}


-- useful for debugging, marks the beginning of rc.lua exec
print("Entered awesome.lua: " .. os.time())

home       = os.getenv("HOME")
config_dir = awful.util.getdir("config")
scount = screen.count()

-- Variables par défaut--
-- config.lua --
print("Entering config.lua: " .. os.time())
dofile(config_dir .."/config.lua")
-------------

-- {{{ Libraries
autofocus = require("awful.autofocus")
rules = require("awful.rules")
wibox = require("wibox")
-- Theme handling library
beautiful = require("beautiful")
-- Scratchpad
teardrop = require("teardrop")
-- shifty - dynamic tagging library
shifty = require("shifty")
-- helpers function
helpers = require("helpers")
-- }}}

-- Modkeys
print("Entering modkeys.lua: " .. os.time())
dofile(config_dir .."/config/modkey.lua")


-- Preffered apps
print("Entering prefferedapps.lua: " .. os.time())
dofile(config_dir .."/config/prefferedapps.lua")

-- tags.lua --
print("Entering tags.lua: " .. os.time())
if taglist == "dynamic" then
	dofile(config_dir .."/config/tags_dynamic.lua")
else 
	dofile(config_dir .."/config/tags_static.lua")
end
-----------------------------------------

-- menu.lua --
print("Entering menu.lua: " .. os.time())
if menu_lang == "fr" then
	dofile(config_dir .."/config/menu_fr.lua")
else 
	dofile(config_dir .."/config/menu_en.lua")
end
----------


-- Naughty configuration --
naughty.config.presets.normal.font = monofont
naughty.config.presets.normal.fg= beautiful.fg_focus
naughty.config.presets.normal.bg= beautiful.bg_focus
naughty.config.presets.normal.border_width= 1
naughty.config.presets.normal.border_color=beautiful.border_normal

-- widgets.lua --
print("Entering widgets.lua: " .. os.time())
if widget_mode == "graph" then
	dofile(config_dir .."/config/widgets_graph.lua")
else 
	dofile(config_dir .."/config/widgets_text.lua")
end
----------

-- Mouse bindings --
print("Entering mouse.lua: " .. os.time())
dofile(config_dir .."/config/mouse.lua")


-- Key bindings --
print("Entering keys.lua: " .. os.time())
dofile(config_dir .."/config/keys.lua")

-- client signals --
print("Entering signals.lua: " .. os.time())
dofile(config_dir .."/config/signals.lua")

-- useful for debugging, marks the beginning of rc.lua exec
print("Finish awesome.lua: " .. os.time())

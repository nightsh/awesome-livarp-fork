-- Window management layouts ---------
layouts = 
{
  awful.layout.suit.tile,        -- 1
  awful.layout.suit.tile.bottom, -- 2
  awful.layout.suit.fair,        -- 3
  awful.layout.suit.max,         -- 4
  awful.layout.suit.magnifier,   -- 5
  awful.layout.suit.floating     -- 6
}
--------------------------------------


tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
	if taglist_style == 'awesome' then
		shifty.config.tags = {
			["w"]   = { position = 1,  init = true, layout = layouts[1]},
			["e "]  = { position = 2,  init = true, layout = layouts[2]},
			["s"]   = { position = 3,  init = true, layout = layouts[3]},
			["o"]   = { position = 4,  init = true, layout = layouts[4]},
			["m"]   = { position = 5,  init = true, layout = layouts[5]},
			["e"]   = { position = 6,  init = true, layout = layouts[6]},
		}
	elseif taglist_style == 'east_arabic' then
		shifty.config.tags = {
			["١"]   = { position = 1,  init = true, layout = layouts[1]},
			["٢"]   = { position = 2,  init = true, layout = layouts[2]},
			["٣"]   = { position = 3,  init = true, layout = layouts[3]},
			["٤"]   = { position = 4,  init = true, layout = layouts[4]},
			["٥"]   = { position = 5,  init = true, layout = layouts[5]},
			["٦"]   = { position = 6,  init = true, layout = layouts[6]},
			["٧"]   = { position = 7,  init = true, layout = layouts[7]},
			["٨"]   = { position = 8,  init = true, layout = layouts[8]},
			["٩"]   = { position = 9,  init = true, layout = layouts[9]},
		}
	elseif taglist_style == 'persian_arabic' then
		shifty.config.tags = {
			["٠"]   = { position = 1,  init = true, layout = layouts[1]},
			["١"]   = { position = 2,  init = true, layout = layouts[2]},
			["٢"]   = { position = 3,  init = true, layout = layouts[3]},
			["٣"]   = { position = 4,  init = true, layout = layouts[4]},
			["۴"]   = { position = 5,  init = true, layout = layouts[5]},
			["۵"]   = { position = 6,  init = true, layout = layouts[6]},
			["۶"]   = { position = 7,  init = true, layout = layouts[7]},
			["٧"]   = { position = 8,  init = true, layout = layouts[8]},
			["٨"]   = { position = 9,  init = true, layout = layouts[9]},
			["٩"]   = { position = 10,  init = true, layout = layouts[10]},
		}
	elseif taglist_style == 'roman' then
		shifty.config.tags = {
			["I"]   = { position = 1,  init = true, layout = layouts[1]},
			["II"]   = { position = 2,  init = true, layout = layouts[2]},
			["III"]   = { position = 3,  init = true, layout = layouts[3]},
			["IV"]   = { position = 4,  init = true, layout = layouts[4]},
			["V"]   = { position = 5,  init = true, layout = layouts[5]},
			["VI"]   = { position = 6,  init = true, layout = layouts[6]},
			["VII"]   = { position = 7,  init = true, layout = layouts[7]},
			["VIII"]   = { position = 8,  init = true, layout = layouts[8]},
			["IX"]   = { position = 9,  init = true, layout = layouts[9]},
			["X"]   = { position = 10,  init = true, layout = layouts[10]},
		}
	else
		shifty.config.tags = {
			["#1"]   = { position = 1,  init = true, layout = layouts[2]},
			["#2"]   = { position = 2,  init = true, layout = layouts[2]},
			["#3"]   = { position = 3,  init = true, layout = layouts[2]},
			["#4"]   = { position = 4,  init = true, layout = layouts[2]},
			["#5"]   = { position = 5,  init = true, layout = layouts[2]},
			["#6"]   = { position = 6,  init = true, layout = layouts[2]},
			["#7"]   = { position = 7,  init = true, layout = layouts[2]},
			["#8"]   = { position = 8,  init = true, layout = layouts[2]},
			["#9"]   = { position = 9,  init = true, layout = layouts[2]},
		}
	end
end

-- client rules --
dofile(config_dir .."/config/rules_static.lua")
----------

-- SHIFTY: default tag creation rules
-- parameter description
--  * floatBars : if floating clients should always have a titlebar
--  * guess_name : should shifty try and guess tag names when creating
--                 new (unconfigured) tags?
--  * guess_position: as above, but for position parameter
--  * run : function to exec when shifty creates a new tag
--  * all other parameters (e.g. layout, mwfact) follow awesome's tag API
shifty.config.defaults = {
    layout = awful.layout.suit.tile,
    ncol = 1,
    mwfact = 0.60,
    guess_name = false,
    guess_position = false,
}
--focus on client hovering
shifty.config.sloppy = false
--titlebar only on floating client
shifty.config.float_bars = true
--shifty.config.honorsizehints = false

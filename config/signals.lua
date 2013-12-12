----------
-- Signal function to execute when a new client appears.
--

-- {{{ Manage signal handler
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
	   --[[c:connect_signal("mouse::enter", function(c)
			   if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
			   and awful.client.focus.filter(c) then
			   client.focus = c
			end
		 end)]]
    -- Client placement
		if not startup then
			awful.client.setslave(c)
			if  not c.size_hints.program_position
			and not c.size_hints.user_position then
				awful.placement.no_overlap(c)
				awful.placement.no_offscreen(c)
			end
		end
	-- titlebar
	    if enable_titlebar then
        -- Add a titlebar
        awful.titlebar.add(c, { modkey = modkey, height = beautiful.titlebar_height })
    end
end)
-- }}}
 
-- Hook function to execute when focusing a client.
client.connect_signal("focus", function(c)
    if not awful.client.ismarked(c) then
        c.border_color = beautiful.border_focus
    end
end)

-- Hook function to execute when unfocusing a client.
client.connect_signal("unfocus", function(c)
    if not awful.client.ismarked(c) then
        c.border_color = beautiful.border_normal
    end
end)

-- {{{ Arrange signal handler
for s = 1, scount do screen[s]:connect_signal("arrange", function ()
    local clients = awful.client.visible(s)
    local layout = awful.layout.getname(awful.layout.get(s))
 
    for _, c in pairs(clients) do -- Floaters are always on top
        if   awful.client.floating.get(c) or layout == "floating"
        then if not c.fullscreen then c.above       =  true  end
        else                          c.above       =  false end
    end
  end)
end
-----------------------------------------

----------
-- Mouse bindings -------------------------------------------
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

-- opération a la souris sur les clients
clientbuttons = awful.util.table.join(
    awful.button(k_m, 1, function (c) client.focus = c; c:raise() end),
    awful.button(k_m, 1, awful.mouse.client.move),
    awful.button(k_m, 3, awful.mouse.client.resize))
-----------------------------------------

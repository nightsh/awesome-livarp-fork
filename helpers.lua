-- {{{ Helper functions

function run_once(prg,arg_string,pname,screen)
	if not prg then
		do return nil end
	end

	if not pname then
		pname = prg
	end

	if not arg_string then 
		awful.util.spawn_with_shell("pgrep -f -u $USER -x '" .. pname .. "' || (" .. prg .. ")",screen)
	else
		awful.util.spawn_with_shell("pgrep -f -u $USER -x '" .. pname .. "' || (" .. prg .. " " .. arg_string .. ")",screen)
	end
end

function dbg(vars)
	local text = ""
	if type(vars) == "table" then
		for i=1, #vars do text = text .. vars[i] .. " | " end
	elseif type(vars) == "string" then
		text = vars
	end
	naughty.notify({ text = text, timeout = 0 })
end

function clean(string)
	s = string.gsub(string, '^%s+', '')
	s = string.gsub(s, '%s+$', '')
	s = string.gsub(s, '[\n\r]+', ' ')
	return s
end

function file_exists(file)
	local cmd = "/bin/bash -c 'if [ -e " .. file .. " ]; then echo true; fi;'"
	local fh = io.popen(cmd)

	s = clean(fh:read('*a'))

	if s == 'true' then return true else return nil end
end

--% Find the path of an application, return nil of doesn't exist
----@ app (string) Text of the first parameter
----@ return string of app path, or nil (remember, only nil and false is false in lua)
function whereis_app(app)
	local fh = io.popen('which ' .. app)
	s = clean(fh:read('*a'))

	if s == "" then return nil else return s end
	return s
end

function require_safe(lib)
	if file_exists(awful.util.getdir("config") .. '/' .. lib ..'.lua') or
		file_exists(awful.util.getdir("config") .. '/' .. lib) then
			require(lib)
	end
end


----------------------------------------------------------------------
-- Themes define colours, icons, and wallpapers
-- Variables ---

-- Theme -------------------------------------------------------------
theme      = "current_theme"
theme_path = config_dir .. "/" .. theme .. "/theme.lua"
beautiful.init(theme_path)
----------------------------------------------------------------------


--Menu for choose between all your theme
mythememenu = {}
function theme_load(theme)
  local cfg_path = awful.util.getdir("config")
  -- Create a symlink from the given theme to /home/user/.config/awesome/current_theme
  awful.util.spawn("ln -sfn " .. cfg_path .. "/themes/" .. theme .. " " .. cfg_path .. "/current_theme")
  awesome.restart()
end
function theme_menu()
-- List your theme files and feed the menu table
  local cmd = "ls -1 " .. awful.util.getdir("config") .. "/themes/"
  local f = io.popen(cmd)
  for l in f:lines() do
    local item = { l, function () theme_load(l) end }
    table.insert(mythememenu, item)
  end
  f:close()
end
-- Generate your table at startup or restart
theme_menu()


-- Wallpapers
mywallmenu = {}
function wallpaper_load(wall)
  local cfg_path = awful.util.getdir("config")
  -- Create a symlink from the given theme to /home/user/.config/awesome/current_wallpaper
  awful.util.spawn("ln -sfn " .. wallpapers .. "/" .. wall .. " " .. home .. "/.config/awesome/current_wallpaper")
  awful.util.spawn("feh --bg-fill " .. wallpapers .. "/" .. wall)
end
function wallpaper_menu()
-- List your theme files and feed the menu table
  local cmd = "ls -1 " .. wallpapers
  local f = io.popen(cmd)
  for l in f:lines() do
    local item = { l, function () wallpaper_load(l) end }
    table.insert(mywallmenu, item)
  end
  f:close()
end
-- Generate your table at startup or restart
wallpaper_menu()

-- }}}

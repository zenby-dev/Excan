local _print = print
local Console = require "console"
console = nil
input   = nil
output  = nil

local console_active = false

local debug = debug
local function error_handler(msg)
	print((debug.traceback("Error: " .. msg, 4):gsub("\t", "    ")))
end

local handler_names = {
	kr = 'keyreleased',
	mp = 'mousepressed',
	mr = 'mousereleased',
	jp = 'joystickpressed',
	jr = 'joystickreleased',
	f = 'focus',
}

function love.run()
	if love.load then xpcall(function() love.load(arg) end, error_handler) end

	--love.keyboard.setKeyRepeat(150, 50)
	love.graphics.setBackgroundColor(34,34,34)
	local font = love.graphics.newFont('VeraMono.ttf', 14)
	console = Console.new(font)

	print("|  '/\\'\\  / /_\\  __  /' /\\ |\\ | /_ /\\ |   /_\\")
	print("|__ \\/  \\/  \\_       \\, \\/ | \\|  / \\/ |__ \\_   (v.1e-127)")
	print()
	print("<Escape> toggles the console. Call quit() or exit() to quit.")
	print("Try hitting <Tab> to complete your current input.")
	print("You can overwrite every love callback (but love.keypressed).")
	print()
	
	--if love.load then xpcall(function() love.load(arg) end, error_handler) end

	local dt = 0

	-- Main loop time.
	while true do
		if love.timer then
			love.timer.step()
			dt = love.timer.getDelta()
		end
		if love.update then if not xpcall(function() love.update(dt) end, error_handler) then love.update = nil end end -- will pass 0 if love.timer is disabled
		if love.graphics then
			love.graphics.clear()
			local g = love.graphics

			g.push()

			--[[try(function()

			local w, h = love.graphics.getWWidth(), love.graphics.getWHeight()

			if SETTINGS and SETTINGS.RESOLUTION and w ~= 0 and h ~= 0 then

				if SETTINGS.RESOLUTION.x == 0 then

					SETTINGS.RESOLUTION.x = w

				end

				if SETTINGS.RESOLUTION.y == 0 then

					SETTINGS.RESOLUTION.y = h

				end

				local function saferes()
					local x = (SETTINGS.RESOLUTION.x or 800)
					if x == 0 then x = SETTINGS.WINDOWSIZE.x end
					local y = (SETTINGS.RESOLUTION.y or 600)
					if y == 0 then y = SETTINGS.WINDOWSIZE.y end
					return Vec2()
				end

				g.scale(w / (SETTINGS.RESOLUTION.x or 800), h / (SETTINGS.RESOLUTION.y or 600))

			end

			end)]]
			--if not PRES then print(w / (SETTINGS.RESOLUTION.x or 800), h / (SETTINGS.RESOLUTION.y or 600)) PRES = true end

			if love.draw then if not xpcall(function() love.draw() end, error_handler) then love.draw = nil end end

			g.pop()

			if console_active then
				love.graphics.setScissor(2,2, g.getWWidth()-4, g.getWHeight()-4)
				local color = {love.graphics.getColor()}
				love.graphics.setColor(34,34,34,180)
				love.graphics.rectangle('fill', 2,2, g.getWWidth()-4, g.getWHeight()-4)
				love.graphics.setColor(221,221,221)
				console:draw(4, g.getWHeight() - 4)
				love.graphics.setColor(unpack(color))
				love.graphics.setScissor(0, 0, g.getWWidth(), g.getWHeight())
			end

		end

		-- Process events.
		if love.event then
			for e,a,b,c in love.event.poll() do
				if e == "q" then
					if not love.quit or not love.quit() then
						if love.audio then
							love.audio.stop()
						end
						return
					end
				elseif e == "kp" then
					--love.keyboard.setKeyRepeat(250, 100) --STAY AT THIS ANYTHING ELSE SUUUUUCKS
					if not console_active then

						if love.keypressed then
							-- if exists, call love.keypressed. on error, remove function
							KeyPressed(a, b)
							try(function() love.keypressed(a, b) end)
						end


					else

						console:keypressed(a,b)

					end

					if a == 'f1' then
						console_active = not console_active
					end

					if a == 'f12' then love.event.push("q") end
				end
				love.handlers[e](a,b,c)
			end
		end

		if love.timer then love.timer.sleep(0.001) end
		if love.graphics then love.graphics.present() end

	end
end

function print(...)
	return console:print(...)
end

function printf(fmt, ...)
	return print(string.format(fmt, ...))
end

function quit()
	love.event.push('q')
end
exit = quit

function try(f, ef)

	local s, e = pcall(f)
	if not s then
		if ef then
			ef(e)
		else
			print(debug.traceback("Error: " .. e, 4):gsub("\t", "    "))
		end
	end

	return e

end

function love.load() --LEF loading
	love.filesystem.setIdentity("Excan")
	math.randomseed(os.time()) --Set up a random seed
	math.random() math.random() math.random() --toss the salad

	function include(dir) --Not much slower, allows for re-loading of files.
	
		local s, e = pcall(love.filesystem.load(dir)) --safety.
		if not s then error(e) end
		return e
	
	end
	
	local olr = require
	function require(f)
	
		if string.sub(f, -4, -1) == ".lua" then
		
			return olr(string.sub(f, 1, -5))
			
		else
		
			return olr(f)
			
		end
	
	end
	
	function requiredir(dir) --spacesaver 9000

		for k, v in pairs(love.filesystem.enumerate(dir)) do
			if love.filesystem.isFile(dir.."/"..v) then
				include(dir.."/"..v)
			end
		end

	end

	goo = include("goo/goo.lua")
	goo:load()

	requiredir("/ext") --load them extensions
	require("mods/loader.lua") --load mods
	
	ents = {} --ents.
	fontsize = 12 --the basic font size
	sfont = love.graphics.newFont('VeraMono.ttf', 32) --basic font

	LoadSettings()

	--require("conf") --load conf

	--TEXTFRMBUFFER = love.graphics.newCanvas(love.graphics.getWidth(), love.graphics.getHeight())

	love.keyboard.setKeyRepeat(250, 50)

	include("game/main.lua") --load the game
	
	hook.Call("Init") --call init
end

function love.update(dt) --update wrapper

	goo:update(dt)

	ParticleSys.Update() --update particle system wrapper
	
	hook.Call("Update", dt) --call update

end

function SetColor(c) --set color using my color class

	love.graphics.setColor(c.r, c.g, c.b, c.a)

end

function love.draw()

	hook.Call("Draw") --call draw

	hook.Call("DrawGUI") --draw AFTER

	goo:draw()

end

function love.mousepressed(x, y, b) --and more wrappers. whee

	hook.Call("MousePressed", x, y, b)

	try(function() goo:mousepressed(x, y, b) end)

end

function love.mousereleased(x, y, b)

	hook.Call("MouseReleased", x, y, b)

	try(function() goo:mousereleased(x, y, b) end)

end

function love.keypressed(key, uni)

	--print(key, uni)
	--hook.Call("KeyPressed", key, uni)
	--try(function() goo:keypressed(key, uni) end)

end

function KeyPressed(key, uni)

	hook.Call("KeyPressed", key, uni)
	try(function() goo:keypressed(key, uni) end)

end

function love.keyreleased(key, uni)

	hook.Call("KeyReleased", key)
	try(function() goo:keyreleased(key, uni) end)

end

function love.focus(f)

	hook.Call("Focus", f)

end

function getRWidth()

	return SETTINGS.RESOLUTION.x

end

function getRHeight()

	return SETTINGS.RESOLUTION.y

end

love.graphics.getWWidth, love.graphics.getWHeight = love.graphics.getWidth, love.graphics.getHeight

--[[function love.graphics.getWidth()

	return SETTINGS.RESOLUTION.x

end

function love.graphics.getHeight()

	return SETTINGS.RESOLUTION.y

end]]

function ResToWind()

	local w, h = love.graphics.getWWidth(), love.graphics.getWHeight()

	if w == 0 or h == 0 then return Vec2(1, 1) end

	if SETTINGS.RESOLUTION.x == 0 then

		SETTINGS.RESOLUTION.x = w

	end

	if SETTINGS.RESOLUTION.y == 0 then

		SETTINGS.RESOLUTION.y = h

	end

	return Vec2(w / (SETTINGS.RESOLUTION.x or 800), h / (SETTINGS.RESOLUTION.y or 600))

end

function WindToRes()

	local w, h = love.graphics.getWWidth(), love.graphics.getWHeight()

	if w == 0 or h == 0 then return Vec2(1, 1) end

	if SETTINGS.RESOLUTION.x == 0 then

		SETTINGS.RESOLUTION.x = w

	end

	if SETTINGS.RESOLUTION.y == 0 then

		SETTINGS.RESOLUTION.y = h

	end

	return Vec2((SETTINGS.RESOLUTION.x or 800) / w, (SETTINGS.RESOLUTION.y or 600) / h)

end


--[[love.graphics.oprint = love.graphics.print

function love.graphics.print(t, x, y, r, sx, sy)

	if not TEXTFRMBUFFER then return end

	local g = love.graphics
	g.push()

	local ts = WindToRes()
	g.scale(ts.x, ts.y)

	TEXTFRMBUFFER:renderTo(function()

		love.graphics.oprint(t, x, y, r, sx, sy)

	end)

	g.pop()

	ts = ResToWind()
	g.draw(TEXTFRMBUFFER, 0, 0)

end]]

function LoadSettings()

	SETTINGS = loadtable("config/settings.lua")
	if SETTINGS.FULLSCREEN then
		love.graphics.setMode(0, 0, true, SETTINGS.VSYNC, SETTINGS.FSAA)
	else
		love.graphics.setMode(SETTINGS.RESOLUTION.x, SETTINGS.RESOLUTION.y, false, SETTINGS.VSYNC, SETTINGS.FSAA)
	end

end
---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 11/28/11
-- Time: 5:43 PM
--

Menu = {} --ZenX2's menu class. again, dangerous.

Menu.Buttons = {} --Buttons
Menu.Inputs = {}
Menu.Images = {} --Images
Menu.Font = love.graphics.newFont('VeraMono.ttf', 24)

--Menu.LFont = love.graphics.newFont('VeraMono.ttf', 18)

Menu.Open = false --Is a menu open?
Menu.OnMainMenu = false --is it the main menu?

Menu.Holder = goo.null:new()

function Menu.Button(p, t, f) --create a button

	local button = goo.menubutton:new(Menu.Holder)
	button:setPos(p.x, p.y)
	button:setText(t)
	button:sizeToText()
	button.onClick = f

	table.insert(Menu.Buttons, button)

end

function Menu.Input(p, t, f) --create a button

	local textinput = goo.textinput:new(Menu.Holder)
	local tip = p + Vec2(Menu.Font:getWidth(t) + 5, 7)
	textinput:setPos(tip.x, tip.y)
	textinput:setSize(100, textinput.fontH + 3)
	function textinput:onKeyReturn(text)

		f(text)

	end

	table.insert(Menu.Inputs, {t, p, textinput})

end

function Menu.Image(p, pa)

	local im = Image(pa, p)
	table.insert(Menu.Images, im)

end

function Menu.ButtonVisibility(b)

	for k, v in pairs((Menu.Buttons or {})) do

		v:setVisible(b)

	end

end

function Menu.Clear() --no moar buttons

	for k, v in pairs(Menu.Buttons) do

		v:removeFromParent()

	end
	Menu.Buttons = {}
	for k, v in pairs(Menu.Inputs) do

		v[3]:removeFromParent()

	end
	Menu.Inputs = {}
	for k, v in pairs(Menu.Images) do

		v:Remove()

	end
	Menu.Images = {}

end

function GoToMainMenu()

	hook.Call("Init")

end

local function Draw()

	if not Menu.Open then Menu.ButtonVisibility(false) return end
	Menu.ButtonVisibility(true)

	local g = love.graphics

	for k, v in pairs(Menu.Inputs) do

		g.setFont(Menu.Font)
		g.print(v[1], v[2].x, v[2].y)

	end

	--love.graphics.setFont(Menu.LFont)
	--[[for k, v in pairs(Menu.Buttons) do

		local x, y = love.mouse.getPosition()

		if x >= v[1].x and x <= v[1].x + 300 and y >= v[1].y and y <= v[1].y + 18 then

			love.graphics.setColor(255, 255, 255, 255)

		else

			love.graphics.setColor(255, 255, 255, 150)

		end

		love.graphics.print(v[2], v[1].x, v[1].y)

	end]]

	love.graphics.setColor(255, 255, 255, 255)

end

--[[Menu.Levels = {} --I use this for TopWise

for k, v in pairs(love.filesystem.enumerate("/game/maps")) do
	if love.filesystem.isFile("/game/maps/"..v) and string.sub(v, -4, -1) == ".xml" then
		table.insert(Menu.Levels, "game/maps/"..v)
	end
end]]

--[[local function Draw() --draw, I don't know why it isn't in the hook definition

	if not Menu.Open then return end

	love.graphics.setFont(Menu.LFont)
	for k, v in pairs(Menu.Buttons) do

		local x, y = love.mouse.getPosition()

		if x >= v[1].x and x <= v[1].x + 300 and y >= v[1].y and y <= v[1].y + 18 then

			love.graphics.setColor(255, 255, 255, 255)

		else

			love.graphics.setColor(255, 255, 255, 150)

		end

		love.graphics.print(v[2], v[1].x, v[1].y)

	end

	love.graphics.setColor(255, 255, 255, 255)

end]]

function Menu.Main()

	Menu.OnMainMenu = true
	Menu.Open = true
	Menu.Clear()

	--[[Menu.Button(Vec2(), "", function()



	end)]]

	--Menu.Image(Vec2(350, 40), "resources/polycode_logo.png")

	local function h(i) return 40 + (i * 60) end

	Menu.Button(Vec2(20, h(0)), "New Game", function()

		Menu.Clear()
		Menu.OnMainMenu = false
		StartNewGame()

	end)

	Menu.Button(Vec2(20, h(1)), "Load Game", function()



	end)

	Menu.Button(Vec2(20, h(3)), "Options", function()

		Menu.Options()

	end)

	Menu.Button(Vec2(20, h(5)), "Exit", function()

		love.event.push("q")

	end)

end

function Menu.Options() --the ingame version of the menu

	Menu.Clear()

	local saved = false

	local function h(i) return 40 + (i * 60) end

	local function OF(b)
		return b and "On" or "Off"
	end

	local ts = {}

	for k, v in pairs(SETTINGS) do

		ts[k] = v
		if type(v) == "table" and v.__type == "Vec2" then

			ts[k] = Vec2(v.x, v.y)

		end

	end

	local function save()
		local tstr = tabletostring(ts)
		local fs = love.filesystem

		fs.mkdir("config")

		fs.write("config/settings.lua", tstr)

		LoadSettings()

		saved = true
	end

	local function createbuttons()

		local function reload()
			Menu.Clear()
			createbuttons()
		end

		Menu.Button(Vec2(20, h(0)), "Fullscreen: ["..OF(ts.FULLSCREEN).."]", function()
			ts.FULLSCREEN = not ts.FULLSCREEN
			reload()
		end)

		Menu.Button(Vec2(20, h(1)), "Enable VSYNC: ["..OF(ts.VSYNC).."]", function()
			ts.VSYNC = not ts.VSYNC
			reload()
		end)

		Menu.Input(Vec2(20, h(2)), "FSAA Buffers ["..ts.FSAA.."] (0 - 10, default 0): ", function(text)
			local num = tonumber(text)

			if num < 0 or num > 10 then return end

			ts.FSAA = num
			reload()
		end)

		local resx = ts.RESOLUTION.x.." ("..love.graphics.getWidth()..")"

		Menu.Input(Vec2(20, h(3)), "Resolution X ["..resx.."]: ", function(text)
			local num = tonumber(text)

			if num < 0 or num > 5000 then return end --set manually if you want to go higher

			ts.RESOLUTION.x = num
			reload()
		end)

		local resy = ts.RESOLUTION.y.." ("..love.graphics.getHeight()..")"

		Menu.Input(Vec2(20, h(4)), "           Y ["..resy.."]: ", function(text)
			local num = tonumber(text)

			if num < 0 or num > 5000 then return end --set manually if you want to go higher

			ts.RESOLUTION.y = num
			reload()
		end)

		Menu.Button(Vec2(20, h(5)), "Save & Apply Changes", function()

			save()
			reload()

		end)

		local function leavemenu()
			if Menu.OnMainMenu then
				GoToMainMenu()
			else
				Menu.InGame()
			end
		end

		Menu.Button(Vec2(20, h(6)), "Back", function()

			if not saved then

				YesNoBox("Save Changes?",
				function()
					save()
					leavemenu()
				end,
				function()
					leavemenu()
				end,
				true)

			else

				leavemenu()

			end

		end)

	end

	createbuttons()

end

function Menu.InGame() --the ingame version of the menu

	Menu.Clear()

	local function h(i) return 40 + (i * 60) end

	--[[Menu.Button(Vec2(), "", function()



	end)]]

	--[[Menu.Button(Vec2(40, 240), "Load Map", function()

		Menu.LevelLoader(1)

	end)]]

	Menu.Button(Vec2(20, h(3)), "Options", function()

		Menu.Options()

	end)

	Menu.Button(Vec2(20, h(4)), "Main Menu", function()

		GoToMainMenu()

	end)

end

--[[function Menu.LevelLoader(n, m) --my implementaion of a multi page menu

	Menu.Clear()

	for i = 0, 4 do

		if Menu.Levels[n + i] then

			local name, desc, gamemode = LevelInfo(Menu.Levels[n + i])

			Menu.Button(Vec2(40, 180 + (40 * i)), name.." - "..desc, function()

				local function levelopt()

					Menu.Clear()

					local gmte = TextEntry(Vec2(40, 300))
					gmte:EnterFunc(function(txt)

						gamemode = txt
						SetTextEntry(nil)
						levelopt()

					end)

					Menu.Button(Vec2(40, 260), "Game Mode: "..gamemode, function()

						SetTextEntry(gmte)

					end)

					Menu.Button(Vec2(40, 340), "Play", function()

						LoadMapFromXML(Menu.Levels[n + i], gamemode)
						Menu.Clear()
						Menu.Open = false
						Menu.OnMainMenu = false
						Pause(false)
						SetTextEntry(nil)

					end)

					Menu.Button(Vec2(40, 380), "Back", function()

						Menu.LevelLoader(n, m)
						SetTextEntry(nil)

					end)

				end

				levelopt()

			end)

		end

	end

	if #Menu.Levels > n + 4 then

		Menu.Button(Vec2(40, 380), "-->", function()

			Menu.LevelLoader(n + 1, m)

		end)

	end

	if n - 1 > 0 then

		Menu.Button(Vec2(40, 140), "<--", function()

			Menu.LevelLoader(n - 1, m)

		end)

	end

	if m then

		Menu.Button(Vec2(40, 100), "Back", function()

			include("game/main.lua")
			Menu.Main()

		end)

	else

		Menu.Button(Vec2(40, 100), "Back", function()

			Menu.InGame()

		end)

	end

end]]

hook.Add("KeyPressed", "toggleingamemenu",
function(key)

	if key == "escape" and Menu.OnMainMenu == false and not BLOCKMENU then

		Menu.Open = not Menu.Open
		if Menu.Open then
			Menu.InGame()
			Pause(true)
		else
			Menu.Clear()
			Pause(false)
		end
		
	end

end)

hook.Add("DrawGUI", "DrawMenu", Draw)
requiredir("/game/ext")
requiredir("/game/ents")

function GameHooks.Init()
	
	try(Menu.Main)

	--GAME VARIABLES
	pause = false

	--love.mouse.setVisible(false) --grabbing and changing the mouse
	--love.mouse.setGrab(true)
	--CursorImage = Image("game/sprites/crosshair.png", Vec2(love.mouse.getPosition()))
	--CursorImage:SetOrigin(Vec2(16, 16))

	CameraPos = Vec2(0, 0) --the position of the camera (IMPORTANT!!!!)

	love.graphics.setBackgroundColor(34, 34, 34)

	--DERP

end

--Menu.Main() --If you want to use my menu system, go ahead
--Menu.Open = true

function Pause(b) --functioning pausing, can change window title

	pause = b

end

function GameHooks.Update(dt) --default update

	--CursorImage:SetPos(Vec2(love.mouse.getPosition()))

	if pause then return end --necissary for pausing

	if World then World:update(dt) end

	for k, v in pairs(ents) do

		v:Update(dt)

	end
	
	--Update stuff

end

function GameHooks.Draw() --default draw

	local g = love.graphics --wheee

	g.push()
	
	g.translate(-CameraPos.x, -CameraPos.y) --should be with all world elements
	
	for k, v in pairs(ents) do

		v:Draw()

	end
	
	g.pop()
	
	--CursorImage:Draw() --Should be last to draw, if you're using it

end
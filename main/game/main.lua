requiredir("/game/ext")
requiredir("/game/ents")

function GameHooks.Init()

	SetState("") --base state.

	try(Menu.Main)

	--GAME VARIABLES
	pause = false

	CameraPos = Vec2(0, 0) --the position of the camera (IMPORTANT!!!!)

	love.graphics.setBackgroundColor(34, 34, 34)

	--DERP

	background = {}
	foreground = {}

	ClearMap()

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

end

function GameHooks.Draw() --default draw

end
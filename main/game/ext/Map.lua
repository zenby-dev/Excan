---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 1/8/12
-- Time: 2:42 PM
--

function Map(path, state)

	--Create World
	local oldstate
	if GetState() ~= state then oldstate = GetState() SetState(state) end
	World = CreatePhysWorld(Vec2(0, 50))
	World:setCallbacks(--Fixture A, Fixture B, Contact, normal impulse, tangent impulse
	function (fa, fb, co, ni, ti) --Begin
		local ae = ents[fa:getUserData()]
		local be = ents[fb:getUserData()]
		ae:Collide(fb, co)
		be:Collide(fa, co)
	end,

	function (fa, fb, co, ni, ti) --end

	end,

	function (fa, fb, co, ni, ti) --presolve

	end,

	function (fa, fb, co, ni, ti) --postsolve

	end)

	ClearMap()

	LoadMapFile(path)

	if oldstate then SetState(oldstate) end

end

function ClearMap(state)

	local oldstate
	if GetState() ~= state and state ~= nil then oldstate = GetState() SetState(state) end

	CameraFocus = nil

	for k, v in pairs(ents) do

		v:Remove()

	end

	if oldstate then SetState(oldstate) end

end
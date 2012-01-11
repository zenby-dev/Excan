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
	World = CreatePhysWorld(Vec2(0, 200)) --should be based on the smallest and largest parts of the map (or two insanely large vectors)

	LoadMapFile(path)

	if oldstate then SetState(oldstate) end

end

function ClearMap()

	local oldstate
	if GetState() ~= state then oldstate = GetState() SetState(state) end

	for k, v in pairs(ents) do

		v:Remove()

	end

	if oldstate then SetState(oldstate) end

end
CurrentState = ""
CameraFocuses = {}

function SetState(s)

	if s == nil then error("Whoa, problem with this here state: '"..tostring(s).."'") return end

	CurrentState = s

	if Ents == nil then Ents = {} end
	if Ents[s] == nil then Ents[s] = {} end
	if not Worlds then Worlds = {} end
	ents = Ents[s]
	
	--if Levels[s] then Level = Levels[s] InitLevel(s) end

end

function GetState()

	return CurrentState

end

function StateIs(s)

	return GetState() == s

end

function SetCameraFocus(e, s)

	local s = s and s or GetState()
	CameraFocuses[s] = e

end

function GetCameraFocus(s)

	local s = s and s or GetState()
	return CameraFocuses[s]

end
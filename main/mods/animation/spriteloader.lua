function LoadSprite(path) --This makes everything INSANELY easy, just define the specifications of a sprite in an XML file, load it up.

	try(function() love.filesystem.exists(path) end)

	local tab = loadtable(path)

	try(function() love.filesystem.exists(tab.path) end)

	local dyn = DynSprite()

	if tab.pos then dyn:SetPos(tab.pos) end

	for _, anim in pairs(tab.con) do

		local frames = {}
		for _, frame in pairs(anim.con) do

			local i = Image(tab.path)
			i:SetOrigin(frame.origin)
			i:SetSS(frame.ss)
			i:SetAnim(frame.anim)
			table.insert(frames, i)

		end

		local a = Animation(tab.pos, frames)
		a:SetSpeed(anim.speed)
		dyn:AddAnim(anim.name, a)

	end

	return dyn

end

function string:split(delimiter)
	local result = {}
	local from  = 1
	local delim_from, delim_to = string.find( self, delimiter, from  )
	while delim_from do
		table.insert( result, string.sub( self, from , delim_from-1 ) )
		from  = delim_to + 1
		delim_from, delim_to = string.find( self, delimiter, from  )
	end
	table.insert( result, string.sub( self, from  ) )
	return result
end
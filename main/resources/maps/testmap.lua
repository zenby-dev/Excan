---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 1/9/12
-- Time: 9:04 PM
--

return
{
	name = "Test Map",
	con =
	{
		{
			__type = "Scenery",
			path = "resources/sprites/player.lua",
			pos = Vec2(0, 0),
			layer = 0,
			scale = Vec2(10, 10),
			anim = "walk",
		},
		{
			__type = "foreground",
			path = "resources/maps/bfgrounds/testbg2.png",
			scale = Vec2(1, 1),
			depth = .5,
		},
		{
			__type = "background",
			path = "resources/maps/bfgrounds/testbg.png",
			scale = Vec2(2, 2),
			depth = 2,
		},
		{
			__type = "Solid",
			pos = Vec2(0, 960),
			size = Vec2(1280, 90)
		}
	}
}
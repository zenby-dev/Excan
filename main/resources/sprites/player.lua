---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 1/9/12
-- Time: 9:04 PM
--

return
{
	pos = Vec2(0, 0),
	path = "resources/sprites/basic.png",
	con =
	{
		{
			name = "",
			speed = 1,
			con = {
				{
					origin = Vec2(0, 0),
					ss = Vec2(16, 16),
					anim = Vec2(0, 0)
				}
			}
		},

		{
			name = "walk",
			speed = .25,
			con = {
				{
					origin = Vec2(0, 0),
					ss = Vec2(16, 16),
					anim = Vec2(16, 0)
				},
				{
					origin = Vec2(0, 0),
					ss = Vec2(16, 16),
					anim = Vec2(32, 0)
				}
			}
		}
	}
}
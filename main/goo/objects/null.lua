-- NULL OBJECT
goo.null = mclass('goo null', goo.object)
function goo.null:initialize( parent )
	super.initialize(self)
end

return goo.null
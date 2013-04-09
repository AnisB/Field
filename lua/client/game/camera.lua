--[[ 
This file is part of the Field project
]]

require("const")
Camera = {}
Camera.__index =  Camera

function Camera.new(ax,ay)
    local self = {}
    setmetatable(self, Camera)
    self.position= {x=ax,y=ay}
    return self
end


function Camera:update(dt)

end

function Camera:newPosition(ax,ay)
    self.position.x=ax
    self.position.y=ay
end

function Camera:getPos()
	return self.position
end

function Camera:handlePacket( string )
	t={}
	for v in string.gmatch(string, "[^#]+") do
		table.insert(t,v)
	end
	self.position.x=tonumber(t[2])
	self.position.y=tonumber(t[3])

end

function Camera:draw()
end
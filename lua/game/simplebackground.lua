--[[ 
	This file is part of the Field project
]]


SimpleBackground = {}
SimpleBackground.__index =  SimpleBackground

function SimpleBackground.new(path,scale,ymap)
    local self = {}
    setmetatable(self, SimpleBackground)

	self.img=s_resourceManager:LoadImage(path)
    self.scale=scale
    self.ymap=ymap
    self.scale=scale
    return self
end




function SimpleBackground:update(dt)
end

function SimpleBackground:destroy()
	self.img = nil
	collectgarbage("collect")
end

function SimpleBackground:draw(pos)
		love.graphics.draw(self.img,0.0)
end
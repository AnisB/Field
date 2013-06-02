--[[ 
	This file is part of the Field project
]]


AutoLoopingBackground = {}
AutoLoopingBackground.__index =  AutoLoopingBackground

function AutoLoopingBackground.new(path,speed)
    local self = {}
    setmetatable(self, AutoLoopingBackground)

	self.img=love.graphics.newImage(path)
    self.scrolling=0
    self.speed =speed
    return self
end




function AutoLoopingBackground:update(dt)
    self.scrolling = self.scrolling + dt*self.speed 
end


function AutoLoopingBackground:draw()
		love.graphics.draw(self.img,-(self.scrolling)%1280-1280, 0)
		love.graphics.draw(self.img, -(self.scrolling)%1280, 0)
end
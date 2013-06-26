--[[ 
	This file is part of the Field project
]]


AutoLoopingBackground = {}
AutoLoopingBackground.__index =  AutoLoopingBackground

function AutoLoopingBackground.new(path,speed, decy)
    local self = {}
    setmetatable(self, AutoLoopingBackground)

	self.img=love.graphics.newImage(path)
    self.scrolling=0
    self.speed =speed
    if decy then
        self.decy = decy
    else
        self.decy = 0
    end
    return self
end




function AutoLoopingBackground:update(dt)
    self.scrolling = self.scrolling + dt*self.speed 
end


function AutoLoopingBackground:draw()
		love.graphics.draw(self.img,-(self.scrolling)%1280-1280, 0+ self.decy)
		love.graphics.draw(self.img, -(self.scrolling)%1280, 0 + self.decy)
end
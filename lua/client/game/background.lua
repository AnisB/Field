--[[ 
	This file is part of the Field project
]]


Background = {}
Background.__index =  Background

function Background.new(path,scale,ymap)
    local self = {}
    setmetatable(self, Background)

	self.img=love.graphics.newImage(path)
    self.scale=scale
    self.ymap=ymap
    self.scale=scale
    self.quad= love.graphics.newQuad(0, 0, 1280, 800, 2560, 800)
    return self
end




function Background:update(dt)
end


function Background:draw(pos)
		love.graphics.drawq(self.img, self.quad,-(pos.x)*self.scale%1280-1280, -(self.img:getHeight()-windowH)*pos.y/self.ymap)
		love.graphics.drawq(self.img,self.quad, -(pos.x)*self.scale%1280, -(self.img:getHeight()-windowH)*pos.y/self.ymap)
		-- love.graphics.draw(self.img, -(pos.x)*self.scale%1280+1280, -(self.img:getHeight()-windowH)*pos.y/self.ymap)
        -- love.graphics.drawq(self.img,self.quad, 0,0)

end
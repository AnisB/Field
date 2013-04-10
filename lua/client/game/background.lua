--[[ 
	This file is part of the Field project
]]


Background = {}
Background.__index =  Background

function Background.new(path,xmap,ymap,scale1,scale2)
    local self = {}
    setmetatable(self, Background)

	self.img=love.graphics.newImage(path)
    self.xmap=xmap
    self.ymap=ymap
    self.scale={x=scale1,y=scale2}
    return self
end




function Background:update(dt)
end


function Background:draw(pos)
		love.graphics.draw(self.img, -(self.img:getWidth()*self.scale.x-windowW)*pos.x/self.xmap, -(self.img:getHeight()*self.scale.y-windowH)*pos.y/self.ymap,0,self.scale.x,self.scale.y)
end
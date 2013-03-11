--[[ 
This file is part of the Field project
]]

require("const")

require("game.physics")
Platform = {}
Platform.__index =  Platform

function Platform.new(position, length, spriteB, spriteM, spriteE)
    local self = {}
    setmetatable(self, Platform)
    self.position={x=position.x,y=position.y}
    self.spriteB=spriteB
    self.spriteM=spriteM
    self.spriteE=spriteE
    self.length=length
    self.w=length
    self.h=unitWorldSize
    self.type='Platform'
    decalage={self.length/2,unitWorldSize/2}

    -- print("Sol "..self.position[1].." "..self.position[2].." "..unitWorldSize.." "..self.length)
    self.pc = Physics.newRectangle(self.position.x,self.position.y,self.length,unitWorldSize,true,decalage)
    self.pc.fixture:setUserData(self)
    return self
end


function Platform:getPosition()
    return self.position
end
function Platform:update(dt)
end

function Platform:collideWith( object, collision )

end

function Platform:unCollideWith( object, collision )

end
function Platform:draw(x,y)
	  love.graphics.setColor(0,0,255,255)
	  love.graphics.rectangle( "fill", self.position.x-x,self.position.y+y,self.length,unitWorldSize)
	  				love.graphics.setColor(0,20,175,255)

	 --love.graphics.polygon("fill", self.pc.body:getWorldPoints(self.pc.shape:getPoints()))


end
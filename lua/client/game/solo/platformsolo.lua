--[[ 
This file is part of the Field project
]]

require("const")

require("game.physics")
PlatformSolo = {}
PlatformSolo.__index =  PlatformSolo

function PlatformSolo.new(position, length, spriteB, spriteM, spriteE)
    local self = {}
    setmetatable(self, PlatformSolo)
    self.position={x=position.x,y=position.y}
    self.spriteB=spriteB
    self.spriteM=spriteM
    self.spriteE=spriteE
    self.length=length
    self.w=length
    self.h=unitWorldSize
    self.type='PlatformSolo'
    decalage={self.length/2,unitWorldSize/4}

    -- print("Sol "..self.position[1].." "..self.position[2].." "..unitWorldSize.." "..self.length)
    self.pc = Physics.newRectangle(self.position.x,self.position.y,self.length,unitWorldSize/2,true,decalage)
    self.pc.fixture:setUserData(self)
    return self
end


function PlatformSolo:getPosition()
    return self.position
end
function PlatformSolo:update(dt)
end

function PlatformSolo:collideWith( object, collision )

end

function PlatformSolo:unCollideWith( object, collision )

end
function PlatformSolo:draw(x,y)
end

function PlatformSolo:send(x,y)
    return "@platformSolo".."#"
end
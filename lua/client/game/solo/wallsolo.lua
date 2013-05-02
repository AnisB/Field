--[[ 
This file is part of the Field project
]]

require("const")
WallSolo = {}
WallSolo.__index =  WallSolo

function WallSolo.new(position, length, spriteB, spriteM, spriteE)
    local self = {}
    setmetatable(self, WallSolo)
    self.position={x=position.x,y=position.y}
    self.spriteB=spriteB
    self.spriteM=spriteM
    self.spriteE=spriteE
    self.length=length
    self.w=unitWorldSize
    self.h=length
        self.type='WallSolo'
    decalage={unitWorldSize/2,self.length/2}

    -- print("Mur "..self.positionition[1].." "..self.position[2].." "..unitWorldSize.." "..self.length)
    self.pc = Physics.newRectangle(self.position.x,self.position.y,unitWorldSize,self.length,true,decalage)
    self.pc.fixture:setUserData(self)

    return self
end

function WallSolo:getPosition()
    return self.position
end

function WallSolo:update(dt)
end

function WallSolo:collideWith( object, collision )

end

function WallSolo:unCollideWith( object, collision )

end

function WallSolo:draw(x,y)

end

--[[ 
This file is part of the Field project
]]

require("game.physics")

Sphere = {}
Sphere.__index =  Sphere

function Sphere.new(position, sprite)
    local self = {}
    setmetatable(self, Sphere)
    self.position={x=position.x,y=position.y}
    self.sprite=sprite
    self.pc = Physics.newSphere(self.position.x,self.position.y,unitWorldSize/2,false)
    self.pc.fixture:setUserData(self)
    self.pc.fixture:getUserData():reset()
    self.type='Sphere'
    return self
end


function Sphere:getPosition()
 print("Sphere")
    return self.position
end

function Sphere:update(dt)


end

function Sphere:reset()
  print("sphere works")
end

function Sphere:collideWith( object, collision )

end

function Sphere:unCollideWith( object, collision )

end

function Sphere:draw(x, y)
    ax,ay =self.pc.body:getPosition()
  self.position.x=ax
  self.position.y=ay
	love.graphics.setColor(255,0,0,255)
	love.graphics.circle( "fill", self.position.x-x,self.position.y+y,unitWorldSize/2, 1000 )
  --	love.graphics.setColor(175,0,50,255)
  --love.graphics.circle("fill", self.pc.body:getX(), self.pc.body:getY(), self.pc.shape:getRadius())

end
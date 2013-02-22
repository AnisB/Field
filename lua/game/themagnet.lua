

require("game.camera")

TheMagnet = {}
TheMagnet.__index = TheMagnet


function TheMagnet.new(camera,pos)
	local self = {}
	setmetatable(self, TheMagnet)
	print(pos)
	self.camera=camera
	self.position={x=pos.x,y=pos.y}
	self.pc = Physics.newSphere(self.position.x,self.position.y,unitWorldSize/2,false)
	self.pc.fixture:setUserData(self)
	self.type='TheMagnet'
	self.appliesField=false
	self.fieldType=FieldTypes.None
	self.statMetals={}
	self.fieldRadius=4*unitWorldSize
	self.strenght=5*unitWorldSize
	self.pc.body:setMass(0.05*unitWorldSize)
	self.canjump=true
	return self
end

function TheMagnet:reset()
end

function TheMagnet:jump()
	if self.canjump then
			self.pc.body:applyLinearImpulse(0, -10*unitWorldSize/(0.05*12))
	self.canjump=false
end
end

function TheMagnet:setState( state )
end

function TheMagnet:isAppliable(pos)
	 local ax =pos.x-self.position.x
	 local ay =pos.y-self.position.y
	if math.abs(math.sqrt(ax*ax+ay*ay))<=self.fieldRadius then
	return true
	else
		return false
	end
end

function TheMagnet:getPosition()
	return self.position
end

function TheMagnet:getSpeed(  )
end

function TheMagnet:collideWith( object, collision )
	if(object:getPosition().y>self.position.y) and not self.canjump then
		self.canjump=true
	end
end

function TheMagnet:unCollideWith( object, collision )

end

function TheMagnet:addStatMetal(metal)
  for _, value in pairs(self.statMetals) do
    if value == metal then
      return 
    end
  end
  metal:initStaticField()
	table.insert(self.statMetals,metal)
end

-- Enabling fields
function TheMagnet:enableRepulsiveField()
	self.appliesField=true
	self.fieldType=FieldTypes.Repulsive
end

function TheMagnet:enableAttractiveField()
	self.appliesField=true
	self.fieldType=FieldTypes.Attractive
end
function TheMagnet:enableStaticField()
	self.appliesField=true
	self.fieldType=FieldTypes.Static
end

function TheMagnet:enableRotativeLField()
	self.appliesField=true
	self.fieldType=FieldTypes.RotativeL
end
function TheMagnet:enableRotativeRField()
	self.appliesField=true
	self.fieldType=FieldTypes.RotativeR
end

-- Disabling fields

function TheMagnet:disableField()
	self.appliesField=false
	self.fieldType=FieldTypes.None
end


function TheMagnet:rotativeLField(pos)
	local vx=self.position.x-pos.x
	local vy=self.position.y-pos.y
	local n = math.sqrt(vx*vx+vy*vy)
	local vrx = vx/n
	local vry= vy/n
	self.pc.body:applyLinearImpulse(vry*self.strenght,-vrx*self.strenght)end

function TheMagnet:rotativeRField(pos)
	local vx=self.position.x-pos.x
	local vy=self.position.y-pos.y
	local n = math.sqrt(vx*vx+vy*vy)
	local vrx = vx/n
	local vry= vy/n
	self.pc.body:applyLinearImpulse(-vry*self.strenght,vrx*self.strenght)end

function TheMagnet:attractiveField(pos)
	local vx=self.position.x-pos.x
	local vy=self.position.y-pos.y
	local n = math.sqrt(vx*vx+vy*vy)
	local vrx = vx/n
	local vry= vy/n
	if(n>(unitWorldSize)) then 
			self.pc.body:applyLinearImpulse(-vrx*self.strenght,-vry*self.strenght)
	end
	end


function TheMagnet:repulsiveField(pos)
	local vx=-self.position.x+pos.x
	local vy=-self.position.y+pos.y
	local n = math.sqrt(vx*vx+vy*vy)
	local vrx = vx/n
	local vry= vy/n
		self.pc.body:applyLinearImpulse(-vrx*self.strenght,-vry*self.strenght)
	end

function TheMagnet:disableStaticField()
	self.appliesField=false
	self.fieldType=FieldTypes.None
	for i,m in ipairs(self.statMetals)  do
		m:cancelStaticField()
		table.remove(self.statMetals,i)
	end
end

function TheMagnet:still(  )
end

function TheMagnet:teleport( x,y )
end


function TheMagnet:left( )
end

function TheMagnet:right(  )
end

function TheMagnet:down(  )
end

function TheMagnet:getPosition(  )
	return self.position
end

function TheMagnet:loadAnimation(anim, force)
end

function TheMagnet:update(seconds)
	x,y =self.pc.body:getPosition()
	self.position.x=x
	self.position.y=y
  if love.keyboard.isDown("right") then --press the right arrow key to push the ball to the right

  	self.pc.body:applyForce(unitWorldSize*40, 0)
  elseif love.keyboard.isDown("left") then --press the left arrow key to push the ball to the left
  	self.pc.body:applyForce(-unitWorldSize*40,0)
  end
    for i,m in ipairs(self.statMetals)  do
		m:setVelocity(self.pc.body:getLinearVelocity())
	end
end

function TheMagnet:draw(x,y)
	love.graphics.setColor(175,100,50,255)
	love.graphics.circle("fill", self.pc.body:getX()-x, self.pc.body:getY()+y, self.pc.shape:getRadius())
end
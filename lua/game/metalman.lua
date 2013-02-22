--[[ 
This file is part of the Field project]]


require("game.camera")
require("game.anim")

MetalMan = {}
MetalMan.__index = MetalMan

MetalMTypes={Alu =0.05,Acier =0.1}

function MetalMan.new(camera,pos)
	local self = {}
	setmetatable(self, MetalMan)
	print(pos)
	self.camera=camera
	self.position={x=pos.x,y=pos.y}
	self.pc = Physics.newSphere(self.position.x,self.position.y,unitWorldSize/2,false)
	self.pc.fixture:setUserData(self)
	self.pc.fixture:getUserData():reset()
	self:setState("running")
	self.anim = Anim.new('perso')
	self:loadAnimation("running",true)
	self.canjump=true
	self.gs = self.pc.body:getGravityScale()
	self.isStatic=false
	self.strenght=5*unitWorldSize
	self.metalType=MetalTypes.Normal
	self.oldType=MetalTypes.Normal
	self.type='MetalMan'
	self.metalWeight=MetalMTypes.Alu
	self.pc.body:setMass(self.metalWeight*unitWorldSize)
	self.goF=true
	return self
end

function MetalMan:reset()
end

function MetalMan:jump()
	if self.canjump and not self.isStatic then
		if 	self.metalWeight==MetalMTypes.Alu then
			self.pc.body:applyLinearImpulse(0, -10*unitWorldSize/self.metalWeight/12)
		else
			self.pc.body:applyLinearImpulse(0, -50*unitWorldSize/self.metalWeight/15)
		end
	self:setState("startjumping")
	self:loadAnimation("startjumping",true)
	self.canjump=false
	end
end

function MetalMan:rotativeLField(pos)
	local vx=self.position.x-pos.x
	local vy=self.position.y-pos.y
	local n = math.sqrt(vx*vx+vy*vy)
	local vrx = vx/n
	local vry= vy/n
	self.pc.body:applyLinearImpulse(-vry*self.strenght/5,vrx*self.strenght/5)end

function MetalMan:rotativeRField(pos)
	local vx=self.position.x-pos.x
	local vy=self.position.y-pos.y
	local n = math.sqrt(vx*vx+vy*vy)
	local vrx = vx/n
	local vry= vy/n
	self.pc.body:applyLinearImpulse(vry*self.strenght/5,-vrx*self.strenght/5)end

function MetalMan:attractiveField(pos)
	local vx=self.position.x-pos.x
	local vy=self.position.y-pos.y
	local n = math.sqrt(vx*vx+vy*vy)
	local vrx = vx/n
	local vry= vy/n
	self.pc.body:applyLinearImpulse(vrx*self.strenght,vry*self.strenght)
	end


function MetalMan:repulsiveField(pos)
	local vx=-self.position.x+pos.x
	local vy=-self.position.y+pos.y
	local n = math.sqrt(vx*vx+vy*vy)
	local vrx = vx/n
	local vry= vy/n
	if(n>(unitWorldSize)) then 
		self.pc.body:applyLinearImpulse(vrx*self.strenght,vry*self.strenght)
	end
end

function MetalMan:setVelocity(x,y)
	self.pc.body:setLinearVelocity(x,y)
end

function MetalMan:initStaticField()
	self.pc.body:setLinearVelocity(0,0)
	self.isStatic=true
	self.pc.body:setGravityScale(0)
end

function MetalMan:staticField(magnet)

end

function MetalMan:changeMass()
	print("Old mass"..self.pc.body:getMass())
	if 	self.metalWeight==MetalMTypes.Alu then
		self.metalWeight=MetalMTypes.Acier
	elseif 	self.metalWeight==MetalMTypes.Acier then
		self.metalWeight=MetalMTypes.Alu
	end
	print("New Mass"..self.metalWeight*unitWorldSize)
	self.pc.body:setMass(self.metalWeight*unitWorldSize)
end

function MetalMan:cancelStaticField()
		self.isStatic=false
		self.pc.body:setGravityScale(self.gs)
		self.pc.body:applyLinearImpulse(0, 1)
end
function MetalMan:setState( state )
	self.state = state
end

function MetalMan:switchType()
	if self.metalType ==MetalTypes.Normal then
		self.oldMetal = self.metalType
		self.metalType=MetalTypes.Static
		self.isStatic=true
	elseif self.metalType ==MetalTypes.Static then
		self.oldMetal = self.metalType
		self.metalType=MetalTypes.Normal
		self.isStatic=false
	end
end

function MetalMan:getSpeed(  )
end

function MetalMan:collideWith( object, collision )
	if(object:getPosition().y>self.position.y) and not self.canjump then
		self.canjump=true
		self:setState('landing')
		self:loadAnimation("landing",true)
	end
end

function MetalMan:unCollideWith( object, collision )

end

function MetalMan:still(  )
end

function MetalMan:teleport( x,y )
end


function MetalMan:left( )
end

function MetalMan:right(  )
end

function MetalMan:down(  )
end

function MetalMan:getPosition(  )
	return self.position
end

function MetalMan:loadAnimation(anim, force)
		self.anim:load(anim, force)
end

function MetalMan:update(seconds,cam)
	self.anim:update(seconds)
	x,y =self.pc.body:getPosition()
	self.position.x=x
	self.position.y=y
	if not self.isStatic  then
  if love.keyboard.isDown("d") then --press the right arrow key to push the ball to the right
  	if self.metalWeight==MetalMTypes.Alu then
  		 self.pc.body:applyForce(unitWorldSize*40, 0)
  	else
  		self.pc.body:applyForce(unitWorldSize*75, 0)
  	end
  		self.goF=true

  elseif love.keyboard.isDown("q") then --press the left arrow key to push the ball to the left
  	if self.metalWeight==MetalMTypes.Alu then
  		 self.pc.body:applyForce(-unitWorldSize*40, 0)
  	else
  		self.pc.body:applyForce(-unitWorldSize*75, 0)
  	end
  		self.goF=false

  end
end
	cam:newPosition(self.position.x,self.position.y)
end

function MetalMan:draw()
  	love.graphics.setColor(175,100,50,255)
  love.graphics.circle("fill", windowW/2,windowH/2,self.pc.shape:getRadius()) 
    	love.graphics.setColor(255,255,255,255)
    	if 	self.goF then
  	love.graphics.draw(self.anim:getSprite(), windowW/2-unitWorldSize*1.3,windowH/2-unitWorldSize*1.6, 0, 0.15,0.15)
  else
  	  	love.graphics.draw(self.anim:getSprite(), windowW/2+unitWorldSize,windowH/2-unitWorldSize*1.6,0 , -0.15,0.15)

  end

    --love.graphics.circle("fill", self.pc.body:getX(), self.pc.body:getY(), self.pc.shape:getRadius())
--self.pc.body:getX(), self.pc.body:getY(), self.pc.shape:getRadius())
end
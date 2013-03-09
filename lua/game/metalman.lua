--[[ 
This file is part of the Field project]]


require("game.camera")
require("game.animmm")
require("game.metalmanconst")
MetalMan = {}
MetalMan.__index = MetalMan

function MetalMan.new(camera,pos)
	local self = {}
	setmetatable(self, MetalMan)
	print(pos)

	-- The camera
	self.camera=camera

	-- The position initiate
	self.position={x=pos.x,y=pos.y}

	-- The physics components
	self.pc = Physics.newCharacter(self.position.x,self.position.y,unitWorldSize/2,false)
	self.pc.fixture:setUserData(self)
	self.pc.fixture:getUserData():reset()
	self.gs = self.pc.body:getGravityScale()
	self.metalWeight=MetalMTypes.Alu
	self.pc.body:setMass(self.metalWeight*unitWorldSize)


	-- Animation state
	self:setState("standing")
	self.anim = AnimMM.new('metalMan')
	self:loadAnimation("standing",true)
	self.goF=true
	self.animCounter=0

	-- Other states
	self.canjump=true
	self.isStatic=false
	self.strenght=MetalManFieldStr
	self.metalType=MetalTypes.Normal
	self.oldType=MetalTypes.Normal
	self.type='MetalMan'

	return self
end

function MetalMan:reset()
end

function MetalMan:jump()
	if self.canjump and not self.isStatic then
		if 	self.metalWeight==MetalMTypes.Alu then
			self.pc.body:applyLinearImpulse(0, MetalManJumpImpulse.Alu)
		else
			self.pc.body:applyLinearImpulse(0, MetalManJumpImpulse.Acier)
		end
	self:setState("startjumping")
	self:loadAnimation("startjumping",true)
	self.canjump=false
	end
end

function MetalMan:rotativeLField(pos)
	local vx=self.position.x-pos.x +0.01
	local vy=self.position.y-pos.y
	local n = math.sqrt(vx*vx+vy*vy)
	local vrx = vx/n
	local vry= vy/n
	self.pc.body:applyLinearImpulse(-vry*MetaManRotFieldS.x,vrx*MetaManRotFieldS.y)
end

function MetalMan:rotativeRField(pos)
	local vx=self.position.x-pos.x+0.01
	local vy=self.position.y-pos.y
	local n = math.sqrt(vx*vx+vy*vy)
	local vrx = vx/n
	local vry= vy/n
	self.pc.body:applyLinearImpulse(vry*MetaManRotFieldS.x,-vrx*MetaManRotFieldS.y)
end

function MetalMan:attractiveField(pos)
	local vx=self.position.x-pos.x+0.01
	local vy=self.position.y-pos.y
	local n = math.sqrt(vx*vx+vy*vy)
	local vrx = vx/n
	local vry= vy/n
	self.pc.body:applyLinearImpulse(vrx*MetaManAttFieldS.x,vry*MetaManAttFieldS.y)
	end


function MetalMan:repulsiveField(pos)
	local vx=-self.position.x+pos.x+0.01
	local vy=-self.position.y+pos.y
	local n = math.sqrt(vx*vx+vy*vy)
	local vrx = vx/n
	local vry= vy/n
	if(n>(unitWorldSize)) then 
		self.pc.body:applyLinearImpulse(vrx*MetaManRepFieldS.x,vry*MetaManRepFieldS.y)
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
	if(object:getPosition().y>self.position.y) and (not self.canjump)  then
		self.canjump=true
		if self.animCounter>0 then 
		self:loadAnimation("running",true)
				else
			self:setState('landing')
		self:loadAnimation("landing",true)
	end
	
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

function MetalMan:startMove(  )
	self.animCounter=self.animCounter+1

	if self.canjump and not self.isStatic then
		self:loadAnimation("running",true)	end

end
function MetalMan:stopMove( )
	self.animCounter=self.animCounter-1
	x,y=self.pc.body:getLinearVelocity()
	self.pc.body:setLinearVelocity(x/MetalManBreakFactor,y/MetalManBreakFactor)
	if self.canjump and not self.isStatic  and self.animCounter==0 then
		self:loadAnimation("stoprunning",true)	end
end


function MetalMan:getPosition(  )
	return self.position
end

function MetalMan:loadAnimation(anim, force)
		self.anim:load(anim, force)
end

function MetalMan:update(seconds,cam)
	x,y =self.pc.body:getLinearVelocity()
	if x>MetalManMaxSpeed then
		self.pc.body:setLinearVelocity(MetalManMaxSpeed,y)
	end

	if x<-MetalManMaxSpeed then
		self.pc.body:setLinearVelocity(-MetalManMaxSpeed,y)
	end
	self.anim:update(seconds)
	x,y =self.pc.body:getPosition()
	self.position.x=x
	self.position.y=y
	if not self.isStatic  then
  if love.keyboard.isDown("d") then
  	if self.metalWeight==MetalMTypes.Alu then
  		 self.pc.body:applyForce(MetalManMovingForce.Alu, 0)
  	else
  		self.pc.body:applyForce(MetalManMovingForce.Acier, 0)
  	end
  		self.goF=true

  elseif love.keyboard.isDown("q") then 
  	if self.metalWeight==MetalMTypes.Alu then
  		 self.pc.body:applyForce(-MetalManMovingForce.Alu, 0)
  	else
  		self.pc.body:applyForce(-MetalManMovingForce.Acier, 0)
  	end
  		self.goF=false

  end
end
	cam:newPosition(self.position.x,self.position.y)
end

function MetalMan:draw()
    	love.graphics.setColor(255,255,255,255)
    	if 	self.goF then
    		love.graphics.draw(self.anim:getSprite(), windowW/2-unitWorldSize/2,windowH/2-unitWorldSize/2, 0, 1,1)
    	else
    		love.graphics.draw(self.anim:getSprite(), windowW/2+unitWorldSize/2,windowH/2-unitWorldSize/2,0 , -1,1)
    	end
end
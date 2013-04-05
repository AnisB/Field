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
	self.anim = AnimMM.new('metalman/alu')
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

	self.alive=true

	return self
end

function MetalMan:reset()
end


function MetalMan:die()
	if self.alive then
		self.alive=false
		self:loadAnimation("mortelec",true)	
	end
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
	local vx=-self.position.x+pos.x+0.01
	local vy=-self.position.y+pos.y
	local n = math.sqrt(vx*vx+vy*vy)
	local vrx = vx/n
	local vry= vy/n
	if(n>(unitWorldSize)) then 
		self.pc.body:applyLinearImpulse(vrx*MetaManAttFieldS.x,vry*MetaManAttFieldS.y)
	end
end


function MetalMan:repulsiveField(pos)
	local vx=self.position.x-pos.x
	local vy=self.position.y-pos.y
	local n = math.sqrt(vx*vx+vy*vy)
	local vrx = vx/n
	local vry = vy/(n*n)
	if(n>(unitWorldSize)) then 
		self.pc.body:applyLinearImpulse(vrx*MetaManRepFieldS.x,vry*MetaManRepFieldS.y*100)
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
	if self.alive then
		if 	self.metalWeight==MetalMTypes.Alu then
			self.anim = AnimMM.new('metalman/acier')
			self:loadAnimation("standing",true)
			self:loadAnimation("load1",true)
			self.metalWeight=MetalMTypes.Acier
		elseif 	self.metalWeight==MetalMTypes.Acier then
			self.metalWeight=MetalMTypes.Alu
			self.anim = AnimMM.new('metalman/alu')
			self:loadAnimation("load2",true)
		end
		self.pc.body:setMass(self.metalWeight*unitWorldSize)
	end
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
if self.alive then

	if self.metalType ==MetalTypes.Normal then
		self.oldMetal = self.metalType
		self.metalType=MetalTypes.Static
		self.anim = AnimMM.new('metalman/static')
			
		if 	self.metalWeight==MetalMTypes.Alu then
			self:loadAnimation("load1",true)
		elseif 	self.metalWeight==MetalMTypes.Acier then
				self:loadAnimation("load2",true)
		end
		self.isStatic=true
	elseif self.metalType ==MetalTypes.Static then
		self.oldMetal = self.metalType
		self.metalType=MetalTypes.Normal
		self.isStatic=false
		if 	self.metalWeight==MetalMTypes.Alu then
			self.anim = AnimMM.new('metalman/alu')
			self:loadAnimation("load1",true)
		elseif 	self.metalWeight==MetalMTypes.Acier then
			self.anim = AnimMM.new('metalman/acier')
			self:loadAnimation("load2",true)
		end
	end
end
end

function MetalMan:getSpeed(  )
end

function MetalMan:collideWith( object, collision )

	if self.alive then
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

	if self.alive then
		self.animCounter=self.animCounter+1
		if self.canjump and not self.isStatic then
			x,y=self.pc.body:getLinearVelocity()
			if((not self.goF and x>=0) or ( self.goF and x<=0))then
				self:loadAnimation("running",true)
			else
				self:loadAnimation("returnanim",true)
			end
		end
	end
end


function MetalMan:stopMove( )
	if self.alive then
		self.animCounter=self.animCounter-1
		x,y=self.pc.body:getLinearVelocity()
		self.pc.body:setLinearVelocity(x/MetalManBreakFactor,y/MetalManBreakFactor)
		if self.canjump and not self.isStatic  and self.animCounter==0 then
			self:loadAnimation("stoprunning",true)	
		end
	end
end


function MetalMan:getPosition(  )
	return self.position
end

function MetalMan:loadAnimation(anim, force)
		self.anim:load(anim, force)
end

function MetalMan:update(seconds)
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
	if self.alive then
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
	end
	self.camera:newPosition(self.position.x,self.position.y)
end

function MetalMan:draw()
    	love.graphics.setColor(255,255,255,255)
    	if 	self.goF then
    		love.graphics.draw(self.anim:getSprite(), windowW/2-unitWorldSize/2,windowH/2-unitWorldSize/2, 0, 1,1)
    	else
    		love.graphics.draw(self.anim:getSprite(), windowW/2+unitWorldSize/2,windowH/2-unitWorldSize/2,0 , -1,1)
    	end
end

-- Draws the character to screen
function MetalMan:secondDraw(x,y)

	-- Draws the character
	love.graphics.setColor(255,255,255,255)
	if self.goF then
	love.graphics.draw(self.anim:getSprite(), self.position.x-x-unitWorldSize/2, self.position.y+y-unitWorldSize/2, 0, 1,1)
	else
	love.graphics.draw(self.anim:getSprite(), self.position.x-x+unitWorldSize/2, self.position.y+y-unitWorldSize/2, 0, -1,1)
	end
end

-- Return the character to screen
function MetalMan:secondSend(x,y)
	if self.goF then
    	return ("@metalman".."#"..self.anim:getImgInfo()[1].."#"..self.anim:getImgInfo()[2].."#"..math.floor(self.position.x-x-unitWorldSize/2).."#"..math.floor( self.position.y+y-unitWorldSize/2).."#".."1")
	else
    	return ("@metalman".."#"..self.anim:getImgInfo()[1].."#"..self.anim:getImgInfo()[2].."#"..math.floor(self.position.x-x+unitWorldSize/2).."#"..math.floor( self.position.y+y-unitWorldSize/2).."#".."-1")
    end
end

-- Return the character to screen
function MetalMan:mainSend(x,y)
	if self.goF then
    	return ("@metalman".."#"..self.anim:getImgInfo()[1].."#"..self.anim:getImgInfo()[2].."#"..math.floor(windowW/2-unitWorldSize/2).."#"..math.floor( windowH/2-unitWorldSize/2).."#".."1")
	else
    	return ("@metalman".."#"..self.anim:getImgInfo()[1].."#"..self.anim:getImgInfo()[2].."#"..math.floor(windowW/2+unitWorldSize/2).."#"..math.floor( windowH/2-unitWorldSize/2).."#".."-1")
    end
end
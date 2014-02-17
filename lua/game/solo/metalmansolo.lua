--[[ 
This file is part of the Field project]]



-- Include Camera
require("render.camera")

-- Include Anim
require("game.solo.animmmsolo")

-- Include const
require("equilibrage.metalmanconst")

-- Include shader
require ("shader.aftereffect")

MetalManSolo = {}
MetalManSolo.__index = MetalManSolo

function MetalManSolo.new(camera,pos,powers)
	local self = {}
	setmetatable(self, MetalManSolo)

	-- The camera
	self.camera=camera

	-- The position initiate
	self.position={x=pos.x,y=pos.y}

	-- The physics components
	self.pc = Physics.newCharacter(self.position.x,self.position.y)
	self.pc.fixture:setUserData(self)
	self.pc.fixture:getUserData():reset()
	self.gs = self.pc.body:getGravityScale()
	self.metalWeight=MetalMTypes.Alu
	self.pc.body:setMass(self.metalWeight*unitWorldSize)


	-- Animation state
	self:setState("standing")
	self.anim = AnimMMSolo.new('metalman/alu')

	self.goF=true
	self.animCounter=0

	-- Other states
	self.canjump=true
	self.isStatic=false
	self.strenght=MetalManFieldStr
	self.metalType=MetalTypes.Normal
	self.oldType=MetalTypes.Normal
	self.type='MetalManSolo'

	self.alive=true

	self.willrotate=false

	self.collisionCounter=0
	self.s= AfterEffect.new(ShaderDirectory.."shockwave.glsl")
	self.s:setParameter{
		center = {0.5,0.5},
		shockParams = {20,0.8,0.1},
	}

	self.tranfSound=Sound.getSound("tranf")
	self.shake=Sound.getSound("shake")
	self.diffuse  = love.graphics.newQuad(0, 0, 64, 64, 128, 64)
	self.powers = {}

	if powers~=nil then
		for k in string.gmatch(powers, "([^#]+)") do
			print(k)
			self.powers[k] = true
		end
	end

	self.moveState = 0
	return self
end


function MetalManSolo:init()
	self:loadAnimation("standing",true)
end

function MetalManSolo:reset()
end


function MetalManSolo:die(type)
	if self.alive then
		self.alive=false
		if(type=="acid") then
			s_gameStateManager.state["GameplaySolo"]:dieEffect(Effects.Acid)
			s_gameStateManager.state["GameplaySolo"]:slow()
		else
			s_gameStateManager.state["GameplaySolo"]:dieEffect(Effects.Arc)
			self:loadAnimation("mortelec",true)
			s_gameStateManager.state["GameplaySolo"]:slow()
			Sound.playSound("electroc")
		end
	end
end


function MetalManSolo:jump()
	if self.alive then
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
end

function MetalManSolo:rotativeLField(pos,factor)
	local vx=self.position.x-pos.x +0.01
	local vy=self.position.y-pos.y
	local n = math.sqrt(vx*vx+vy*vy)
	local vrx = vx/n
	local vry= vy/n
	self.pc.body:applyLinearImpulse(-vry*MetaManRotFieldS.x*factor,vrx*MetaManRotFieldS.y*factor)
	self.willrotate=true
end

function MetalManSolo:rotativeRField(pos,factor)
	local vx=self.position.x-pos.x+0.01
	local vy=self.position.y-pos.y
	local n = math.sqrt(vx*vx+vy*vy)
	local vrx = vx/n
	local vry= vy/n
	self.pc.body:applyLinearImpulse(vry*MetaManRotFieldS.x*factor,-vrx*MetaManRotFieldS.y*factor)
	self.willrotate=true	
end

function MetalManSolo:attractiveField(pos,factor)
	local vx=-self.position.x+pos.x+0.01
	local vy=-self.position.y+pos.y
	local n = math.sqrt(vx*vx+vy*vy)
	local vrx = vx/n
	local vry= vy/n
	if(n>(unitWorldSize)) then 
		self.pc.body:applyLinearImpulse(vrx*MetaManAttFieldS.x*factor,vry*MetaManAttFieldS.y*factor)
	end
	self.willrotate=false	
end


function MetalManSolo:repulsiveField(pos,factor)
	local vx=self.position.x-pos.x
	local vy=self.position.y-pos.y
	local n = math.sqrt(vx*vx+vy*vy)
	local vrx = vx/n
	local vry = vy/(n*n)
	if(n>(unitWorldSize)) then 
		self.pc.body:applyLinearImpulse(vrx*MetaManRepFieldS.x*factor,vry*MetaManRepFieldS.y*100*factor)
	end
	self.willrotate=false
end

function MetalManSolo:setVelocity(x,y)
	self.pc.body:setLinearVelocity(x,y)
end

function MetalManSolo:initStaticField()
	self.pc.body:setLinearVelocity(0,0)
	self.isStatic=true
	self.pc.body:setGravityScale(0)
end

function MetalManSolo:disableField()

end

function MetalManSolo:changeMass()
	if self.alive then

		if 	self.metalWeight==MetalMTypes.Alu then
			-- if self.powers["Acier"] then
				self.anim = AnimMMSolo.new('metalman/acier')
				self:loadAnimation("standing",true)
				self:loadAnimation("load1",true)
				self.s:activate()
				self.metalWeight=MetalMTypes.Acier
				self.tranfSound:stop()
				self.tranfSound:play()
			-- end
		elseif 	self.metalWeight==MetalMTypes.Acier then
			-- if self.powers["Alu"] then
				self.metalWeight=MetalMTypes.Alu
				self.anim = AnimMMSolo.new('metalman/alu')
				self:loadAnimation("load2",true)
				self.s:activate()
				self.tranfSound:stop()
				self.tranfSound:play()
			-- end
		end
		self.pc.body:setMass(self.metalWeight*unitWorldSize)
	end
end

function MetalManSolo:cancelStaticField()
		self.isStatic=false
		self.pc.body:setGravityScale(self.gs)
		self.pc.body:applyLinearImpulse(0, 1)
end
function MetalManSolo:setState( state )
	self.state = state
end

function MetalManSolo:switchType()
if self.alive then
	if self.metalType ==MetalTypes.Normal then
		-- if self.powers["Static"] then
			self.oldMetal = self.metalType
			self.metalType=MetalTypes.Static
			self.anim = AnimMMSolo.new('metalman/static')
			if 	self.metalWeight==MetalMTypes.Alu then
				self:loadAnimation("load1",true)
				self.s.time=0
			elseif 	self.metalWeight==MetalMTypes.Acier then
				self:loadAnimation("load2",true)
				self.s.time=0			
			end
			self.isStatic=true
			self.tranfSound:stop()
			self.tranfSound:play()
		-- end
	elseif self.metalType ==MetalTypes.Static then
		-- if self.powers["Acier"] or  self.powers["Alu"] then
			self.oldMetal = self.metalType
			self.metalType=MetalTypes.Normal
			self.isStatic=false
			if 	self.metalWeight==MetalMTypes.Alu then
				self.anim = AnimMMSolo.new('metalman/alu')
				self:loadAnimation("load1",true)
				self.s.time=0				
			elseif 	self.metalWeight==MetalMTypes.Acier then
				self.anim = AnimMMSolo.new('metalman/acier')
				self:loadAnimation("load2",true)
				self.s.time=0			
			end
			self.tranfSound:stop()
			self.tranfSound:play()
		-- end

	end
end
end

function MetalManSolo:getSpeed(  )
end

function MetalManSolo:collideWith( object, collision )

	if self.alive then
		if object.type=='GateInterruptorSolo' or object.type=='InterruptorSolo' or object.type=='ArcInterruptorSolo' or object.type=='ArcSolo' or object.type=='TheMagnet' or object.type=='LevelEnd' or object.type=='Acid' then
			--Ghost dude
		else
			self.collisionCounter=self.collisionCounter+1
			if self.metalWeight==MetalMTypes.Acier then
				vx,vy =self.pc.body:getLinearVelocity() 
				local kinEnergyX = math.log(0.5*self.pc.body:getMass()*self.pc.body:getMass()*self.pc.body:getMass()*math.abs(vx))
				local kinEnergyY = math.log(0.5*self.pc.body:getMass()*self.pc.body:getMass()*self.pc.body:getMass()*math.abs(vy))
				if kinEnergyX>10.9 or kinEnergyY>11 then
					local amplitude = math.min(math.max(math.sqrt(vx*vx+vy*vy), 0.0), 1500) 
					s_gameStateManager.state["GameplaySolo"]:shakeOnX(2,100,2.0,2.0*amplitude/1500.0)
					s_gameStateManager.state["GameplaySolo"]:shakeOnY(2,100,2.0,2.0*amplitude/1500.0)
				end
			end
			if self.isStatic==true  then
				vx,vy =self.pc.body:getLinearVelocity() 
				local amplitude = math.min(math.max(math.sqrt(vx*vx+vy*vy), 0.0), 1500) 
				s_gameStateManager.state["GameplaySolo"]:shakeOnX(5,100,2.0,3.0*amplitude/1500.0)
				s_gameStateManager.state["GameplaySolo"]:shakeOnY(5,100,2.0,3.0*amplitude/1500.0)
			end

			if(object:getPosition().y>self.position.y) then
				self.canjump=true
				if self.animCounter>0 then 
					if self.anim.currentAnim.name~="running" then
						self:loadAnimation("running",true)
					end
				else
					self:setState('landing')
					self:loadAnimation("landing",true)
				end
			end	
		end
	end
end

function MetalManSolo:unCollideWith( object, collision )
	if self.alive then
		if object.type=='GateInterruptor' or object.type=='Interruptor' or object.type=='TheMagnet' then
			--Ghost dude
		else
			self.collisionCounter=self.collisionCounter-1
		end
	end
	if self.willrotate and self.collisionCounter==0 then
		self:loadAnimation("startjumping",true)
		self.canjump=false
	end
end

function MetalManSolo:still(  )
end

function MetalManSolo:teleport( x,y )
end

function MetalManSolo:left( )
end

-- Method that handles the begining of a movement
function MetalManSolo:startMove(parDirection  )
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
		self.moveState = parDirection
	end
end


-- Method that handles the end of a movement
function MetalManSolo:stopMove( )
	if self.alive then
		self.animCounter=self.animCounter-1
		x,y=self.pc.body:getLinearVelocity()
		if(math.abs(y)<0.0001) then
			self.pc.body:setLinearVelocity(x/MetalManConst.BreakFactor,y)
		else
			self.pc.body:setLinearVelocity(x/MetalManConst.AirBreakFactor,y)
		end
		if self.canjump and not self.isStatic  then
			self:loadAnimation("stoprunning",true)
		end
		self.moveState = 0
	end
end
	
	function MetalManSolo:staticField(magnet)
		
	end

function MetalManSolo:getPosition(  )
	return self.position
end

function MetalManSolo:loadAnimation(anim, force)
		self.anim:load(anim, force)
end

function MetalManSolo:update(seconds)
	self.s:update(seconds)
	x,y =self.pc.body:getLinearVelocity()
	if x>MetalManMaxSpeed then
		self.pc.body:setLinearVelocity(MetalManMaxSpeed,y)
	end

	if x<-MetalManMaxSpeed then
		self.pc.body:setLinearVelocity(-MetalManMaxSpeed,y)
	end
	self.anim:update(seconds)
	if((self.moveState==0 or self.isStatic) and math.abs(y)<0.0001) then
		self.pc.body:setLinearVelocity(0,y)
	end
	if(self.anim.currentAnim.name == "standing" and self.moveState~=0 and math.abs(y)<0.0001 ) then
		self:loadAnimation("running",true)		
	end
	x,y =self.pc.body:getPosition()
	self.position.x=x
	self.position.y=y
	self.camera:newPosition(x,y)
	if self.alive then
		if not self.isStatic  then
			if self.moveState==1 then
				if self.metalWeight==MetalMTypes.Alu then
					self.pc.body:applyForce(MetalManMovingForce.Alu, 0)
				else
					self.pc.body:applyForce(MetalManMovingForce.Acier, 0)
				end
				self.goF=true
			elseif self.moveState==2 then 
				if self.metalWeight==MetalMTypes.Alu then
					self.pc.body:applyForce(-MetalManMovingForce.Alu, 0)
				else
					self.pc.body:applyForce(-MetalManMovingForce.Acier, 0)
				end
				self.goF=false
			end
		end
	end
	x,y =self.pc.body:getLinearVelocity()
end

function MetalManSolo:draw()
    	love.graphics.setColor(255,255,255,255)
    	if 	self.goF then
    		love.graphics.draw(self.anim:getSprite(), self.diffuse, windowW/2-unitWorldSize/2,windowH/2-unitWorldSize/2, 0, 1,1)
    	else
    		love.graphics.draw(self.anim:getSprite(), self.diffuse, windowW/2+unitWorldSize/2,windowH/2-unitWorldSize/2,0 , -1,1)
    	end
end

function MetalManSolo:preDraw()
		self.s:enableCanvas()
end

function MetalManSolo:postDraw()
		self.s:disableCanvas()
		self.s:pass()
end
--[[ 
This file is part of the Field project
]]

-- Includes
require("game.solo.camerasolo")
require("game.solo.animtmsolo")
require("game.solo.fieldsolo")
require("game.solo.attfieldsolo")
require("equilibrage.themagnetconst")
-- require("game.fieldsound")
-- Class Init
TheMagnetSolo = {}
TheMagnetSolo.__index = TheMagnetSolo


-- Constructor
function TheMagnetSolo.new(camera,pos,powers)

	-- Class init
	local self = {}
	setmetatable(self, TheMagnetSolo)

	-- Id Init
	self.id=-1

	-- Camera Init
	self.camera=camera

	-- Posiiton Init
	self.position={x=pos.x,y=pos.y}

	-- Physics Init
	self.pc = Physics.newCharacter(self.position.x,self.position.y,unitWorldSize/2 - 5,false)
	self.pc.fixture:setUserData(self)
	self.pc.body:setMass(TheMagnetConst.Mass)

	-- State and animation init
	self:setState("standing")
	self.anim = AnimTMSolo.new('themagnet')
	self:loadAnimation("standing",true)
	self.canjump=true
	self.goF=true
	self.animCounter=0

	-- Object's type
	self.type='TheMagnetSolo'

	-- Field init

		-- Particle field managing
		self.field= Field.new(FieldTypes.Static,pos)
		self.field.isActive=false

	    -- Other field attributes
	    self.appliesField=false
	    self.fieldType=FieldTypes.None

	    -- Static Field attributes
	    self.statMetals={}

	    -- Field Radius
	    self.fieldRadius=TheMagnetConst.fieldRadius

	    self.alive=true

	    -- self.fieldSound=nil

	    self.diffuse  = love.graphics.newQuad(0, 0, 64, 64, 128, 64)
	    self.powers = {}

	    if powers~=nil then
	    	for k in string.gmatch(powers, "([^#]+)") do
	    		self.powers[k] = true
	    	end
	    end
	    return self
	end



function TheMagnetSolo:init()
	self:loadAnimation("standing",true)
end

	function TheMagnetSolo:die(type)
		if self.alive then
			self:disableField()
			self:disableStaticField()
			self.alive=false
			if(type=="acid") then
				gameStateManager.state["GameplaySolo"]:dieEffect(Effects.Green)
				gameStateManager.state["GameplaySolo"]:slow()
			else
				gameStateManager.state["GameplaySolo"]:dieEffect(Effects.White)
				self:loadAnimation("mortelec",true)
				gameStateManager.state["GameplaySolo"]:slow()
				Sound.playSound("electroc")
			end
		end
	end



-- This method handles a jump try
function TheMagnetSolo:jump()
	-- Trying to jump
	if self.alive then

		if self.canjump then
		   -- The physics impulse
		   self.pc.body:applyLinearImpulse(0, TheMagnetConst.jumpImpulse)
		   -- Animaiton and state changing
		   self:setState("startjumping")
		   self:loadAnimation("startjumping",true)
		   self.canjump=false
		end
	end
end


-- This methods handles the object's state change
function TheMagnetSolo:setState( state )
	self.currentState=state
end


-- This method tells if an object is affected by the magnetic field applied by this character
function TheMagnetSolo:isAppliable(pos)
	local ax =pos.x-self.position.x
	local ay =pos.y-self.position.y
	if math.abs(math.sqrt(ax*ax+ay*ay))<=self.fieldRadius then
		return true
	else
		return false
	end
end

-- Error catch
function TheMagnetSolo:enableG()
	print("Error")
end

-- Error catch
function TheMagnetSolo:disableG()
	print("Error")
end

-- Return the objects position
function TheMagnetSolo:getPosition()
	return self.position
end

-- Return the object's speed
function TheMagnetSolo:getSpeed(  )
end


-- Method that handles the collision
function TheMagnetSolo:collideWith( object, collision )
	if self.alive then
		if object.type=='GateInterruptor' or object.type=='Interruptor' or object.type=='MetalMan' then
			-- Ghost object dude
		else
			if(object:getPosition().y>self.position.y) and (not self.canjump)  then
				self.canjump=true
				if self.animCounter>0 then 
					self:loadAnimation("running",true)
				else
					if self.appliesField==true then
						self:loadAnimation("field",true)
					else
						self:loadAnimation("landing",true)
					end
				end	
			end
		end
	end
end
-- Method that handles the uncollision
function TheMagnetSolo:unCollideWith( object, collision )
end


-- Add a static metal to the ones wich are affected by the static field
function TheMagnetSolo:addStatMetal(metal)
	for _, value in pairs(self.statMetals) do
		if value == metal then
			return 
		end
	end
	metal:initStaticField()
	table.insert(self.statMetals,metal)
end

-- Enabling fields
function TheMagnetSolo:enableRepulsiveField()
	if self.powers["Repulsive"]~=nil then
		if self.alive then
			self.fieldSound= FieldSound.new("Repulsive")
			self.fieldSound:play()
			self.field= Field.new(FieldTypes.Repulsive,pos)
			self.field.isActive=true
			self.appliesField=true
			self.fieldType=FieldTypes.Repulsive
			if self.animCounter==0 then
				self:loadAnimation("launchfield",true)
			end
		end
	end
end

function TheMagnetSolo:enableAttractiveField()
	if self.powers["Attractive"]~=nil then
		if self.alive then
			self.fieldSound= FieldSound.new("Attractive")
			self.fieldSound:play()
			self.field= AttField.new(pos)
			self.field.isActive=true
			self.appliesField=true
			self.fieldType=FieldTypes.Attractive
			if self.animCounter==0 then
				self:loadAnimation("launchfield",true)
			end		
		end
	end
end



function TheMagnetSolo:enableStaticField()
	if self.powers["Static"]~=nil then
		if self.alive then
			self.fieldSound= FieldSound.new("Static")
			self.fieldSound:play()
			self.field= Field.new(FieldTypes.Static,pos)
			self.field.isActive=true
			self.appliesField=true
			self.fieldType=FieldTypes.Static
			if self.animCounter==0 then
				self:loadAnimation("launchfield",true)
			end
		end
	end
end

function TheMagnetSolo:enableRotativeLField()
	if self.powers["RotativeL"]~=nil then
		if self.alive then
			self.fieldSound= FieldSound.new("RotativeL")
			self.fieldSound:play()
			self.field= Field.new(FieldTypes.RotativeL,pos)
			self.field.isActive=true
			self.appliesField=true
			if self.animCounter==0 then
				self:loadAnimation("launchfield",true)
			end
			self.fieldType=FieldTypes.RotativeL
		end
	end
end
function TheMagnetSolo:enableRotativeRField()
	if self.powers["RotativeR"]~=nil then
		if self.alive then
			self.fieldSound= FieldSound.new("RotativeR")
			self.fieldSound:play()
			self.field= Field.new(FieldTypes.RotativeR,pos)
			self.field.isActive=true
			self.appliesField=true
			self.fieldType=FieldTypes.RotativeR
			if self.animCounter==0 then
				self:loadAnimation("launchfield",true)
			end
		end
	end
end

-- In case of a static Metal
function TheMagnetSolo:rotativeLField(pos,factor)
	if self.powers["RotativeL"]~=nil then
		if self.alive then
			local vx=self.position.x-pos.x
			local vy=self.position.y-pos.y
			local n = math.sqrt(vx*vx+vy*vy)
			local vrx = vx/n
			local vry= vy/n
			self.pc.body:applyLinearImpulse(-vry*TheMagnetConst.Rot.x*factor,vrx*TheMagnetConst.Rot.y*factor)
			if self.animCounter==0 then
				self:loadAnimation("launchfield",true)
			end
		end
	end
end

function TheMagnetSolo:rotativeRField(pos,factor)
	if self.powers["RotativeR"]~=nil then
		if self.alive then

			local vx=self.position.x-pos.x
			local vy=self.position.y-pos.y
			local n = math.sqrt(vx*vx+vy*vy)
			local vrx = vx/n
			local vry= vy/n
			self.pc.body:applyLinearImpulse(vry*TheMagnetConst.Rot.x*factor,-vrx*TheMagnetConst.Rot.y*factor)
			if self.animCounter==0 then
				self:loadAnimation("launchfield",true)
			end
		end
	end
end

function TheMagnetSolo:attractiveField(pos,factor)
	if self.powers["Attractive"]~=nil then

		if self.alive then

			local vx=self.position.x-pos.x
			local vy=self.position.y-pos.y
			local n = math.sqrt(vx*vx+vy*vy)
			local vrx = vx/n
			local vry= vy/n
			if(n>(unitWorldSize)) then 
				self.pc.body:applyLinearImpulse(-vrx*TheMagnetConst.Att.x*factor,-vry*TheMagnetConst.Att.y*factor)
			end
			if self.animCounter==0 then
				self:loadAnimation("launchfield",true)
			end
		end
	end
end


function TheMagnetSolo:repulsiveField(pos,factor)
	if self.powers["Repulsive"]~=nil then

		if self.alive then

			local vx=-self.position.x+pos.x
			local vy=-self.position.y+pos.y
			local n = math.sqrt(vx*vx+vy*vy)
			local vrx = vx/n
			local vry= vy/n

			if(n>(unitWorldSize)) then 
				self.pc.body:applyLinearImpulse(-vrx*TheMagnetConst.Rep.x*factor,-vry*TheMagnetConst.Rep.y*factor)
			end
			if self.animCounter==0 then
				self:loadAnimation("launchfield",true)
			end
		end
	end
end

-- Disabling fields

function TheMagnetSolo:disableField()
	if self.alive then
		if self.fieldSound~=nil then
			self.fieldSound:stop()
		end
		self.field.isActive=false
		self.appliesField=false
		self.fieldType=FieldTypes.None
		if self.animCounter>=1 then
			self:loadAnimation("running",true)
		else
			self:loadAnimation("standing",true)
		end
		self.field.isActive=false
	end
end

function TheMagnetSolo:disableStaticField()
	if self.alive then
		if self.fieldSound~=nil then
			self.fieldSound:stop()
		end
		self.field.isActive=false
		self.appliesField=false
		self.fieldType=FieldTypes.None
		for i,m in ipairs(self.statMetals)  do
			m:cancelStaticField()
		end
		self.statMetals={}
		if self.animCounter>=1 then
			self:loadAnimation("running",true)
		else
			self:loadAnimation("standing",true)
		end
	end
end
-- Method that handles the begining of a movement
function TheMagnetSolo:startMove(  )
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

-- Method that handles the begining of a movement
function TheMagnetSolo:stopMove( )
	if self.alive then
		self.animCounter=self.animCounter-1
		x,y=self.pc.body:getLinearVelocity()
		self.pc.body:setLinearVelocity(x/TheMagnetConst.BreakFactor,y/TheMagnetConst.BreakFactor)
		if self.canjump and not self.isStatic  and self.animCounter==0 then
			if self.appliesField then
				self:loadAnimation("field",true)		
			else
				self:loadAnimation("stoprunning",true)
			end
		end
	end
end

-- Method that loads an animation
function TheMagnetSolo:loadAnimation(anim, force)
	self.anim:load(anim, force)
end


-- Method that updates the character state
function TheMagnetSolo:update(seconds)
	if self.fieldSound~=nil then
		self.fieldSound:update(seconds)
	end
	x,y =self.pc.body:getLinearVelocity()
	if x>TheMagnetConst.MaxSpeed then
		self.pc.body:setLinearVelocity(MetalManMaxSpeed,y)
	end

	if x<-TheMagnetConst.MaxSpeed then
		self.pc.body:setLinearVelocity(-MetalManMaxSpeed,y)
	end
	self.field:update(seconds,self.position.x,self.position.y)

	self.anim:update(seconds)
	x,y =self.pc.body:getPosition()
	self.position.x=x
	self.position.y=y
	if self.alive then
    -- if gameStateManager.state['GameplaySolo'].inputManager:isKeyDown("right") then --press the right arrow key to push the ball to the right
    if false then --press the right arrow key to push the ball to the right
  	self.goF=true
  	self.pc.body:applyForce(TheMagnetConst.MovingForce, 0)
  elseif false then --press the left arrow key to push the ball to the left
  -- elseif gameStateManager.state['GameplaySolo'].inputManager:isKeyDown("left") then --press the left arrow key to push the ball to the left
  	self.pc.body:applyForce(-TheMagnetConst.MovingForce,0)
  	self.goF=false
  end
end
for i,m in ipairs(self.statMetals)  do
	m:setVelocity(self.pc.body:getLinearVelocity())
end
self.camera:newPosition(self.position.x,self.position.y)
end



function TheMagnetSolo:draw()
	-- Draws the field
	self.field:draw(windowW/2+unitWorldSize/4, windowH/2+unitWorldSize/4)
	if 	 self.goF then
		love.graphics.draw(self.anim:getSprite(), self.diffuse,windowW/2-unitWorldSize/2,windowH/2-unitWorldSize/2, 0, 1,1)
	else
		love.graphics.draw(self.anim:getSprite(),self.diffuse, windowW/2+unitWorldSize/2,windowH/2-unitWorldSize/2,0 , -1,1)
	end
end

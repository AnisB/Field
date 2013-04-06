--[[ 
This file is part of the Field project
]]

-- Includes
require("game.camera")
require("game.animtm")
require("game.field")
require("game.attfield")
require("game.themagnetconst")
require("game.inputManager")
-- Class Init
TheMagnet = {}
TheMagnet.__index = TheMagnet


-- Constructor
function TheMagnet.new(camera,pos)

	-- Class init
	local self = {}
	setmetatable(self, TheMagnet)

	-- Id Init
	self.id=-1

	-- Camera Init
	self.camera=camera

	-- Posiiton Init
	self.position={x=pos.x,y=pos.y}

	-- Physics Init
	self.pc = Physics.newCharacter(self.position.x,self.position.y,unitWorldSize/2,false)
	self.pc.fixture:setUserData(self)
	self.pc.body:setMass(TheMagnetConst.Mass)

	-- State and animation init
	self:setState("standing")
	self.anim = AnimTM.new('themagnet')
	self:loadAnimation("standing",true)
	self.canjump=true
	self.goF=true
	self.animCounter=0

	-- Object's type
	self.type='TheMagnet'

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

	    -- Sound
	    self.fieldSound=Sound.getSound("field")


	    self.alive=true

	    return self
	end




	function TheMagnet:die()
		if self.alive then
			self:disableField()
			self:disableStaticField()
			self:loadAnimation("mortelec",true)	
			self.alive=false
			
		end
	end



-- This method handles a jump try
function TheMagnet:jump()
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
function TheMagnet:setState( state )
	self.currentState=state
end


-- This method tells if an object is affected by the magnetic field applied by this character
function TheMagnet:isAppliable(pos)
	local ax =pos.x-self.position.x
	local ay =pos.y-self.position.y
	if math.abs(math.sqrt(ax*ax+ay*ay))<=self.fieldRadius then
		return true
	else
		return false
	end
end

-- Error catch
function TheMagnet:enableG()
	print("Error")
end

-- Error catch
function TheMagnet:disableG()
	print("Error")
end

-- Return the objects position
function TheMagnet:getPosition()
	return self.position
end

-- Return the object's speed
function TheMagnet:getSpeed(  )
end


-- Method that handles the collision
function TheMagnet:collideWith( object, collision )
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
-- Method that handles the uncollision
function TheMagnet:unCollideWith( object, collision )
end


-- Add a static metal to the ones wich are affected by the static field
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
	if self.alive then
		self.field= Field.new(FieldTypes.Repulsive,pos)
		self.field.isActive=true
		self.appliesField=true
		self.fieldType=FieldTypes.Repulsive
		self:loadAnimation("launchfield",true)
	end
end

function TheMagnet:enableAttractiveField()

	if self.alive then
		self.field= AttField.new(pos)
		self.field.isActive=true
		self.appliesField=true
		self.fieldType=FieldTypes.Attractive
		self:loadAnimation("launchfield",true)
		Sound.playSound("field")
	end
end


function TheMagnet:enableStaticField()
	if self.alive then
		self.field= Field.new(FieldTypes.Static,pos)
		self.field.isActive=true
		self.appliesField=true
		self.fieldType=FieldTypes.Static
		self:loadAnimation("launchfield",true)
		Sound.playSound("field")
	end
end

function TheMagnet:enableRotativeLField()
	if self.alive then
		self.field= Field.new(FieldTypes.RotativeL,pos)
		self.field.isActive=true
		self.appliesField=true
		self:loadAnimation("launchfield",true)
		self.fieldType=FieldTypes.RotativeL
		Sound.playSound("field")
	end
end
function TheMagnet:enableRotativeRField()
	if self.alive then
		self.field= Field.new(FieldTypes.RotativeR,pos)
		self.field.isActive=true
		self.appliesField=true
		self.fieldType=FieldTypes.RotativeR
		self:loadAnimation("launchfield",true)
		Sound.playSound("field")
	end
end

-- In case of a static Metal
function TheMagnet:rotativeLField(pos)
	if self.alive then

		local vx=self.position.x-pos.x
		local vy=self.position.y-pos.y
		local n = math.sqrt(vx*vx+vy*vy)
		local vrx = vx/n
		local vry= vy/n
		self.pc.body:applyLinearImpulse(-vry*TheMagnetConst.Rot.x,vrx*TheMagnetConst.Rot.y)
		self:loadAnimation("launchfield",true)
	end
end

function TheMagnet:rotativeRField(pos)
	if self.alive then

		local vx=self.position.x-pos.x
		local vy=self.position.y-pos.y
		local n = math.sqrt(vx*vx+vy*vy)
		local vrx = vx/n
		local vry= vy/n
		self.pc.body:applyLinearImpulse(vry*TheMagnetConst.Rot.x,-vrx*TheMagnetConst.Rot.y)
		self:loadAnimation("launchfield",true)
	end
end

function TheMagnet:attractiveField(pos)
	if self.alive then

		local vx=self.position.x-pos.x
		local vy=self.position.y-pos.y
		local n = math.sqrt(vx*vx+vy*vy)
		local vrx = vx/n
		local vry= vy/n
		if(n>(unitWorldSize)) then 
			self.pc.body:applyLinearImpulse(-vrx*TheMagnetConst.Att.x,-vry*TheMagnetConst.Att.y)
		end
		self:loadAnimation("launchfield",true)
	end
	
end


function TheMagnet:repulsiveField(pos)
	if self.alive then

		local vx=-self.position.x+pos.x
		local vy=-self.position.y+pos.y
		local n = math.sqrt(vx*vx+vy*vy)
		local vrx = vx/n
		local vry= vy/n

		if(n>(unitWorldSize)) then 
			self.pc.body:applyLinearImpulse(-vrx*TheMagnetConst.Rep.x,-vry*TheMagnetConst.Rep.y)
		end
		self:loadAnimation("launchfield",true)
	end

end

-- Disabling fields

function TheMagnet:disableField()
	if self.alive then

	self.field.isActive=false
	self.appliesField=false
	self.fieldType=FieldTypes.None
	self:loadAnimation("standing",true)
	self.field.isActive=false
end
end

function TheMagnet:disableStaticField()
	if self.alive then

	self.field.isActive=false
	self.appliesField=false
	self.fieldType=FieldTypes.None
	for i,m in ipairs(self.statMetals)  do
		m:cancelStaticField()
	end
	self.statMetals={}
	self:loadAnimation("standing",true)
end
end

-- Method that handles the begining of a movement
function TheMagnet:startMove(  )
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
function TheMagnet:stopMove( )
	if self.alive then

		self.animCounter=self.animCounter-1
		x,y=self.pc.body:getLinearVelocity()
		self.pc.body:setLinearVelocity(x/TheMagnetConst.BreakFactor,y/TheMagnetConst.BreakFactor)
		if self.canjump and not self.isStatic  and self.animCounter==0 then
			self:loadAnimation("stoprunning",true)	end
		end
	end

-- Method that loads an animation
function TheMagnet:loadAnimation(anim, force)
	self.anim:load(anim, force)
end


-- Method that updates the character state
function TheMagnet:update(seconds)

	x,y =self.pc.body:getLinearVelocity()
	if x>TheMagnetConst.MaxSpeed then
		self.pc.body:setLinearVelocity(MetalManMaxSpeed,y)
	end

	if x<-TheMagnetConst.MaxSpeed then
		self.pc.body:setLinearVelocity(-MetalManMaxSpeed,y)
	end
	self.field:update(seconds,self.position.x,self.position.y)
	if self.appliesField then
		self.fieldSound:play()
	end

	self.anim:update(seconds)
	x,y =self.pc.body:getPosition()
	self.position.x=x
	self.position.y=y
	if self.alive then
  if inputManager:isKeyDown("right") then --press the right arrow key to push the ball to the right
  	self.goF=true
  	self.pc.body:applyForce(TheMagnetConst.MovingForce, 0)
  elseif inputManager:isKeyDown("left") then --press the left arrow key to push the ball to the left
  	self.pc.body:applyForce(-TheMagnetConst.MovingForce,0)
  	self.goF=false
  end
end
for i,m in ipairs(self.statMetals)  do
	m:setVelocity(self.pc.body:getLinearVelocity())
end
self.camera:newPosition(self.position.x,self.position.y)
end


-- Draws the character to screen
function TheMagnet:secondDraw(x,y)

	-- Draws the field
	self.field:draw(self.position.x-x+unitWorldSize/4, self.position.y+y+unitWorldSize/4)
	-- Draws the character
	love.graphics.setColor(255,255,255,255)
	if not self.goF then
		love.graphics.draw(self.anim:getSprite(), self.position.x-x+unitWorldSize/2, self.position.y+y-unitWorldSize/2, 0, -1,1)
	else
		love.graphics.draw(self.anim:getSprite(), self.position.x-x-unitWorldSize/2, self.position.y+y-unitWorldSize/2, 0, 1,1)
	end
end


function TheMagnet:draw()
	-- Draws the field
	self.field:draw(windowW/2+unitWorldSize/4, windowH/2+unitWorldSize/4)
	love.graphics.setColor(255,255,255,255)
	if 	 self.goF then
		love.graphics.draw(self.anim:getSprite(), windowW/2-unitWorldSize/2,windowH/2-unitWorldSize/2, 0, 1,1)
	else
		love.graphics.draw(self.anim:getSprite(), windowW/2+unitWorldSize/2,windowH/2-unitWorldSize/2,0 , -1,1)
	end
end


-- Return the character to screen
function TheMagnet:secondSend(x,y)
if self.goF then
	return ("@themagnet".."#"..self.anim:getImgInfo()[1].."#"..self.anim:getImgInfo()[2].."#"..math.floor(self.position.x-x-unitWorldSize/2).."#"..math.floor( self.position.y+y-unitWorldSize/2).."#".."1".."#"..tostring(self.appliesField).."#"..self.fieldType)
else
-- 	print("MDR")
	return ("@themagnet".."#"..self.anim:getImgInfo()[1].."#"..self.anim:getImgInfo()[2].."#"..math.floor(self.position.x-x+unitWorldSize/2).."#"..math.floor( self.position.y+y-unitWorldSize/2).."#".."-1".."#"..tostring(self.appliesField).."#"..self.fieldType)
end
end

-- Return the character to screen
function TheMagnet:mainSend(x,y)
if self.goF then
	return ("@themagnet".."#"..self.anim:getImgInfo()[1].."#"..self.anim:getImgInfo()[2].."#"..math.floor(windowW/2-unitWorldSize/2).."#"..math.floor( windowH/2-unitWorldSize/2).."#".."1")
else
	return ("@themagnet".."#"..self.anim:getImgInfo()[1].."#"..self.anim:getImgInfo()[2].."#"..math.floor(windowW/2+unitWorldSize/2).."#"..math.floor( windowH/2-unitWorldSize/2).."#".."-1")
end
end
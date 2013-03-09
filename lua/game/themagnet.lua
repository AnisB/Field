

-- Includes
require("game.camera")
require("game.animtm")
require("game.field")

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
	self.pc.body:setMass(0.05*unitWorldSize)

	-- State and animation init
	self:setState("standing")
	self.anim = AnimTM.new('themagnet')
	self:loadAnimation("standing",true)
	self.canjump=true
	self.goLeft=false
	self.animCounter=0

	-- Object's type
	self.type='TheMagnet'

	-- Field init

		-- Particle field managing
		self.field= Field.new(nil,FieldTypes.Static,pos)
		self.field.isActive=false
	
	    -- Other field attributes
	    self.appliesField=false
	    self.fieldType=FieldTypes.None

	    -- Static Field attributes
	    self.statMetals={}

	    -- Field Radius
	    self.fieldRadius=4*unitWorldSize

	    -- Field Strenght
	    self.strenght=2*unitWorldSize

	    -- Sound
	    self.fieldSound=Sound.getSound("field")

	return self
end


-- This method handles a jump try
function TheMagnet:jump()
	-- Trying to jump
	if self.canjump then
		-- The physics impulse
		self.pc.body:applyLinearImpulse(0, -10*unitWorldSize/(0.05*7))

		-- Animaiton and state changing
		self:setState("startjumping")
		self:loadAnimation("startjumping",true)
		self.canjump=false
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
	self.field.isActive=true
	self.appliesField=true
	self.fieldType=FieldTypes.Repulsive
	self:loadAnimation("field",true)
end

function TheMagnet:enableAttractiveField()
	self.field.isActive=true
	self.appliesField=true
	self.fieldType=FieldTypes.Attractive
	self:loadAnimation("field",true)
    Sound.playSound("field")
end
function TheMagnet:enableStaticField()
	self.field.isActive=true
	self.appliesField=true
	self.fieldType=FieldTypes.Static
	self:loadAnimation("field",true)
    Sound.playSound("field")
end

function TheMagnet:enableRotativeLField()
	self.field.isActive=true
	self.appliesField=true
	self:loadAnimation("field",true)
	self.fieldType=FieldTypes.RotativeL
    Sound.playSound("field")
end
function TheMagnet:enableRotativeRField()
	self.field.isActive=true
	self.appliesField=true
	self.fieldType=FieldTypes.RotativeR
	self:loadAnimation("field",true)
    Sound.playSound("field")
end


-- In case of a static Metal
function TheMagnet:rotativeLField(pos)
	local vx=self.position.x-pos.x
	local vy=self.position.y-pos.y
	local n = math.sqrt(vx*vx+vy*vy)
	local vrx = vx/n
	local vry= vy/n
	self.pc.body:applyLinearImpulse(vry*self.strenght,-vrx*self.strenght)
	self:loadAnimation("field",true)
end

function TheMagnet:rotativeRField(pos)
	local vx=self.position.x-pos.x
	local vy=self.position.y-pos.y
	local n = math.sqrt(vx*vx+vy*vy)
	local vrx = vx/n
	local vry= vy/n
	self.pc.body:applyLinearImpulse(-vry*self.strenght,vrx*self.strenght)
	self:loadAnimation("field",true)
end

function TheMagnet:attractiveField(pos)
	
	local vx=-self.position.x+pos.x
	local vy=-self.position.y+pos.y
	local n = math.sqrt(vx*vx+vy*vy)
	local vrx = vx/n
	local vry= vy/n
		self.pc.body:applyLinearImpulse(-vrx*self.strenght,-vry*self.strenght)
	self:loadAnimation("field",true)
	end


function TheMagnet:repulsiveField(pos)

		local vx=self.position.x-pos.x
	local vy=self.position.y-pos.y
	local n = math.sqrt(vx*vx+vy*vy)
	local vrx = vx/n
	local vry= vy/n
	if(n>(unitWorldSize)) then 
			self.pc.body:applyLinearImpulse(-vrx*self.strenght,-vry*self.strenght)
	end
	self:loadAnimation("field",true)

	end

-- Disabling fields

function TheMagnet:disableField()
	self.field.isActive=false
	self.appliesField=false
	self.fieldType=FieldTypes.None
	self:loadAnimation("standing",true)
	self.field.isActive=false
end

function TheMagnet:disableStaticField()
	self.field.isActive=false
	self.appliesField=false
	self.fieldType=FieldTypes.None
	for i,m in ipairs(self.statMetals)  do
		m:cancelStaticField()
		table.remove(self.statMetals,i)
	end
	self:loadAnimation("standing",true)
end

-- Method that handles the begining of a movement
function TheMagnet:startMove(  )
	self.animCounter=self.animCounter+1

	if self.canjump and not self.isStatic then
		self:loadAnimation("running",true)	end

end


-- Method that handles the begining of a movement
function TheMagnet:stopMove( )
		self.animCounter=self.animCounter-1

	if self.canjump and not self.isStatic  and self.animCounter==0 then
		self:loadAnimation("stoprunning",true)	end
end


-- Method that loads an animation
function TheMagnet:loadAnimation(anim, force)
		self.anim:load(anim, force)
end


-- Method that updates the character state
function TheMagnet:update(seconds)
	self.field:update(seconds,self.position.x,self.position.y)
	if self.appliesField then
		self.fieldSound:play()
	end
	self.anim:update(seconds)
	x,y =self.pc.body:getPosition()
	self.position.x=x
	self.position.y=y
  if love.keyboard.isDown("right") then --press the right arrow key to push the ball to the right
  	self.goLeft=false
  	self.pc.body:applyForce(unitWorldSize*40, 0)
  elseif love.keyboard.isDown("left") then --press the left arrow key to push the ball to the left
  	self.pc.body:applyForce(-unitWorldSize*40,0)
  	self.goLeft=true
  end
  for i,m in ipairs(self.statMetals)  do
  	m:setVelocity(self.pc.body:getLinearVelocity())
  end
end


-- Draws the character to screen
function TheMagnet:draw(x,y)

	-- Draws the field
	self.field:draw(self.position.x-x, self.position.y+y)
	-- Draws the character
	love.graphics.setColor(255,255,255,255)
	if self.goLeft then
	love.graphics.draw(self.anim:getSprite(), self.position.x-x+unitWorldSize/2*0.9, self.position.y+y-unitWorldSize/2*1.4, 0, -1.8,1.8)
	else
	love.graphics.draw(self.anim:getSprite(), self.position.x-x-unitWorldSize/2*1.4, self.position.y+y-unitWorldSize/2*1.4, 0, 1.8,1.8)
	end
end


require("game.field")



Gate = {}
Gate.__index = Gate


function Gate.new(pos,ID)
	local self = {}
	setmetatable(self, Gate)
	self.id=ID
	self.position={x=pos.x,y=pos.y}
    -- Type
    self.type='Gate' 
    decalage={unitWorldSize/2,unitWorldSize/2}
    self.pc = Physics.newRectangle(self.position.x,self.position.y,unitWorldSize,unitWorldSize,true,decalage)
    self.pc.fixture:setUserData(self)    
    self.typeG=type
	print(self.position.x,self.position.y)
	self.pc.fixture:setUserData(self)
	self.type='Gate'
	self.typeField=typeField
	self.appliesField=false
	self.fieldType=FieldTypes.None
	self.statMetals={}
	self.fieldRadius=4*unitWorldSize
	self.strenght=5*unitWorldSize
	self.on= false
	self.field=Field.new(nil,typeField,{x=0,y=0})
	return self
end

	function Gate:isAppliable(pos)
		local ax =pos.x-self.position.x
		local ay =pos.y-self.position.y
		if math.abs(math.sqrt(ax*ax+ay*ay))<=self.fieldRadius then
			return true
		else
			return false
		end
	end
	
	function Gate:getPosition()
		return self.position
	end
	

	
	function Gate:collideWith( object, collision )
	end
	
	function Gate:unCollideWith( object, collision )

	end

	function Gate:enableG( )
		print("Youhouw")
		self.field.isActive=true
		if self.typeField == FieldTypes.RotativeL then
			self:enableRotativeLField()
		--
		elseif self.typeField == FieldTypes.RotativeR then
			self:enableRotativeRField()
		--
		elseif self.typeField == FieldTypes.Repulsive then
			self:enableRepulsiveField()
	    --
	    elseif self.typeField == FieldTypes.Attractive then
	    	self:enableAttractiveField()
	     --
	     elseif self.typeField == FieldTypes.Static then
	     	self:enableStaticField()
	     end
	end

	function Gate:disableG( )
		self.field.isActive=false
		if self.typeField == FieldTypes.Static then
			self:disableStaticField()
		else
			self:disableField()
		end
		self.appliesField=false

	end


function Gate:addStatMetal(metal)
  for _, value in pairs(self.statMetals) do
    if value == metal then
      return 
    end
  end
  metal:initStaticField()
	table.insert(self.statMetals,metal)
end

-- Enabling fields
function Gate:enableRepulsiveField()
	self.appliesField=true
	self.fieldType=FieldTypes.Repulsive
end

function Gate:enableAttractiveField()
	self.appliesField=true
	self.fieldType=FieldTypes.Attractive
end
function Gate:enableStaticField()
	self.appliesField=true
	self.fieldType=FieldTypes.Static
end

function Gate:enableRotativeLField()
	self.appliesField=true
	self.fieldType=FieldTypes.RotativeL
end
function Gate:enableRotativeRField()
	self.appliesField=true
	self.fieldType=FieldTypes.RotativeR
end

-- Disabling fields

function Gate:disableField()
	self.appliesField=false
	self.fieldType=FieldTypes.None
end


function Gate:rotativeLField(pos)

end

function Gate:rotativeRField(pos)
	if not self.typeG then
	local vx=self.position.x-pos.x
	local vy=self.position.y-pos.y
	local n = math.sqrt(vx*vx+vy*vy)
	local vrx = vx/n
	local vry= vy/n
	self.pc.body:applyLinearImpulse(-vry*self.strenght,vrx*self.strenght)
end
end

function Gate:attractiveField(pos)
	if not self.typeG then
		local vx=self.position.x-pos.x
		local vy=self.position.y-pos.y
		local n = math.sqrt(vx*vx+vy*vy)
		local vrx = vx/n
		local vry= vy/n
		if(n>(unitWorldSize)) then 
			self.pc.body:applyLinearImpulse(-vrx*self.strenght,-vry*self.strenght)
		end
	end
end

function Gate:repulsiveField(pos)
	if not self.typeG then
	local vx=-self.position.x+pos.x
	local vy=-self.position.y+pos.y
	local n = math.sqrt(vx*vx+vy*vy)
	local vrx = vx/n
	local vry= vy/n
		self.pc.body:applyLinearImpulse(-vrx*self.strenght,-vry*self.strenght)
	end
	end

function Gate:disableStaticField()
	self.appliesField=false
	self.fieldType=FieldTypes.None
	for i,m in ipairs(self.statMetals)  do
		m:cancelStaticField()
		table.remove(self.statMetals,i)
	end
end

function Gate:changeState( newState )
	self.on=newState
end


function Gate:getPosition(  )
	return self.position
end

function Gate:update(seconds)
	self.field:update(seconds)
	x,y =self.pc.body:getPosition()
	self.position.x=x
	self.position.y=y
    for i,m in ipairs(self.statMetals)  do
		m:setVelocity(self.pc.body:getLinearVelocity())
	end
end

function Gate:draw(x,y)
	self.field:draw(self.pc.body:getX()-x, self.pc.body:getY()+y)
	love.graphics.setColor(255,100,100,255)
	love.graphics.circle("fill", self.pc.body:getX()-x, self.pc.body:getY()+y, self.pc.shape:getRadius())
end
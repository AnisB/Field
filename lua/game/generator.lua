

require("game.field")



Generator = {}
Generator.__index = Generator


function Generator.new(pos,type,typeField,ID)
	local self = {}
	setmetatable(self, Generator)
	print(pos)
	self.id=ID
	self.position={x=pos.x,y=pos.y}
	self.pc = Physics.newSphere(self.position.x,self.position.y,unitWorldSize/2,type)
	self.typeG=type
	print(self.position.x,self.position.y)
	self.pc.fixture:setUserData(self)
	self.type='Generator'
	if typefield=='repulse' then
	self.typeField='Repulsive'
	elseif typefield=='attract' then
	self.typeField='Attractive'
	elseif typefield=='clockwise' then
	self.typeField='Repulsive'
	elseif typefield=='anticlockwise' then
	self.typeField='RotativeL'
	elseif typefield=='repulsive' then
	self.typeField='RotativeR'
	end

	self.appliesField=false
	self.fieldType=FieldTypes.None
	self.statMetals={}
	self.fieldRadius=4*unitWorldSize
	self.strenght=5*unitWorldSize
	self.on= false
	self.field=Field.new(typeField,{x=0,y=0})
	self.w=unitWorldSize
	self.h=unitWorldSize
	return self
end

	function Generator:isAppliable(pos)
		local ax =pos.x-self.position.x
		local ay =pos.y-self.position.y
		if math.abs(math.sqrt(ax*ax+ay*ay))<=self.fieldRadius then
			return true
		else
			return false
		end
	end
	
	function Generator:getPosition()
		return self.position
	end
	

	
	function Generator:collideWith( object, collision )
	end
	
	function Generator:unCollideWith( object, collision )

	end

	function Generator:enableG( )
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

	function Generator:disableG( )
		print("DOH")

		self.field.isActive=false
		if self.typeField == FieldTypes.Static then
			self:disableStaticField()
		else
			self:disableField()
		end
		self.appliesField=false

	end


function Generator:addStatMetal(metal)
  for _, value in pairs(self.statMetals) do
    if value == metal then
      return 
    end
  end
  metal:initStaticField()
	table.insert(self.statMetals,metal)
end

-- Enabling fields
function Generator:enableRepulsiveField()
	self.appliesField=true
	self.fieldType=FieldTypes.Repulsive
end

function Generator:enableAttractiveField()
	self.appliesField=true
	self.fieldType=FieldTypes.Attractive
end
function Generator:enableStaticField()
	self.appliesField=true
	self.fieldType=FieldTypes.Static
end

function Generator:enableRotativeLField()
	self.appliesField=true
	self.fieldType=FieldTypes.RotativeL
end
function Generator:enableRotativeRField()
	self.appliesField=true
	self.fieldType=FieldTypes.RotativeR
end

-- Disabling fields

function Generator:disableField()
	self.appliesField=false
	self.fieldType=FieldTypes.None
end


function Generator:rotativeLField(pos)

end

function Generator:rotativeRField(pos)
	if not self.typeG then
	local vx=self.position.x-pos.x
	local vy=self.position.y-pos.y
	local n = math.sqrt(vx*vx+vy*vy)
	local vrx = vx/n
	local vry= vy/n
	self.pc.body:applyLinearImpulse(-vry*self.strenght,vrx*self.strenght)
end
end

function Generator:attractiveField(pos)
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

function Generator:repulsiveField(pos)
	if not self.typeG then
	local vx=-self.position.x+pos.x
	local vy=-self.position.y+pos.y
	local n = math.sqrt(vx*vx+vy*vy)
	local vrx = vx/n
	local vry= vy/n
		self.pc.body:applyLinearImpulse(-vrx*self.strenght,-vry*self.strenght)
	end
	end

function Generator:disableStaticField()
	self.appliesField=false
	self.fieldType=FieldTypes.None
	for i,m in ipairs(self.statMetals)  do
		m:cancelStaticField()
		table.remove(self.statMetals,i)
	end
end

function Generator:changeState( newState )
	self.on=newState
end


function Generator:getPosition(  )
	return self.position
end

function Generator:update(seconds)
	self.field:update(seconds)
	x,y =self.pc.body:getPosition()
	self.position.x=x
	self.position.y=y
    for i,m in ipairs(self.statMetals)  do
		m:setVelocity(self.pc.body:getLinearVelocity())
	end
end

function Generator:draw(x,y)
	self.field:draw(self.pc.body:getX()-x, self.pc.body:getY()+y)
	love.graphics.setColor(255,100,100,255)
	love.graphics.circle("fill", self.pc.body:getX()-x, self.pc.body:getY()+y, self.pc.shape:getRadius())
	self.typeField='Repulsive'
end
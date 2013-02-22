



Generateur = {}
Generateur.__index = Generateur


function Generateur.new(pos,type)
	local self = {}
	setmetatable(self, Generateur)
	print(pos)
	self.position={x=pos.x,y=pos.y}
	self.pc = Physics.newSphere(self.position.x,self.position.y,unitWorldSize/2,type)
	self.typeG=type
	print(self.position.x,self.position.y)
	self.pc.fixture:setUserData(self)
	self.type='Generateur'
	self.appliesField=false
	self.fieldType=FieldTypes.None
	self.statMetals={}
	self.fieldRadius=4*unitWorldSize
	self.strenght=5*unitWorldSize
	self.on= false
	return self
end

function Generateur:isAppliable(pos)
	 local ax =pos.x-self.position.x
	 local ay =pos.y-self.position.y
	if math.abs(math.sqrt(ax*ax+ay*ay))<=self.fieldRadius then
	return true
	else
		return false
	end
end

function Generateur:getPosition()
	return self.position
end



function Generateur:collideWith( object, collision )
end

function Generateur:unCollideWith( object, collision )

end

function Generateur:addStatMetal(metal)
  for _, value in pairs(self.statMetals) do
    if value == metal then
      return 
    end
  end
  metal:initStaticField()
	table.insert(self.statMetals,metal)
end

-- Enabling fields
function Generateur:enableRepulsiveField()
	self.appliesField=true
	self.fieldType=FieldTypes.Repulsive
end

function Generateur:enableAttractiveField()
	self.appliesField=true
	self.fieldType=FieldTypes.Attractive
end
function Generateur:enableStaticField()
	self.appliesField=true
	self.fieldType=FieldTypes.Static
end

function Generateur:enableRotativeLField()
	self.appliesField=true
	self.fieldType=FieldTypes.RotativeL
end
function Generateur:enableRotativeRField()
	self.appliesField=true
	self.fieldType=FieldTypes.RotativeR
end

-- Disabling fields

function Generateur:disableField()
	self.appliesField=false
	self.fieldType=FieldTypes.None
end


function Generateur:rotativeLField(pos)

end

function Generateur:rotativeRField(pos)
	if not self.typeG then
	local vx=self.position.x-pos.x
	local vy=self.position.y-pos.y
	local n = math.sqrt(vx*vx+vy*vy)
	local vrx = vx/n
	local vry= vy/n
	self.pc.body:applyLinearImpulse(-vry*self.strenght,vrx*self.strenght)
end
end

function Generateur:attractiveField(pos)
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

function Generateur:repulsiveField(pos)
	if not self.typeG then
	local vx=-self.position.x+pos.x
	local vy=-self.position.y+pos.y
	local n = math.sqrt(vx*vx+vy*vy)
	local vrx = vx/n
	local vry= vy/n
		self.pc.body:applyLinearImpulse(-vrx*self.strenght,-vry*self.strenght)
	end
	end

function Generateur:disableStaticField()
	self.appliesField=false
	self.fieldType=FieldTypes.None
	for i,m in ipairs(self.statMetals)  do
		m:cancelStaticField()
		table.remove(self.statMetals,i)
	end
end

function Generateur:changeState( newState )
	self.on=newState
end


function Generateur:getPosition(  )
	return self.position
end

function Generateur:update(seconds)
	x,y =self.pc.body:getPosition()
	self.position.x=x
	self.position.y=y
    for i,m in ipairs(self.statMetals)  do
		m:setVelocity(self.pc.body:getLinearVelocity())
	end
end

function Generateur:draw(x,y)
	love.graphics.setColor(255,100,100,255)
	love.graphics.circle("fill", self.pc.body:getX()-x, self.pc.body:getY()+y, self.pc.shape:getRadius())
end


require("game.field")
require("game.attfield")
require("game.animgene")


GeneratorSolo = {}
GeneratorSolo.__index = GeneratorSolo


function GeneratorSolo.new(pos,type,typeField,ID,netid)
	local self = {}
	setmetatable(self, GeneratorSolo)
	self.netid=netid
	self.id=tonumber(ID)
	print(self.id)
	self.position={x=pos.x,y=pos.y}
	self.pc = Physics.newSphere(self.position.x+unitWorldSize/2,self.position.y+unitWorldSize/2,unitWorldSize/2,type)
	self.typeG=type
	self.pc.fixture:setUserData(self)
	self.type='GeneratorSolo'

	if typeField == "Repulsive" then
		self.typeField = FieldTypes.Repulsive
	elseif typeField == "Attractive" then
		self.typeField=FieldTypes.Attractive
	elseif typeField == "RotativeR" then
		self.typeField=FieldTypes.RotativeR
	elseif typeField == "RotativeL" then
		self.typeField = FieldTypes.RotativeL
	end

	self.appliesField=false
	self.fieldType=FieldTypes.None
	self.statMetals={}
	self.fieldRadius=4*unitWorldSize
	self.strenght=5*unitWorldSize
	self.on= false
	if self.typeField==FieldTypes.Attractive then
		self.field=AttField.new({x=0,y=0})
	else
		self.field=Field.new(self.typeField,{x=0,y=0})
	end
	self.w=unitWorldSize
	self.h=unitWorldSize

	self.anim = AnimGene.new('gene')
	self.quad  = love.graphics.newQuad(0, 0, 64, 64, 128, 64)

	return self
end

function GeneratorSolo:init()
end

function GeneratorSolo:isAppliable(pos)
	local ax =pos.x-self.position.x
	local ay =pos.y-self.position.y
	if math.abs(math.sqrt(ax*ax+ay*ay))<=self.fieldRadius then
		return true
	else
		return false
	end
end

function GeneratorSolo:getPosition()
	return self.position
end

function GeneratorSolo:collideWith( object, collision )
end

function GeneratorSolo:unCollideWith( object, collision )

end

function GeneratorSolo:enableG( )
	self:loadAnimation("launching",true)
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

function GeneratorSolo:disableG( )
	self:loadAnimation("shutdown",true)
	self.field.isActive=false
	if self.typeField == FieldTypes.Static then
		self:disableStaticField()
	else
		self:disableField()
	end
	self.appliesField=false
end


function GeneratorSolo:addStatMetal(metal)
	for _, value in pairs(self.statMetals) do
		if value == metal then
			return 
		end
	end
	metal:initStaticField()
	table.insert(self.statMetals,metal)
end

-- Enabling fields
function GeneratorSolo:enableRepulsiveField()
	self.appliesField=true
	self.fieldType=FieldTypes.Repulsive
end

function GeneratorSolo:enableAttractiveField()
	self.appliesField=true
	self.fieldType=FieldTypes.Attractive
end
function GeneratorSolo:enableStaticField()
	self.appliesField=true
	self.fieldType=FieldTypes.Static
end

function GeneratorSolo:enableRotativeLField()
	self.appliesField=true
	self.fieldType=FieldTypes.RotativeL
end
function GeneratorSolo:enableRotativeRField()
	self.appliesField=true
	self.fieldType=FieldTypes.RotativeR
end

-- Disabling fields

function GeneratorSolo:disableField()
	self.appliesField=false
	self.fieldType=FieldTypes.None
end


function GeneratorSolo:rotativeLField(pos)

end

function GeneratorSolo:rotativeRField(pos)
	if not self.typeG then
		local vx=self.position.x-pos.x
		local vy=self.position.y-pos.y
		local n = math.sqrt(vx*vx+vy*vy)
		local vrx = vx/n
		local vry= vy/n
		self.pc.body:applyLinearImpulse(-vry*self.strenght,vrx*self.strenght)
	end
end

function GeneratorSolo:attractiveField(pos)
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

function GeneratorSolo:repulsiveField(pos)
	if not self.typeG then
		local vx=-self.position.x+pos.x
		local vy=-self.position.y+pos.y
		local n = math.sqrt(vx*vx+vy*vy)
		local vrx = vx/n
		local vry= vy/n
		self.pc.body:applyLinearImpulse(-vrx*self.strenght,-vry*self.strenght)
	end
end

function GeneratorSolo:disableStaticField()
	self.appliesField=false
	self.fieldType=FieldTypes.None
	for i,m in ipairs(self.statMetals)  do
		m:cancelStaticField()
		table.remove(self.statMetals,i)
	end
end

function GeneratorSolo:changeState( newState )
	self.on=newState
end


function GeneratorSolo:getPosition(  )
	return self.position
end

function GeneratorSolo:update(seconds)
	self.field:update(seconds)
	self.anim:update(seconds)

	x,y =self.pc.body:getPosition()
	self.position.x=x
	self.position.y=y
	for i,m in ipairs(self.statMetals)  do
		m:setVelocity(self.pc.body:getLinearVelocity())
	end
end


function GeneratorSolo:loadAnimation(anim, force)
	self.anim:load(anim, force)
end

function GeneratorSolo:draw(x,y)
	if self.typeField =="Attractive" then
		self.field:draw(self.pc.body:getX()-x-unitWorldSize/2, self.pc.body:getY()+y-unitWorldSize/2)
	else
		self.field:draw(self.pc.body:getX()-x, self.pc.body:getY()+y)
	end
	love.graphics.draw(self.anim:getSprite(), self.quad,self.position.x-x-unitWorldSize/2, self.position.y+y-unitWorldSize/2)
end



function GeneratorSolo:isTurnedOn()
	return self.field.isActive
end
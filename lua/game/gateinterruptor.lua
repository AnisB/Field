
--[[ 
This file is part of the Field project]]


require("game.animinter")
GateInterruptor = {}
GateInterruptor.__index = GateInterruptor


function GateInterruptor.new(pos,type,gateID,mapLoader,enabled)
	local self = {}
	setmetatable(self, GateInterruptor)
	self.position={x=pos.x,y=pos.y}
	local decalage={unitWorldSize/4,unitWorldSize/4}
	self.pc = Physics.newInterruptor(self.position.x,self.position.y,unitWorldSize/2,unitWorldSize/2,type,decalage)
	self.typeG=type
	self.anim = AnimInter.new('inter')
	self.pc.fixture:setUserData(self)
	self.type='GateInterruptor'

	if enabled then
		self.on=true
		self:loadAnimation("on",true)
	else
		self.on= false
		self:loadAnimation("off",true)

	end
	self.canBeEnable=0
	self.mapLoader=mapLoader
	self.gateID= gateID
	self.w=unitWorldSize/2
	self.h=unitWorldSize/2

	return self
end


function GateInterruptor:isAppliable(pos)
	 local ax =pos.x-self.position.x
	 local ay =pos.y-self.position.y
	if math.abs(math.sqrt(ax*ax+ay*ay))<=self.fieldRadius then
	return true
	else
		return false
	end
end



function GateInterruptor:getPosition()
	return self.position
end

function GateInterruptor:handleTry()
	if self.canBeEnable>0 then
		self.on= not self.on
		if self.on then
			self.mapLoader:openG(self.gateID)
			self:loadAnimation("launching",true)

		else
			self:loadAnimation("shutdown",true)
			self.mapLoader:closeG(self.gateID)

		end
	end
end

function GateInterruptor:loadAnimation(anim, force)
		self.anim:load(anim, force)
end

function GateInterruptor:preSolve(b,coll)
end



function GateInterruptor:collideWith( object, collision )
	if object.type=='MetalMan' or object.type =='TheMagnet' then
		self.canBeEnable =self.canBeEnable+1
		collision:resetRestitution( )
	end
end

function GateInterruptor:unCollideWith( object, collision )
	if object.type=='MetalMan' or object.type =='TheMagnet' then
		self.canBeEnable =self.canBeEnable-1
	end
end

function GateInterruptor:addStatMetal(metal)
  for _, value in pairs(self.statMetals) do
    if value == metal then
      return 
    end
  end
  metal:initStaticField()
	table.insert(self.statMetals,metal)
end


function GateInterruptor:changeState( newState )
	self.on=newState
end


function GateInterruptor:getPosition(  )
	return self.position
end

function GateInterruptor:update(seconds)
	self.anim:update(seconds)
	x,y =self.pc.body:getPosition()
	self.position.x=x
	self.position.y=y
end

function GateInterruptor:draw(x,y)
	love.graphics.setColor(255,255,255,255)
    	love.graphics.draw(self.anim:getSprite(), self.position.x-x, self.position.y+y)

end
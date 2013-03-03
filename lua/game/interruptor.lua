



Interruptor = {}
Interruptor.__index = Interruptor


function Interruptor.new(pos,type,generatorID,magnetManager)
	local self = {}
	setmetatable(self, Interruptor)
	print(pos)
	self.position={x=pos.x,y=pos.y}
	local decalage={unitWorldSize/4,unitWorldSize/4}
	self.pc = Physics.newInterruptor(self.position.x,self.position.y,unitWorldSize/2,unitWorldSize/2,type,decalage)
	self.typeG=type
	print(self.position.x,self.position.y)
	self.pc.fixture:setUserData(self)
	self.type='Interruptor'
	self.on= false
	self.canBeEnable=0
	self.magnetManager=magnetManager
	self.generatorID= generatorID
	return self
end


function Interruptor:isAppliable(pos)
	 local ax =pos.x-self.position.x
	 local ay =pos.y-self.position.y
	if math.abs(math.sqrt(ax*ax+ay*ay))<=self.fieldRadius then
	return true
	else
		return false
	end
end



function Interruptor:getPosition()
	return self.position
end

function Interruptor:handleTry()
	if self.canBeEnable>0 then
		self.on= not self.on
		if self.on then
			self.magnetManager:enableG(self.generatorID)
		else
			self.magnetManager:disableG(self.generatorID)

		end
	end
end



function Interruptor:preSolve(b,coll)
end



function Interruptor:collideWith( object, collision )
	if object.type=='MetalMan' or object.type =='TheMagnet' then
		self.canBeEnable =self.canBeEnable+1
		print("value"..self.canBeEnable)
		collision:resetRestitution( )
	end
end

function Interruptor:unCollideWith( object, collision )
	if object.type=='MetalMan' or object.type =='TheMagnet' then
		self.canBeEnable =self.canBeEnable-1
		print("value"..self.canBeEnable)
	end
end

function Interruptor:addStatMetal(metal)
  for _, value in pairs(self.statMetals) do
    if value == metal then
      return 
    end
  end
  metal:initStaticField()
	table.insert(self.statMetals,metal)
end


function Interruptor:changeState( newState )
	self.on=newState
end


function Interruptor:getPosition(  )
	return self.position
end

function Interruptor:update(seconds)
	x,y =self.pc.body:getPosition()
	self.position.x=x
	self.position.y=y
end

function Interruptor:draw(x,y)
	love.graphics.setColor(100,100,100,255)
       love.graphics.rectangle( "fill", self.position.x-x,self.position.y+y, unitWorldSize/2, unitWorldSize/2)
end
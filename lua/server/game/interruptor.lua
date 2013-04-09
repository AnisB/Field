

require("game.animinter")


Interruptor = {}
Interruptor.__index = Interruptor


function Interruptor.new(pos,type,generatorID,magnetManager,sprite,netid)
	local self = {}
	setmetatable(self, Interruptor)
	self.netid=netid
	self.position={x=pos.x,y=pos.y}
	local decalage={unitWorldSize/2,unitWorldSize/2}
	self.pc = Physics.newInterruptor(self.position.x,self.position.y,unitWorldSize,unitWorldSize,type,decalage)
	self.typeG=type
	self.w=unitWorldSize
	self.h=unitWorldSize
	self.pc.fixture:setUserData(self)
	self.type='Interruptor'
	self.on= false
	self.canBeEnableMM=0
	self.canBeEnableTM=0
	self.magnetManager=magnetManager
	self.generatorID= generatorID
	self.anim = AnimInter.new('inter')
	self:loadAnimation("off",true)
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

function Interruptor:handleTry(tryer)

	if tryer=='MetalMan' then
		if self.canBeEnableMM>0 then
			self.on= not self.on
			if self.on then
				self.magnetManager:enableG(self.generatorID)
				self:loadAnimation("launching",true)

			else
				self.magnetManager:disableG(self.generatorID)
				self:loadAnimation("shutdown",true)


			end
		end
	elseif tryer=='TheMagnet' then
		if self.canBeEnableTM>0 then
			self.on= not self.on
			if self.on then
				self.magnetManager:enableG(self.generatorID)
				self:loadAnimation("launching",true)

			else
				self.magnetManager:disableG(self.generatorID)
				self:loadAnimation("shutdown",true)
			end
		end
	end
end



function Interruptor:preSolve(b,coll)
end



function Interruptor:collideWith( object, collision )
	if object.type=='MetalMan' then
		self.canBeEnableMM =self.canBeEnableMM+1
	end
	if object.type =='TheMagnet' then
		self.canBeEnableTM =self.canBeEnableTM+1
	end
end

function Interruptor:unCollideWith( object, collision )
	if object.type=='MetalMan' then
		self.canBeEnableMM =self.canBeEnableMM-1
	end
	if object.type =='TheMagnet' then
		self.canBeEnableTM =self.canBeEnableTM-1
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

function Interruptor:loadAnimation(anim, force)
		self.anim:load(anim, force)
end

function Interruptor:update(seconds)
	self.anim:update(seconds)
	x,y =self.pc.body:getPosition()
	self.position.x=x
	self.position.y=y
end

function Interruptor:draw(x,y)
	love.graphics.setColor(255,255,255,255)
    	love.graphics.draw(self.anim:getSprite(), self.position.x-x, self.position.y+y)

end

function Interruptor:send(x,y)
    return ("@interruptor".."#"..self.netid.."#"..self.anim:getImgInfo()[1].."#"..self.anim:getImgInfo()[2].."#"..math.floor(self.position.x-x).."#"..math.floor( self.position.y+y))
end
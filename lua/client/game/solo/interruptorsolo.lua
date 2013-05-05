

require("game.solo.animintersolo")


InterruptorSolo = {}
InterruptorSolo.__index = InterruptorSolo


function InterruptorSolo.new(pos,type,generatorID,magnetManager,sprite,netid)
	local self = {}
	setmetatable(self, InterruptorSolo)
	self.netid=netid
	self.position={x=pos.x,y=pos.y}
	local decalage={unitWorldSize/2,unitWorldSize/2}
	self.pc = Physics.newInterruptor(self.position.x,self.position.y,unitWorldSize,unitWorldSize,type,decalage)
	self.typeG=type
	self.w=unitWorldSize
	self.h=unitWorldSize
	self.pc.fixture:setUserData(self)
	self.type='InterruptorSolo'
	self.on= false
	self.canBeEnableMM=0
	self.canBeEnableTM=0
	self.magnetManager=magnetManager
	self.generatorID= generatorID
	self.anim = AnimInterSolo.new('inter')
	self:loadAnimation("off",true)
	return self
end


function InterruptorSolo:isAppliable(pos)
	local ax =pos.x-self.position.x
	local ay =pos.y-self.position.y
	if math.abs(math.sqrt(ax*ax+ay*ay))<=self.fieldRadius then
		return true
	else
		return false
	end
end



function InterruptorSolo:getPosition()
	return self.position
end

function InterruptorSolo:handleTry(tryer)

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



function InterruptorSolo:preSolve(b,coll)
end



function InterruptorSolo:collideWith( object, collision )
	if object.type=='MetalManSolo' then
		self.canBeEnableMM =self.canBeEnableMM+1
	end
	if object.type =='TheMagnetSolo' then
		self.canBeEnableTM =self.canBeEnableTM+1
	end
end

function InterruptorSolo:unCollideWith( object, collision )
	if object.type=='MetalManSolo' then
		self.canBeEnableMM =self.canBeEnableMM-1
	end
	if object.type =='TheMagnetSolo' then
		self.canBeEnableTM =self.canBeEnableTM-1
	end
end

function InterruptorSolo:addStatMetal(metal)
	for _, value in pairs(self.statMetals) do
		if value == metal then
			return 
		end
	end
	metal:initStaticField()
	table.insert(self.statMetals,metal)
end


function InterruptorSolo:changeState( newState )
	self.on=newState
end


function InterruptorSolo:getPosition(  )
	return self.position
end

function InterruptorSolo:loadAnimation(anim, force)
		self.anim:load(anim, force)
end

function InterruptorSolo:update(seconds)
	self.anim:update(seconds)
	x,y =self.pc.body:getPosition()
	self.position.x=x
	self.position.y=y
end

function InterruptorSolo:draw(x,y)
	love.graphics.setColor(255,255,255,255)
    	love.graphics.draw(self.anim:getSprite(), self.position.x-x, self.position.y+y)

end

function InterruptorSolo:send(x,y)
    return ("@interruptorSolo".."#"..self.netid.."#"..self.anim:getImgInfo()[1].."#"..self.anim:getImgInfo()[2].."#"..math.floor(self.position.x-x).."#"..math.floor( self.position.y+y))
end
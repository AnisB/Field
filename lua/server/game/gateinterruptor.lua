
--[[ 
This file is part of the Field project]]


require("game.animinter")
GateInterruptor = {}
GateInterruptor.__index = GateInterruptor

GateInterruptorTimer =0.5
function GateInterruptor.new(pos,type,gateOpenID,gateCloseID,mapLoader,enabled,netid)
	local self = {}
	setmetatable(self, GateInterruptor)

	self.netid=netid
	self.position={x=pos.x,y=pos.y}
	local decalage={unitWorldSize/2,unitWorldSize/2}
	self.pc = Physics.newInterruptor(self.position.x,self.position.y,unitWorldSize,unitWorldSize,type,decalage)
	self.typeG=type
	self.anim = AnimInter.new('switch/gate')
	self.pc.fixture:setUserData(self)
	self.type='GateInterruptor'

	if enabled then
		self.on=true
		self:loadAnimation("on",true)
	else
		self.on= false
		self:loadAnimation("off",true)

	end
	self.canBeEnableTM=0
	self.canBeEnableMM=0
	self.mapLoader=mapLoader
	self.gateOpenID= gateOpenID
	self.gateCloseID= gateCloseID
	self.w=unitWorldSize
	self.h=unitWorldSize

	self.timer=0

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
function GateInterruptor:handleTry(tryer)

	if self.timer ==0 then
		self.timer=GateInterruptorTimer 
		if tryer=='MetalMan' then
			if self.canBeEnableMM>0 then
				self.on= not self.on
				if self.on then
					self.mapLoader:openG(self.gateOpenID)
					self:loadAnimation("launching",true)

				else
					self.mapLoader:closeG(self.gateCloseID)
					self:loadAnimation("shutdown",true)


				end
			end
		elseif tryer=='TheMagnet' then
			if self.canBeEnableTM>0 then
				self.on= not self.on
				if self.on then
					self.mapLoader:openG(self.gateOpenID)
					self:loadAnimation("launching",true)

				else
					self.mapLoader:closeG(self.gateCloseID)
					self:loadAnimation("shutdown",true)
				end
			end
		end
	end
end


function GateInterruptor:preSolve(b,coll)
end



function GateInterruptor:collideWith( object, collision )
	if object.type=='MetalMan' then
		self.canBeEnableMM =self.canBeEnableMM+1
	end
	if object.type =='TheMagnet' then
		self.canBeEnableTM =self.canBeEnableTM+1
	end
end

function GateInterruptor:unCollideWith( object, collision )
	if object.type=='MetalMan' then
		self.canBeEnableMM =self.canBeEnableMM-1
	end
	if object.type =='TheMagnet' then
		self.canBeEnableTM =self.canBeEnableTM-1
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
	if self.timer>0 then
		self.timer=self.timer-seconds
		if self.timer<=0 then
			self.timer=0
		end
	end
	self.anim:update(seconds)
	x,y =self.pc.body:getPosition()
	self.position.x=x
	self.position.y=y
end



function GateInterruptor:loadAnimation(anim, force)
		self.anim:load(anim, force)
end

function GateInterruptor:draw(x,y)
	love.graphics.setColor(255,255,255,255)
    	love.graphics.draw(self.anim:getSprite(), self.position.x-x, self.position.y+y)

end

function GateInterruptor:send(x,y)
    return ("@gateinterruptor".."#"..self.netid.."#"..self.anim:getImgInfo()[1].."#"..self.anim:getImgInfo()[2].."#"..math.floor(self.position.x-x).."#"..math.floor(self.position.y+y))
end
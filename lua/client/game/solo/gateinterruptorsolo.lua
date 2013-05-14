
--[[ 
This file is part of the Field project]]


require("game.solo.animintersolo")
GateInterruptorSolo = {}
GateInterruptorSolo.__index = GateInterruptorSolo

GateInterruptorSoloTimer =0.5
function GateInterruptorSolo.new(pos,type,gateOpenID,gateCloseID,mapLoader,enabled,netid)
	local self = {}
	setmetatable(self, GateInterruptorSolo)

	self.netid=netid
	self.position={x=pos.x,y=pos.y}
	local decalage={unitWorldSize/2,unitWorldSize/2}
	self.pc = Physics.newInterruptor(self.position.x,self.position.y,unitWorldSize,unitWorldSize,type,decalage)
	self.typeG=type
	self.anim = AnimInterSolo.new('inter')
	self.pc.fixture:setUserData(self)
	self.type='GateInterruptorSolo'


	self.canBeEnableTM=0
	self.canBeEnableMM=0
	self.mapLoader=mapLoader
	self.gateOpenID= gateOpenID
	self.gateCloseID= gateCloseID
	self.w=unitWorldSize
	self.h=unitWorldSize

	self.timer=0
	self.quad= love.graphics.newQuad(0, 0, unitWorldSize, unitWorldSize, unitWorldSize*2,unitWorldSize)

	return self
end
function GateInterruptorSolo:init()
	if enabled then
		self.on=true
		self:loadAnimation("on",true)
	else
		self.on= false
		self:loadAnimation("off",true)

	end
end

function GateInterruptorSolo:isAppliable(pos)
	 local ax =pos.x-self.position.x
	 local ay =pos.y-self.position.y
	if math.abs(math.sqrt(ax*ax+ay*ay))<=self.fieldRadius then
	return true
	else
		return false
	end
end



function GateInterruptorSolo:getPosition()
	return self.position
end
function GateInterruptorSolo:handleTry(tryer)

	if self.timer ==0 then
		self.timer=GateInterruptorSoloTimer 
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


function GateInterruptorSolo:preSolve(b,coll)
end



function GateInterruptorSolo:collideWith( object, collision )
	if object.type=='MetalManSolo' then
		self.canBeEnableMM =self.canBeEnableMM+1
	end
	if object.type =='TheMagnetSolo' then
		self.canBeEnableTM =self.canBeEnableTM+1
	end
end

function GateInterruptorSolo:unCollideWith( object, collision )
	if object.type=='MetalManSolo' then
		self.canBeEnableMM =self.canBeEnableMM-1
	end
	if object.type =='TheMagnetSolo' then
		self.canBeEnableTM =self.canBeEnableTM-1
	end
end

function GateInterruptorSolo:addStatMetal(metal)
  for _, value in pairs(self.statMetals) do
    if value == metal then
      return 
    end
  end
  metal:initStaticField()
	table.insert(self.statMetals,metal)
end


function GateInterruptorSolo:changeState( newState )
	self.on=newState
end


function GateInterruptorSolo:getPosition(  )
	return self.position
end

function GateInterruptorSolo:update(seconds)
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



function GateInterruptorSolo:loadAnimation(anim, force)
		self.anim:load(anim, force)
end

function GateInterruptorSolo:draw(x,y)
    	love.graphics.drawq(self.anim:getSprite(), self.quad,self.position.x-x, self.position.y+y)

end

function GateInterruptorSolo:send(x,y)
    return ("@gateinterruptorSolo".."#"..self.netid.."#"..self.anim:getImgInfo()[1].."#"..self.anim:getImgInfo()[2].."#"..math.floor(self.position.x-x).."#"..math.floor(self.position.y+y))
end
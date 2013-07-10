--[[ 
This file is part of the Field project]]


require("game.animinter")
ArcInterruptor = {}
ArcInterruptor.__index = ArcInterruptor

ArcInterruptorTimer =0.5
function ArcInterruptor.new(pos,type,arcID,mapLoader,enabled,netid)
	local self = {}
	setmetatable(self, ArcInterruptor)

	self.netid=netid
	self.position={x=pos.x,y=pos.y}
	local decalage={unitWorldSize/2,unitWorldSize/2}
	self.pc = Physics.newInterruptor(self.position.x,self.position.y,unitWorldSize,unitWorldSize,type,decalage)
	self.typeG=type
	self.anim = AnimInter.new('switch/arc')
	self.pc.fixture:setUserData(self)
	self.type='ArcInterruptor'


	self.canBeEnableTM=0
	self.canBeEnableMM=0
	self.mapLoader=mapLoader
	self.arcID= tonumber(arcID)
	self.w=unitWorldSize
	self.h=unitWorldSize

	self.timer=0
	self.quad= love.graphics.newQuad(0, 0, unitWorldSize, unitWorldSize, unitWorldSize*2,unitWorldSize)

	if enabled == "true" then
		self.enabled = true
	else
		self.enabled = false
	end
	return self
end
function ArcInterruptor:init()
	if self.enabled then
		self.on=true
		self:loadAnimation("on",true)
	else
		self.on= false
		self:loadAnimation("off",true)

	end
end

function ArcInterruptor:isAppliable(pos)
	 local ax =pos.x-self.position.x
	 local ay =pos.y-self.position.y
	if math.abs(math.sqrt(ax*ax+ay*ay))<=self.fieldRadius then
	return true
	else
		return false
	end
end



function ArcInterruptor:getPosition()
	return self.position
end
function ArcInterruptor:handleTry(tryer)

	print("Tryer", tryer)
	if self.timer ==0 then
		self.timer=ArcInterruptorTimer 
		if tryer=='MetalMan' then
			if self.canBeEnableMM>0 then
				self.on= not self.on
				if self.on then
					print("activation de ", self.arcID)
					self.mapLoader:enableA(self.arcID)
					self:loadAnimation("launching",true)

				else
					print("activation de ", self.arcID)
					self.mapLoader:disableA(self.arcID)
					self:loadAnimation("shutdown",true)


				end
			end
		elseif tryer=='TheMagnet' then
			if self.canBeEnableTM>0 then
				self.on= not self.on
				if self.on then
					self.mapLoader:enableA(self.arcID)
					print("activation de ", self.arcID)
					self:loadAnimation("launching",true)

				else
					print("activation de ", self.arcID)
					self.mapLoader:disableA(self.arcID)
					self:loadAnimation("shutdown",true)
				end
			end
		end
	end
end


function ArcInterruptor:preSolve(b,coll)
end



function ArcInterruptor:collideWith( object, collision )
	if object.type=='MetalMan' then
		self.canBeEnableMM =self.canBeEnableMM+1
	end
	if object.type =='TheMagnet' then
		self.canBeEnableTM =self.canBeEnableTM+1
	end
end

function ArcInterruptor:unCollideWith( object, collision )
	if object.type=='MetalMan' then
		self.canBeEnableMM =self.canBeEnableMM-1
	end
	if object.type =='TheMagnet' then
		self.canBeEnableTM =self.canBeEnableTM-1
	end
end

function ArcInterruptor:addStatMetal(metal)
  for _, value in pairs(self.statMetals) do
    if value == metal then
      return 
    end
  end
  metal:initStaticField()
	table.insert(self.statMetals,metal)
end


function ArcInterruptor:changeState( newState )
	self.on=newState
end


function ArcInterruptor:getPosition(  )
	return self.position
end

function ArcInterruptor:update(seconds)
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

function ArcInterruptor:syncronizeState(newState)
	self.on = newState
	if newState then
		self:loadAnimation("launching",true)
	else
		self:loadAnimation("shutdown",true)
	end
end

function ArcInterruptor:loadAnimation(anim, force)
		self.anim:load(anim, force)
end

function ArcInterruptor:draw(x,y)
    	love.graphics.drawq(self.anim:getSprite(), self.quad,self.position.x-x, self.position.y+y)

end

function ArcInterruptor:send(x,y)
    return ("@Arcinterruptor".."#"..self.netid.."#"..self.anim:getImgInfo()[1].."#"..self.anim:getImgInfo()[2].."#"..math.floor(self.position.x-x).."#"..math.floor(self.position.y+y))
end

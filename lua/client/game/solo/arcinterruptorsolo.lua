--[[ 
This file is part of the Field project]]


require("game.animinter")
ArcInterruptorSolo = {}
ArcInterruptorSolo.__index = ArcInterruptorSolo

ArcInterruptorSoloTimer =0.5


ArcInterruptorSolo.TimeEvent = {Launching = 1, Shutdown = 0}
ArcInterruptorSolo.ActionType = {Shutdown = 0, Start = 1, Switch =2}


function ArcInterruptorSolo.new(pos,type,arcID,mapLoader,enabled,timers,netid)
	local self = {}
	setmetatable(self, ArcInterruptorSolo)

	self.netid=netid
	self.position={x=pos.x,y=pos.y}
	local decalage={unitWorldSize/2,unitWorldSize/2}
	self.pc = Physics.newInterruptor(self.position.x,self.position.y,unitWorldSize,unitWorldSize,type,decalage)
	self.typeG=type
	self.anim = AnimInterSolo.new('switch/arc')
	self.pc.fixture:setUserData(self)
	self.type='ArcInterruptorSolo'


	self.canBeEnableTM=0
	self.canBeEnableMM=0
	self.mapLoader=mapLoader
	self.arcID= tonumber(arcID)
	self.w=unitWorldSize
	self.h=unitWorldSize

	self.timer=0

	if enabled =="true" then
		self.enabled = true
	else
		self.enabled = false
	end
	self.quad= love.graphics.newQuad(0, 0, unitWorldSize, unitWorldSize, unitWorldSize*2,unitWorldSize)

	self.timers = {}
	self:parseTimers(timers)

	return self
end


function ArcInterruptorSolo:getArgs(string)
	local ret ={}
	for i in string.gmatch(string, "([^@]+)") do
		table.insert(ret, tonumber(i))
	end
	return ret
end

function ArcInterruptorSolo:executeActions(actionType)
	-- print("EXECUTION DES ACTIONS")
	for i,v in pairs(self.timers) do
		-- print("TIMER",v[1],v[2],v[3])
		if v[3] == actionType then
			if v[2] == EventTimer.Actions.Shutdown then
				self.mapLoader:disableT(v[1])
			elseif v[2] == EventTimer.Actions.Start then
				self.mapLoader:enableT(v[1])
			elseif v[2] == EventTimer.Actions.Switch then
				self.mapLoader:switchT(v[1])
			end
		end
	end
end


function ArcInterruptorSolo:parseTimers(parTimer)
	if parTimer ~= nil then
		print("Il y a des timers")
		for k in string.gmatch(parTimer, "([^#]+)") do
			local timer = self:getArgs(k)
			assert(#timer == 3)
			table.insert(self.timers,timer)
			print(timer[1],timer[2],timer[3])
		end
	end
end



function ArcInterruptorSolo:init()
	if self.enabled then
		self.on=true
		self:loadAnimation("on",true)
	else
		self.on= false
		self:loadAnimation("off",true)

	end
end

function ArcInterruptorSolo:isAppliable(pos)
	 local ax =pos.x-self.position.x
	 local ay =pos.y-self.position.y
	if math.abs(math.sqrt(ax*ax+ay*ay))<=self.fieldRadius then
	return true
	else
		return false
	end
end

function ArcInterruptorSolo:syncronizeState(newState)
	if (self.on ~= newState) then
		self.on = newState
		if newState then
			self:loadAnimation("launching",true)
		else
			self:loadAnimation("shutdown",true)
		end
	end
end


function ArcInterruptorSolo:getPosition()
	return self.position
end
function ArcInterruptorSolo:handleTry(tryer)
	if self.timer ==0 then
		self.timer=ArcInterruptorSoloTimer 
		if tryer=='MetalMan' then
			if self.canBeEnableMM>0 then
				self.on= not self.on
				if self.on then
					self.mapLoader:enableA(self.arcID)
					self:loadAnimation("launching",true)
					self:executeActions(Interruptor.TimeEvent.Launching)

				else
					self.mapLoader:disableA(self.arcID)
					self:loadAnimation("shutdown",true)
					self:executeActions(Interruptor.TimeEvent.Shutdown)
				end
			end
		elseif tryer=='TheMagnet' then
			if self.canBeEnableTM>0 then
				self.on= not self.on
				if self.on then
					self.mapLoader:enableA(self.arcID)
					self:loadAnimation("launching",true)
					self:executeActions(Interruptor.TimeEvent.Launching)
				else
					self.mapLoader:disableA(self.arcID)
					self:loadAnimation("shutdown",true)
					self:executeActions(Interruptor.TimeEvent.Shutdown)
				end
			end
		end
	end
end


function ArcInterruptorSolo:preSolve(b,coll)
end



function ArcInterruptorSolo:collideWith( object, collision )
	if object.type=='MetalManSolo' then
		self.canBeEnableMM =self.canBeEnableMM+1
	end
	if object.type =='TheMagnetSolo' then
		self.canBeEnableTM =self.canBeEnableTM+1
	end
end

function ArcInterruptorSolo:unCollideWith( object, collision )
	if object.type=='MetalManSolo' then
		self.canBeEnableMM =self.canBeEnableMM-1
	end
	if object.type =='TheMagnetSolo' then
		self.canBeEnableTM =self.canBeEnableTM-1
	end
end

function ArcInterruptorSolo:addStatMetal(metal)
  for _, value in pairs(self.statMetals) do
    if value == metal then
      return 
    end
  end
  metal:initStaticField()
	table.insert(self.statMetals,metal)
end


function ArcInterruptorSolo:changeState( newState )
	self.on=newState
end


function ArcInterruptorSolo:getPosition(  )
	return self.position
end

function ArcInterruptorSolo:update(seconds)
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



function ArcInterruptorSolo:loadAnimation(anim, force)
		self.anim:load(anim, force)
end

function ArcInterruptorSolo:draw(x,y)
    	love.graphics.drawq(self.anim:getSprite(), self.quad,self.position.x-x, self.position.y+y)

end

function ArcInterruptorSolo:send(x,y)
    return ("@ArcinterruptorSolo".."#"..self.netid.."#"..self.anim:getImgInfo()[1].."#"..self.anim:getImgInfo()[2].."#"..math.floor(self.position.x-x).."#"..math.floor(self.position.y+y))
end
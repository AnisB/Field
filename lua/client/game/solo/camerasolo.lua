--[[ 
This file is part of the Field project
]]

require("const")
CameraSolo = {}
CameraSolo.__index =  CameraSolo

function CameraSolo.new(ax,ay)
    local self = {}
    setmetatable(self, CameraSolo)
    self.position= {x=ax,y=ay}
    self.timer=0
    self.shake={x={},y={}}
    return self
end


function CameraSolo:update(dt)
	self.timer=self.timer+dt


	if self.shake.x.enable then
		if self.shake.x.past>= self.shake.x.duration then
			self.shake.x.enable=false
			return
		end
		self.shake.x.past=self.shake.x.past+dt	
	end
	if self.shake.y.enable then
		if self.shake.y.past>= self.shake.y.duration then
			self.shake.y.enable=false
			return
		end
		self.shake.y.past=self.shake.y.past+dt	
	end
end
function CameraSolo:newPosition(ax,ay)
    -- self.position.x= ax
    if self.shake.x.enable then
		self.position.x= ax+self.shake.x.dx*math.cos(self.shake.x.past*self.shake.x.speed)
	else
		-- print(self.position.x,self.position.y)
		self.position.x= ax
	end
    if self.shake.y.enable then
		self.position.y= ay+self.shake.y.dy*math.cos(self.shake.y.past*self.shake.y.speed)
	else
		-- print("Copy me dude"..ay)
		self.position.y= ay
	end	
end

function CameraSolo:getPos()
	return self.position
end


function CameraSolo:draw()
end

function CameraSolo:shakeOnX(dx,speed,duration)
	self.shake.x.dx=dx
	self.shake.x.speed=speed
	self.shake.x.duration=duration
	self.shake.x.past=0
	self.shake.x.enable=true
end

function CameraSolo:shakeOnY(dy,speed,duration)
	self.shake.y.dy=dy
	self.shake.y.speed=speed
	self.shake.y.duration=duration
	self.shake.y.past=0
	self.shake.y.enable=true

end


function CameraSolo:toSend()
	return "@cameraSolo".."#"..self.position.x.."#"..self.position.y
end
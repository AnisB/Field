--[[ 
This file is part of the Field project
]]


SwitchStateTimer = {}
SwitchStateTimer.__index =  SwitchStateTimer

function SwitchStateTimer.new(cible,duration,isLoop)
    local self = {}
    setmetatable(self, SwitchStateTimer)
    self.cible=cible
    self.duration=duration
    self.timer=0
    self.isLooping=isLoop
    return self
end




function SwitchStateTimer:update(dt)
	if self.isActive then
		self.timer = self.timer+dt
	end
end

function SwitchStateTimer:evalCondition()
	if self.timer>=self.duration then
		return true
	else
		return false
	end
end



function SwitchStateTimer:doAction()
	self.cible:switchState()
	if self.isLooping then
		self.timer=0
	else
		self.isActive=false
	end
end

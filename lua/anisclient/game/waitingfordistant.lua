--[[ 
This file is part of the Field project]]


WaitingForDistant = {}
WaitingForDistant.__index = WaitingForDistant

function WaitingForDistant:new()
    local self = {}
    setmetatable(self, WaitingForDistant)
    self.timer=1
    return self
end


function WaitingForDistant:mousePressed(x, y, button)
end

function WaitingForDistant:mouseReleased(x, y, button)
end


function WaitingForDistant:keyPressed(key, unicode)
end

function WaitingForDistant:keyReleased(key, unicode)
end


function WaitingForDistant:update(dt)
	self.timer= self.timer-dt
	if self.timer<=0 then
		gameStateManager:changeState('Prelude')
	end
	
end

function WaitingForDistant:draw()

end


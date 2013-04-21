--[[ 
This file is part of the Field project]]


LevelBeginSolo = {}
LevelBeginSolo.__index = LevelBeginSolo
function LevelBeginSolo:new()
    local self = {}
    setmetatable(self, LevelBeginSolo)
    self.timer=1
    return self
end


function LevelBeginSolo:mousePressed(x, y, button)
end

function LevelBeginSolo:mouseReleased(x, y, button)
end


function LevelBeginSolo:keyPressed(key, unicode)
end

function LevelBeginSolo:keyReleased(key, unicode)
end


function LevelBeginSolo:update(dt)
	self.timer= self.timer-dt
	if self.timer<=0 then
		gameStateManager:changeState('Gameplay')
	end
	
end

function LevelBeginSolo:draw()

end


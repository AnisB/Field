--[[ 
This file is part of the Field project]]


LevelBegin = {}
LevelBegin.__index = LevelBegin
function LevelBegin:new()
    local self = {}
    setmetatable(self, LevelBegin)
    self.timer=1
    return self
end


function LevelBegin:mousePressed(x, y, button)
end

function LevelBegin:mouseReleased(x, y, button)
end


function LevelBegin:keyPressed(key, unicode)
end

function LevelBegin:keyReleased(key, unicode)
end


function LevelBegin:update(dt)
	self.timer= self.timer-dt
	if self.timer<=0 then
		gameState:changeState('Gameplay')
	end
	
end

function LevelBegin:draw()

end


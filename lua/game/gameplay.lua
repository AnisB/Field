--[[ 
This file is part of the Field project]]


Gameplay = {}
Gameplay.__index = Gameplay
function Gameplay:new()
    local self = {}
    setmetatable(self, Gameplay)
    self.timer=1
    return self
end


function Gameplay:mousePressed(x, y, button)
end

function Gameplay:mouseReleased(x, y, button)
end


function Gameplay:keyPressed(key, unicode)
end

function Gameplay:keyReleased(key, unicode)
end


function Gameplay:update(dt)
	self.timer= self.timer-dt
	if self.timer<=0 then
		gameState:changeState('Prelude')
	end
	
end

function Gameplay:draw()

end


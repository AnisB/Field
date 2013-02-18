--[[ 
This file is part of the Field]]


Storyline = {}
Storyline.__index = Storyline
function Storyline:new()
    local self = {}
    setmetatable(self, Storyline)
    self.timer=1	
    return self
end


function Storyline:mousePressed(x, y, button)
end

function Storyline:mouseReleased(x, y, button)
end


function Storyline:keyPressed(key, unicode)
end

function Storyline:keyReleased(key, unicode)
end


function Storyline:update(dt)
	self.timer= self.timer-dt
	if self.timer<=0 then
		gameState:changeState('FirstEnter')
	end
	
end

function Storyline:draw()


end


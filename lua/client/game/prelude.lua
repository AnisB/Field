--[[ 
This file is part of the Field]]


Prelude = {}
Prelude.__index = Prelude
function Prelude:new()
    local self = {}
    setmetatable(self, Prelude)
    self.timer=1
    return self
end


function Prelude:mousePressed(x, y, button)
end

function Prelude:mouseReleased(x, y, button)
end


function Prelude:keyPressed(key, unicode)
end

function Prelude:keyReleased(key, unicode)
end

function Prelude:joystickPressed(joystick, button)
end

function Prelude:joystickReleased(joystick, button)
end

function Prelude:update(dt)
	self.timer= self.timer-dt
	if self.timer<=0 then
		gameStateManager:changeState('Storyline')
	end
end

function Prelude:draw()

end


--[[ 
This file is part of the Field]]


GraphicChecks = {}
GraphicChecks.__index = GraphicChecks
function GraphicChecks.new()
    local self = {}
    setmetatable(self, GraphicChecks)
    self.timer=10
    if not love.graphics.isSupported("pixeleffect","canvas") then
    	self.isSupported=false
    	return self
    end
    self.isSupported=true
    return self
end


function GraphicChecks:mousePressed(x, y, button)
end

function GraphicChecks:mouseReleased(x, y, button)
end


function GraphicChecks:keyPressed(key, unicode)
	if key="return" then
		gameStateManager:changeState('FirstEnter')
	end
end

function GraphicChecks:keyReleased(key, unicode)
end

function GraphicChecks:joystickPressed(joystick, button)
end

function GraphicChecks:joystickReleased(joystick, button)
end

function GraphicChecks:update(dt)
	self.timer= self.timer-dt
	if self.timer<=0 then
		gameStateManager:changeState('FirstEnter')
	end
end

function GraphicChecks:draw()
	if self.isSupported then
		gameStateManager:changeState('FirstEnter')
	else
		love.graphics.printf("Your computer doesn't support some graphic effects present in game, they have been automatically disabled.", 100, 75,1000)
	end
end


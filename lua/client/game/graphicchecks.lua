--[[ 
This file is part of the Field]]


GraphicChecks = {}
GraphicChecks.__index = GraphicChecks
function GraphicChecks.new()
    local self = {}
    setmetatable(self, GraphicChecks)
    self.timer=7
    self.font = love.graphics.newFont(FontDirectory .. "font.ttf", 25)
    love.graphics.setFont(self.font)
    if not love.graphics.newPixelEffect
     or not love.graphics.isSupported
     or not love.graphics.isSupported("pixeleffect")
     or not love.graphics.isSupported("canvas") then
     self.isSupported=false
     return self
   end
   self.isSupported=true
    return self
end


function GraphicChecks:reset()
	self.font = love.graphics.newFont(FontDirectory .. "font.ttf", 22)
	love.graphics.setFont(self.font)
end


function GraphicChecks:mousePressed(x, y, button)
end

function GraphicChecks:mouseReleased(x, y, button)
end


function GraphicChecks:keyPressed(key, unicode)
	if key=="return" then
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
		-- gameStateManager:changeState('FirstEnter')
	-- else
	love.graphics.printf("Your computer does unfortunatly not support some graphic effects present in game.", 0, 175,1280,"center")
	love.graphics.printf("They have been automatically disabled.", 0, 375,1280,"center")
	end
end


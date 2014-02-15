--[[ 
This file is part of the Field]]

require("resource.resourcemanager")
GraphicChecks = {}
GraphicChecks.__index = GraphicChecks
function GraphicChecks.new()
    local self = {}
    setmetatable(self, GraphicChecks)
    self.font = s_resourceManager:LoadFont(FontDirectory .. "font.ttf", 25)
    love.graphics.setFont(self.font)
    self.isSupported=love.graphics.isSupported("canvas","shader", "npot")
    return self
end


function GraphicChecks:reset()
	love.graphics.setFont(self.font)
end

function GraphicChecks:keyPressed(key, unicode)

end

function GraphicChecks:keyReleased(key, unicode)
end


function GraphicChecks:update(dt)
	if self.isSupported then
		s_gameStateManager:changeState('FirstEnter')
	end
end

function GraphicChecks:draw()
	if  not self.isSupported then
		love.graphics.printf("Your computer does unfortunatly not support some graphic effects present in game.", 0, 175,1280,"center")
		love.graphics.printf("Sorry, you cannot run Field for the moment", 0, 375,1280,"center")
	end
end


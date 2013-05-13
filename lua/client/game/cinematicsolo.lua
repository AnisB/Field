--[[ 
	This file is part of the Field project
]]


CinematicSolo = {}
CinematicSolo.__index =  CinematicSolo

function CinematicSolo:new(scenarioFile)
    local self = {}
    setmetatable(self, CinematicSolo)
    
    return self
end


function CinematicSolo:addCard()

end

function CinematicSolo:update(dt)
end


function CinematicSolo:draw()
		love.graphics.draw(toDraw, self.posx, self.posy)
end
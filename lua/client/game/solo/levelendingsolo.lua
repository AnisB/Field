--[[ 
This file is part of the Field project]]


LevelEndingSolo = {}
LevelEndingSolo.__index = LevelEndingSolo
function LevelEndingSolo.new(next,continuous)
    local self = {}
    setmetatable(self, LevelEndingSolo)
    self.next=next
    self.continuous=continuous
    print(self.continuous)
    return self
end


function LevelEndingSolo:mousePressed(x, y, button)
end

function LevelEndingSolo:mouseReleased(x, y, button)
end


function LevelEndingSolo:keyPressed(key, unicode)
	if key=="return" then
		if self.continuous then
			gameStateManager.state['Gameplay']:destroy()
            gameStateManager.state['Gameplay']=Gameplay.new("maps/"..self.next,true)
            print(self.next)
            gameStateManager:changeState('Gameplay')		
        -- else
        --     gameStateManager:changeState('choixTypeJeu')
        end		
	end
end

function LevelEndingSolo:keyReleased(key, unicode)
end


function LevelEndingSolo:update(dt)
	
end

function LevelEndingSolo:draw()
	if self.continuous then
		love.graphics.print("On est à la fin du niveau, appuitey sur entrée pour le niveau suivant", 200, 200)
	else
		love.graphics.print("On est à la fin du niveau, appuitey sur entrée pour revenir au menu", 200, 200)
	end
end


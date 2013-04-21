--[[ 
This file is part of the Field project]]


LevelFailedSolo = {}
LevelFailedSolo.__index = LevelFailedSolo
function LevelFailedSolo.new()
	local self = {}
	setmetatable(self, LevelFailedSolo)
	self.next=next
	self.continuous=continuous
	print(self.continuous)
	return self
end


function LevelFailedSolo:mousePressed(x, y, button)
end

function LevelFailedSolo:mouseReleased(x, y, button)
end


function LevelFailedSolo:keyPressed(key, unicode)
	if key=="return" then
	   gameStateManager.state['GameplaySolo']:reset()
	   gameStateManager:changeState('GameplaySolo')		
   -- else
   --     gameStateManager.state['Gameplay']:destroy()        
   --     gameStateManager:changeState('choixTypeJeu')     
   end            
end

function LevelFailedSolo:keyReleased(key, unicode)
end


function LevelFailedSolo:update(dt)
end

function LevelFailedSolo:draw()
	if self.continuous then
		love.graphics.print("On est à la fin du niveau, appuitey sur entrée pour le niveau suivant", 200, 200)
	else
		love.graphics.print("On est à la fin du niveau, appuitey sur entrée pour revenir au menu", 200, 200)
	end
end


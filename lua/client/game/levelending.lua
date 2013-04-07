--[[ 
This file is part of the Field project]]


LevelEnding = {}
LevelEnding.__index = LevelEnding
function LevelEnding.new(next,continuous)
    local self = {}
    setmetatable(self, LevelEnding)
    self.next=next
    self.continuous=continuous
    print(self.continuous)
    return self
end


function LevelEnding:mousePressed(x, y, button)
end

function LevelEnding:mouseReleased(x, y, button)
end


function LevelEnding:keyPressed(akey, unicode)
    print("levelending",monde.moi.perso, akey)
    serveur:send({type="input", pck={character=monde.moi.perso, key=akey, state=true}})    
	if unicode==13 then
        gameStateManager.state['Gameplay']=Gameplay.new("maps."..self.next,true)
        gameStateManager:changeState('Gameplay')		
    else
        gameStateManager:changeState('choixTypeJeu')
    end		
end

function LevelEnding:keyReleased(key, unicode)
end


function LevelEnding:update(dt)
	
end

function LevelEnding:draw()
	if self.continuous then
		love.graphics.print("On est à la fin du niveau, appuitey sur entrée pour le niveau suivant", 200, 200)
	else
		love.graphics.print("On est à la fin du niveau, appuitey sur entrée pour revenir au menu", 200, 200)
	end
end


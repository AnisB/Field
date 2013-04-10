--[[ 
This file is part of the Field project]]


    LevelFailed = {}
    LevelFailed.__index = LevelFailed
    function LevelFailed.new()
        local self = {}
        setmetatable(self, LevelFailed)
        self.next=next
        self.continuous=continuous
        print(self.continuous)
        return self
    end


    function LevelFailed:mousePressed(x, y, button)
    end

    function LevelFailed:mouseReleased(x, y, button)
    end


    function LevelFailed:keyPressed(akey, unicode)
      print("levelending",monde.moi.perso, akey)
      serveur:send({type="input", pck={character=monde.moi.perso, key=akey, state=true}})            
        if unicode==13 then
           gameStateManager.state['Gameplay']:reset()
           gameStateManager:changeState('Gameplay')		
       else
           -- gameStateManager.state['Gameplay']:destroy()        
           -- gameStateManager:changeState('choixTypeJeu')     
       end            
end

function LevelFailed:keyReleased(key, unicode)
end


function LevelFailed:update(dt)
	
end

function LevelFailed:draw()
	if self.continuous then
		love.graphics.print("On est à la fin du niveau,\n appuiyez sur entrée pour le niveau suivant", 200, 200)
	else
		love.graphics.print("On est à la fin du niveau,\n appuiyez sur entrée pour revenir au menu", 200, 200)
	end
end

function LevelFailed:onMessage(x, y, button)
end


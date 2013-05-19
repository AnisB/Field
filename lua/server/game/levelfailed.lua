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


function LevelFailed:onMessage(msg,client)

    if msg.type=="syncro" then
        if msg.pck.current~="LevelFailed" then
            -- Soucis de syncro des etats, on kick les 2 joueurs et on reset le serveur
            return
        end

        if msg.pck.next=="Gameplay" then
        	gameStateManager.state['Gameplay']:reset()
            gameStateManager:changeState('Gameplay')
            for k,c in pairs(clients) do    
                local packet={}
                if c.perso==msg.pck.perso then
                    -- Nothgin to do, the peer is already sycronised with himself
                else
                    c:send({type= "syncro", pck={next="Gameplay"}})
                end
            end
        elseif msg.pck.next=="ChoixNiveau" then
        	print("Retour donc")
            for k,c in pairs(clients) do    
                local packet={}
                if c.perso==msg.pck.perso then
                    -- Nothgin to do, the peer is already sycronised with himself
                else
                    c:send({type= "syncro", pck={next="ChoixNiveau"}})
                end
            end
            gameStateManager:changeState('arcadeChoixNiveau')  
        end
    end
end

function LevelFailed:keyPressed(key, unicode)
end

function LevelFailed:keyReleased(key, unicode)
end


function LevelFailed:update(dt)
end

function LevelFailed:draw()
	if self.continuous then
		love.graphics.print("On est à la fin du niveau, appuitey sur entrée pour le niveau suivant", 200, 200)
	else
		love.graphics.print("On est à la fin du niveau, appuitey sur entrée pour revenir au menu", 200, 200)
	end
end


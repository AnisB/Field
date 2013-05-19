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


function LevelEnding:onMessage(msg,client)

    if msg.type=="syncro" then
        if msg.pck.current~="LevelEnding" then
            -- Soucis de syncro des etats, on kick les 2 joueurs et on reset le serveur
            return
        end

        if msg.pck.next=="Gameplay" then
            gameStateManager.state['Gameplay']:destroy()
            gameStateManager.state['Gameplay']=Gameplay.new("maps/"..self.next,true)
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

function LevelEnding:keyPressed(key, unicode)
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


ArcadeChoixPerso = {}

function ArcadeChoixPerso:init()
end

function ArcadeChoixPerso:update(dt) end
function ArcadeChoixPerso:draw() end
function ArcadeChoixPerso:keyReleased(key, unicode) end

function ArcadeChoixPerso:onMessage(msg, client)

	if msg.type=="choice" then

        if msg.pck.current~="ChoixPerso" then
            -- Soucis de syncro des etats, on kick les 2 joueurs et on reset le serveur
            return
        end

        client.perso = msg.perso
            for k,c in pairs(clients) do
                c:send({type= "choice", player= client.cookie, perso= client.perso})
            end
        if msg.pck.next=="Gameplay" then
        	monde.level = msg.level
        	if gameStateManager.state['Gameplay']~=nil then
        		gameStateManager.state['Gameplay']:destroy()
        	end
            gameStateManager.state['Gameplay']=Gameplay.new("maps/"..msg.pck.level,true)
            gameStateManager:changeState('Gameplay')
            for k,c in pairs(clients) do    
                local packet={}
                if c.perso==msg.pck.perso then
                    -- Nothgin to do, the peer is already sycronised with himself
                else
                	c:send({type= "choixNiveau", pck={next="Gameplay",level= msg.pck.level}})
                end
            end
        elseif msg.pck.next=="ChoixPerso" then
            for k,c in pairs(clients) do    
                local packet={}
                if c.perso==msg.pck.perso then
                    -- Nothgin to do, the peer is already sycronised with himself
                else
                    c:send({type= "syncro", pck={next="ChoixNiveau"}})
                end
            end
            gameStateManager:changeState('arcadeChoixpPerso')  
        end
    elseif msg.type=="confirmation" then
    	if msg.pck.current~="ChoixNiveau" then
            -- Soucis de syncro des etats, on kick les 2 joueurs et on reset le serveur
            return
        end
        print("On va envoyer")        
        for k,c in pairs(clients) do    
        	local packet={}
        	if c.perso==msg.pck.perso then
                -- Nothgin to do, the peer is already sycronised with himself
            else
            	c:send({type= "syncroLevel", pck={current="ChoixNiveau", level = msg.pck.level}})
            end
        end
    end



	if msg.type == "choixPerso" then
		if not msg.confirm then
			client.perso = msg.perso or debug_warn("[ArcadeChoixPerso] missing perso")
			for k,c in pairs(clients) do
				c:send({type= "choixPerso", player= client.cookie, perso= client.perso})
			end
		else
			if monde.player1.perso and monde.player2.perso and
			   monde.player1.perso ~= monde.player2.perso then
				for k,c in pairs(clients) do
					c:send({type= "choixPersoFini"})
				end
				monde[monde.player1.perso] = monde.player1
				monde[monde.player2.perso] = monde.player2
				gameStateManager:changeState("arcadeChoixNiveau")
				print("Perso j'suis passé au choix des niveaux")
				-- TODO : envoyer la liste des niveau possibles ?
			else
				client:send({type= "err", content="Erreur dans le choix des personnages", msg="choix des personnages pas fini"})
			end
		end
	else
		debug_warn("[ArcadeChoixPerso] wrong type")
	end
end

ArcadeChoixPerso = common.class("ArcadeChoixPerso", ArcadeChoixPerso)
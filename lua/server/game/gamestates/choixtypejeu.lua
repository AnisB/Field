ChoixTypeJeu = {}

function ChoixTypeJeu:init()
end

function ChoixTypeJeu:update(dt) end
function ChoixTypeJeu:draw() end
function ChoixTypeJeu:keyReleased(key, unicode) end

function ChoixTypeJeu:onMessage(msg, client)
	
	if msg.type=="syncro" then

        if msg.pck.current~="ChoixTypeJeu" then
            -- Soucis de syncro des etats, on kick les 2 joueurs et on reset le serveur
            return
        end

        if msg.pck.next=="ChoixPerso" then
        	if msg.pck.typeJeu == "arcade" then
        		monde.typeJeu = "arcade"
        		gameStateManager:changeState("arcadeChoixPerso")
        		print "Going arcade"
		    elseif msg.pck.typeJeu == "histoire" then
        		monde.typeJeu = "histoire"
        		print "Going histoire"
        		gameStateManager:changeState("histoireChoixPerso")
        	else 
        		assert(false)
        	end
            for k,c in pairs(clients) do    
                local packet
            	print(c.cookie, msg.sender)
            	if c.cookie==msg.sender then
                    -- Nothgin to do, the peer is already sycronised with himself
                else
                	c:send({type= "syncro", pck={next="ChoixPerso",typeJeu= msg.pck.typeJeu}})
                end
            end

        elseif msg.pck.next=="ConnectToServer" then
            for k,c in pairs(clients) do    
            	print(c.cookie, msg.sender)
                local packet={}
                if c.cookie==msg.sender then
                    -- Nothgin to do, the peer is already sycronised with himself
                else
                    c:send({type= "syncro", pck={next="ConnectToServer"}})
                end
                gameStateManager:changeState("attente")

            end
        end
    else
    	print(msg.type)
	    -- On kick les deux joueurs et on reset
	    assert(false)
    end



	-- if msg.type == "choixTypeJeu" then
	-- 	local cp = nil -- choix précédents de personnages (history)
	-- 	if msg.typeJeu == "arcade" then
	-- 		monde.typeJeu = "arcade"
	-- 		gameStateManager:changeState("arcadeChoixPerso")
	-- 	elseif msg.typeJeu == "histoire" then
	-- 		monde.typeJeu = "histoire"
	-- 		if monde.player1.history ~= {} then  -- pas la peine de checker player2
	-- 			gameStateManager:changeState("histoireChoixPerso")
	-- 		else
	-- 			monde.player1.perso = monde.player1.history.perso
	-- 			monde.player2.perso = monde.player2.history.perso
	-- 			monde[monde.player1.perso] = monde.player1
	-- 			monde[monde.player2.perso] = monde.player2
	-- 			cp = {}
	-- 			cp[monde.player1.cookie] = monde.player1.perso
	-- 			cp[monde.player2.cookie] = monde.player2.perso
	-- 			gameStateManager:changeState("histoire")
	-- 		end
	-- 	else
	-- 		debug_warn("[ChoixTypeJeu] wrong typeJeu")
	-- 		return nil
	-- 	end
	-- 	for k,c in pairs(clients) do
	-- 		c:send({type= "choixTypeJeuFini", typeJeu= msg.typeJeu, persos= cp})
	-- 	end
	-- else
	-- 	debug_warn("[ChoixTypeJeu] wrong type")
	-- end
end

ChoixTypeJeu = common.class("ChoixTypeJeu", ChoixTypeJeu)
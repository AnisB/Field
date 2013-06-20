ArcadeChoixNiveau = {}

function ArcadeChoixNiveau:init()
end

function ArcadeChoixNiveau:update(dt) end
function ArcadeChoixNiveau:draw() end

function ArcadeChoixNiveau:onMessage(msg, client)
	if msg.type=="syncro" then

        if msg.pck.current~="ChoixNiveau" then
            -- Soucis de syncro des etats, on kick les 2 joueurs et on reset le serveur
            return
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
    elseif msg.type == "syncroLevel" then
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


	-- if msg.type == "choixNiveau" then
	-- 	if not msg.confirm then
	-- 		-- TODO : checker que le niveau existe bien, toussa
	-- 		monde.niveau = msg.niveau or debug_warn("[ArcadeChoixNiveau] missing niveau")
	-- 		for k,c in pairs(clients) do
	-- 			c:send({type= "choixNiveau", niveau= msg.niveau})
	-- 		end
	-- 	else
	-- 		if monde.niveau then
	-- 			for k,c in pairs(clients) do
	-- 				c:send({type= "choixNiveauFini"})
	-- 			end
	-- 			gameStateManager:changeState("arcade")
	-- 			-- TODO : envoyer le niveau ici ?
	-- 		else
	-- 			client:send({type= "err", msg="choix du niveau pas fini"})
	-- 		end
	-- 	end
	-- else
	-- 	debug_warn("[ArcadeChoixNiveau] wrong type")
	-- end
end

ArcadeChoixNiveau = common.class("ArcadeChoixNiveau", ArcadeChoixNiveau)
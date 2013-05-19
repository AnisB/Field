ArcadeChoixPerso = {}

function ArcadeChoixPerso:init()
end

function ArcadeChoixPerso:update(dt) end
function ArcadeChoixPerso:draw() end
function ArcadeChoixPerso:keyReleased(key, unicode) end

function ArcadeChoixPerso:onMessage(msg, client)
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
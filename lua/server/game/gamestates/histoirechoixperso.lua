HistoireChoixPerso = {}

function HistoireChoixPerso:init()
end

function HistoireChoixPerso:update(dt)
end

function HistoireChoixPerso:onMessage(msg, client)
	if msg.type == "choixPerso" then
		if not msg.confirm then
			client.perso = msg.perso or debug_warn("[HistoireChoixPerso] missing perso")
			for k,c in pairs(clients) do
				c:send({type= "choixPerso", player= client.cookie, perso= client.perso})
			end
		else
			if monde.player1.perso and monde.player2.perso and
			   monde.player1.perso ~= monde.player2.perso then
				monde[monde.player1.perso] = monde.player1
				monde[monde.player2.perso] = monde.player2
				gameStateManager:changeState("histoire")
				for k,c in pairs(clients) do
					c:send({type= "choixPersoFini"})
				end
			else
				client:send({type= "err", msg="choix des personnages pas fini"})
			end
		end
	else
		debug_warn("[HistoireChoixPerso] wrong type")
	end
end

HistoireChoixPerso = common.class("HistoireChoixPerso", HistoireChoixPerso)
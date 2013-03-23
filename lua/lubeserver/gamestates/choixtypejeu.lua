ChoixTypeJeu = {}

function ChoixTypeJeu:init()
	local i = 0
	for k,c in pairs(clients) do
		if i == 0 then
			self.player1 = c
			c.numero = 1
		elseif i == 1 then
			self.player2 = c
			c.numero = 2
		end
		i = i + 1
	end
end

function ChoixTypeJeu:update(dt)
end

function ChoixTypeJeu:onMessage(msg, client)
	if msg.type == "choixTypeJeu" then
		if msg.typeJeu == "arcade" then
			gameStateManager:changeState("arcadeChoixPerso")
		elseif msg.typeJeu == "histoire" then
			gameStateManager:changeState("histoireChoixPerso")
		else
			debug_warn("[ChoixTypeJeu] wrong typeJeu")
			return nil
		end
		for k,c in pairs(clients) do
			c:send({type= "choixTypeJeuFini", typeJeu= msg.typeJeu})
		end
	else
		debug_warn("[ChoixTypeJeu] wrong type")
	end
end

ChoixTypeJeu = common.class("ChoixTypeJeu", ChoixTypeJeu)
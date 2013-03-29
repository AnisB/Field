ChoixTypeJeu = {}

function ChoixTypeJeu:init()
end

function ChoixTypeJeu:update(dt)
end

function ChoixTypeJeu:onMessage(msg, client)
	if msg.type == "choixTypeJeu" then
		local cp = nil
		if msg.typeJeu == "arcade" then
			monde.typeJeu = "arcade"
			gameStateManager:changeState("arcadeChoixPerso")
		elseif msg.typeJeu == "histoire" then
			monde.typeJeu = "histoire"
			if monde.player1.history ~= {} then  -- pas la peine de checker player2
				gameStateManager:changeState("histoireChoixPerso")
			else
				monde.player1.perso = monde.player1.history.perso
				monde.player2.perso = monde.player2.history.perso
				monde[monde.player1.perso] = monde.player1
				monde[monde.player2.perso] = monde.player2
				cp = {}
				cp[monde.player1.cookie] = monde.player1.perso
				cp[monde.player2.cookie] = monde.player2.perso
				gameStateManager:changeState("histoire")
			end
		else
			debug_warn("[ChoixTypeJeu] wrong typeJeu")
			return nil
		end
		for k,c in pairs(clients) do
			c:send({type= "choixTypeJeuFini", typeJeu= msg.typeJeu, persos= cp})
		end
	else
		debug_warn("[ChoixTypeJeu] wrong type")
	end
end

ChoixTypeJeu = common.class("ChoixTypeJeu", ChoixTypeJeu)
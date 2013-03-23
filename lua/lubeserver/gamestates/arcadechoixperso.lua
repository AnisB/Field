ArcadeChoixPerso = {}

function ArcadeChoixPerso:init()
end

function ArcadeChoixPerso:update(dt)
end

function ArcadeChoixPerso:onMessage(msg, client)
	if msg.type == "choixPerso" then
		if not msg.confirm then
			client.perso = msg.perso or debug_warn("[ArcadeChoixPerso] missing perso")
			-- renvoyer aux clients que untel a cliqué sur tel perso.
		else
			-- checker que les deux joueurs ont selectionne un perso different
			-- si c'est le cas, on peut passer a l'ecran suivant
			-- sinon, message d'erreur renvoyé
		end
	else
		debug_warn("[ArcadeChoixPerso] wrong type")
	end
end

ArcadeChoixPerso = common.class("ArcadeChoixPerso", ArcadeChoixPerso)
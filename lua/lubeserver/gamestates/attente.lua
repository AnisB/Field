Attente = {}

function Attente:init()
	self.x = 42
end

function Attente:update(dt)
	-- print("Weeee !", dt)
end

function Attente:onMessage(msg, client)
	if msg.type == "login" then
		client.pseudo = msg.pseudo or debug_warn("[login] missing pseudo")
		client.cookie = msg.cookie or debug_warn("[login] missing cookie")
		if nb_clients == 2 then
			clients_logged = all(function(c)
				return (c.pseudo ~= nil and c.cookie ~= nil)
			end, clients)
			if clients_logged then
				local i = 0
				for k,c in pairs(clients) do
					if i == 0 then
						monde.player1 = c
						c.numero = 1
					elseif i == 1 then
						monde.player2 = c
						c.numero = 2
					end
					i = i + 1
				end
				if monde.player1.cookie ~= monde.player2.cookie then
					local histories = load_history(monde.player1.cookie, monde.player2.cookie)
					monde.player1.history, monde.player2.history = histories
					gameStateManager:changeState("choixTypeJeu")
					for k,c in pairs(clients) do
						c:send({type= "attenteFinie"})
					end
				else
					debug_warn("[login] same cookies")
				end
			end
		elseif #clients > 2 then
			debug_warn("[login] more than 2 clients")
		end
	else
		debug_warn("[login] wrong type")
	end
end

Attente = common.class("Attente", Attente)
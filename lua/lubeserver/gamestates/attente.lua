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
				gameStateManager:changeState("choixTypeJeu")
			end
			for k,c in pairs(clients) do
				c:send({type= "attenteFinie"})
			end
		elseif #clients > 2 then
			debug_warn("[login] more than 2 clients")
		end
	else
		debug_warn("[login] wrong type")
	end
end

Attente = common.class("Attente", Attente)
require("lubeboth.class")
require("game.history")

Attente = {}

function Attente:init()
	self.discoveryLast = 42
	self.discoveryInterval = 0.2
end

function Attente:reset()

end

function Attente:update(dt)
	-- print("Weeee !", dt)
	self.discoveryLast = self.discoveryLast + dt
	if self.discoveryLast > self.discoveryInterval then
		discoveryBroadcaster:send("hi")
		self.discoveryLast = 0
	end
	discoveryBroadcaster:update(dt)
end


    function Attente:mousePressed(x, y, button)
    end
    
    function Attente:mouseReleased(x, y, button)
    end
    
    
    function Attente:keyPressed(key, unicode)
    end

    function Attente:keyReleased(key, unicode)

    end
    
function Attente:availablePseudo(pseudo)
	for k,c in pairs(clients) do
		if c.pseudo ==pseudo then
			return false
		end
	end
	return true
end
function Attente:draw() end

function Attente:onMessage(msg, client)
	print "bing"
	if msg.type == "login" then

		if not self:availablePseudo(msg.pseudo) then
			client:send({type= "PseudoError"})
			return
		end
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
					monde.maps = listmaps()
					print("MAAAPS =", table2.tostring(monde.maps))
					for k,c in pairs(clients) do
						c:send({type= "attenteFinie"})
						c:send({type= "listmaps", maps= monde.maps})
					end
				else
					debug_warn("[login] same cookies")
					-- WE SHOULD KICK BOTH PLAYERS HERE BY WARNING THE SAME USER LOGGED IN AND RESET THE SERVER
				end
			end
		elseif nb_clients > 2 then
			debug_warn("[login] more than 2 clients")
		end
	else
		debug_warn("[login] wrong type")
	end
end

Attente = common.class("Attente", Attente)
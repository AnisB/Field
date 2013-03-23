package.path = "../lubeboth/?.lua;" .. package.path
require("class")
require("lube")
require("TSerial")
require("client")
require("gamestatemanager")
table2 = require("table2")

-- debug stuff :

debug_lvl = 10
function debug_warn(msg, lvl)
	if lvl == nil then
		lvl = 0
	end
	if debug_lvl >= lvl then
		print("[WARNING]"..msg)
	end
end

-- "low level" events :

function connCallback(clientid)
	local client = common.instance(Client, conn, clientid)
    onConnect(client)
end

function rcvCallback(data, clientid)
	clients[clientid]:gotData(data, onConnect)
end

function disconnCallback(clientid)
	onDisconnect(clients[clientid])
end

-- "high level" events :

function onConnect(client)
	client:speak("bonjour bonjour !")
	clients[client.id] = client -- ajout a la liste des clients
	nb_clients = nb_clients + 1
end

function onMessage(msg, client)
	-- if msg.english then
	-- 	print("received english message with "..tostring(#msg.tags).." tags.")
	-- 	client:send({msg= "Hello, Sir.", understood= true})
	-- else
	-- 	print("received some characters..")
	-- 	client:send({msg= "wtf?", understood= false, details= "Shut up, stranger."})
	-- end
	gameStateManager:onMessage(msg, client)
end

function onDisconnect(client)
	client:speak("bye bye !")
	clients[client.id] = nil -- destroy
	nb_clients = nb_clients - 1
end

-- love stuff :

function love.load()
	clients = {} -- map { idClient => client }
	nb_clients = 0
	gameStateManager = common.instance(GameStateManager)
    --anything
    print("Ready !")
    conn = lube.tcpServer()
	conn.handshake = "hello"
	conn:listen(3410)
	-- setup callbacks ("low level" events) :
	conn.callbacks.recv = rcvCallback
	conn.callbacks.connect = connCallback
	conn.callbacks.disconnect = disconnCallback
end

function love.update(dt)
    conn:update(dt)
    gameStateManager:update(dt)
end

function love.keypressed(key, unicode)
	if key == "escape" then
		love.event.push("quit")
	end
end

-- utils :

function map(f, t)
	local t2 = {}
	for k,v in pairs(t) do
		t2[k] = f(v)
	end
	return t2
end

function all(f, t)
	for k,v in pairs(t) do
		if f(v) == false then
			return false
		end
	end
	return true
end
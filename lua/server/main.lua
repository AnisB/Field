--[[ 
This file is part of the Field project
]]

require("game.gamestatemanager")
require("game.inputmanager")

package.path = "./lubeboth/?.lua;" .. package.path
require("lubeboth.class")
require("lubeboth.lube")
require("lubeboth.TSerial")
require("lubeboth.client")
table2 = require("lubeboth.table2")
cron = require("lubeboth.cron")


SourceDirectory="./"
ImgDirectory="img/"
gameStateManager = nil
inputManager = nil

-- lube :
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
	if (msg.type == "input") then
		inputManager:handlePacket(msg.pck)
	else
		gameStateManager:onMessage(msg, client)
	end
	client:speak(table2.tostring(msg))
end

function onDisconnect(client)
	client:speak("bye bye !")
	clients[client.id] = nil -- destroy
	nb_clients = nb_clients - 1
end
-- /lube

function love.load()
	inputManager = InputManager:new()
	-- lube :
	monde = {} -- messy world.
	clients = {} -- map { idClient => client }
	nb_clients = 0
    print("Ready !")
    conn = lube.tcpServer()
	conn.handshake = "hello"
	conn:listen(3410)
	-- setup callbacks ("low level" events) :
	conn.callbacks.recv = rcvCallback
	conn.callbacks.connect = connCallback
	conn.callbacks.disconnect = disconnCallback
	-- /lube

	love.graphics.setIcon( love.graphics.newImage(ImgDirectory.."icon.png" ))
	gameStateManager = GameStateManager:new()
end

function love.update(dt)
	gameStateManager:update(dt)
end	

function love.mousepressed(x, y, button)
	gameStateManager:mousePressed(x, y, button)
end

function love.mousereleased(x, y, button)
	gameStateManager:mouseReleased(x, y, button)
end

function love.keypressed(key, unicode)
	if key == "escape" then
		love.event.push("quit")
	end
	gameStateManager:keyPressed(key, unicode)
end

function love.keyreleased(key, unicode)
	gameStateManager:keyReleased(key, unicode)
end

function love.update(dt)
	conn:update(dt)
	cron.update(dt)
	gameStateManager:update(dt)
end	

function love.draw()
	gameStateManager:draw()
end

-- utils for lube :

debug_lvl = 10
function debug_warn(msg, lvl)
	if lvl == nil then
		lvl = 0
	end
	if debug_lvl >= lvl then
		print("[WARNING]"..msg)
	end
end

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
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
FontDirectory="font/"
MapDirectory="maps/"
gameStateManager = nil
inputManager = nil

graphic_stuff_enabled = true

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
	-- client:speak(table2.tostring(msg))
end

function onDisconnect(client)
	client:speak("bye bye !")
	clients[client.id] = nil -- destroy
	nb_clients = nb_clients - 1
end
-- /lube

function love.load()
	success = love.graphics.setMode( 400, 250)
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

	discoveryBroadcaster = lube.udpClient()
	discoveryBroadcaster:connect("255.255.255.255", 3411, false)
	discoveryBroadcaster:setOption("broadcast", true)
	-- /lube

	if graphic_stuff_enabled then
		load_graphic_stuff()
	end

	-- recuperer ip publique :
	local http = require("socket.http")
	local b, c, h = http.request("http://fspot.org/ip.php")
	if b ~= nil then
		ip_externe = b
	end

	gameStateManager = GameStateManager:new()
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

-- function love.draw()
-- 	gameStateManager:draw()
-- end

function load_graphic_stuff()
	local ip_font = love.graphics.newFont(FontDirectory .. "font.ttf", 20)
	love.graphics.setFont(ip_font)
	-- ip_background = love.graphics.newImage(ImgDirectory .. "ipbg.png")
end

function love.draw()
	if graphic_stuff_enabled then
		-- love.graphics.draw(ip_background, 0, 0)
		love.graphics.print("IP externe :", 20, 40)
		if ip_externe ~= nil then
			love.graphics.print(ip_externe, 100, 120)
		else
			love.graphics.print("?", 40, 120)
		end
	end
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

function listmaps()
	local files = love.filesystem.enumerate(MapDirectory)
	local m = {}
	for k,v in pairs(files) do
		if string.sub(v, -4) == ".lua" then
			table.insert(m, string.sub(v, 0, -5))
		end
	end
	return m
end
--[[ 
This file is part of the Field project
]]

require("game.gamestatemanager")

package.path = "./lubeboth/?.lua;" .. package.path
require("lubeboth.class")
require("lubeboth.lube")
require("lubeboth.TSerial")
require("lubeboth.client")
cron = require("lubeboth.cron")
table2 = require("lubeboth.table2")

SourceDirectory="./"
ImgDirectory="img/"
gameStateManager = nil

-- "low level" events :

function rcvCallback(data)
    serveur:gotData(data, onConnect)
end

-- "high level" events :

function onMessage(msg)
	-- print("Received : " .. table2.tostring(msg))
	if msg.type == "gameplaypacket" then
		gameStateManager.state['Gameplay']:handlePacket(msg.pk)
	else
		print("Pkg has no type gameplaypacket !")
	end
end

function love.load()
	-- lube :
    conn = lube.tcpClient()
	conn.handshake = "hello"
	serveur = common.instance(Client, conn) -- oui, le serveur est un "client" :)

	local okay = nil
	while okay ~= true do
		print(okay)
		okay = conn:connect("localhost", 3410, true)
	end

	print(okay)

	conn.callbacks.recv = rcvCallback
	print("CONNECTED !!")
	-- /lube

	love.graphics.setIcon( love.graphics.newImage(ImgDirectory.."icon.png" ))
	gameStateManager = GameStateManager:new()
end

function love.update(dt)
	-- lube :
	conn:update(dt)
	cron.update(dt)
	-- /lube

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

function love.draw()
	gameStateManager:draw()
end
--[[ 
This file is part of the Field project
]]

require("game.gamestatemanager")

package.path = "./lubeboth/?.lua;" .. package.path
require("lubeboth.class")
require("lubeboth.lube")
require("lubeboth.TSerial")
require("lubeboth.client")
require("game.musicmanager")
cron = require("lubeboth.cron")
table2 = require("lubeboth.table2")

SourceDirectory="./"
ImgDirectory="img/"
FontDirectory="font/"
gameStateManager = nil

gamePaused = false

musicM = MusicManager.new()
musicM:play()


-- "low level" events :

function rcvCallback(data)
    serveur:gotData(data, onConnect)
end

-- "high level" events :

function onMessage(msg)
	-- print("Received : " .. table2.tostring(msg))
	if gameStateManager.currentState=='Gameplay' then
	if msg.type == "gameplaypacket" then
		gameStateManager.state['Gameplay']:handlePacket(msg.pk)
	end
	elseif msg.type == "listmaps" then
		print("MAPS =", table2.tostring(msg))
		monde.availableMaps = msg.maps
	else
		gameStateManager:onMessage(msg)
	end
end

function discoveryCallback(data, id)
    ip_addr = id:sub(0, id:find(':')-1)
    -- print("Got data :", data, "From :", ip_addr)
    if data == "hi" then
    	gameStateManager:onMessage({type="discovery", ip=ip_addr})
    end
end

function love.load()
	-- lube :
	discoveryListener = lube.udpServer()
	discoveryListener:listen(3411)
	discoveryListener.callbacks.recv = discoveryCallback
	-- /lube
	monde = {}
	love.graphics.setIcon( love.graphics.newImage(ImgDirectory.."icon.png" ))
	gameStateManager = GameStateManager.new()
	love.audio.setDistanceModel("exponent")
	--love.audio.setOrientation(0,0,1, 0,1,0)
	love.audio.setPosition(love.graphics.getWidth()/2, love.graphics.getHeight()/2,0)
end

function love.update(dt)
	-- lube :
	if conn ~= nil then
		conn:update(dt)
	end

	-- Music managing
	musicM:update(dt)

	
	-- cron.update(dt)
	
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

function love.joystickpressed(joystick, button)
	if not gamePaused then
		if button==10 then --start manette = touche return du clavier
			love.event.push('keypressed', "return")
		end
		gameStateManager:joystickPressed(joystick, button)
	end
end

function love.joystickreleased(joystick, button)
	if not gamePaused then
		if button==10 then --start manette = touche return du clavier
			love.event.push('keyreleased', "return")
		end
		gameStateManager:joystickReleased(joystick, button)
	end
end

function love.draw()
-- love.graphics.setBackgroundColor( 0, 0, 0, 255 )
-- canvas:clear()
gameStateManager:draw()
-- love.graphics.setCanvas()	
-- draw scaled canvas to screen
love.graphics.setColor(255,255,255)


end

function love.focus(b)
    if not b then
        gamePaused = true
	else 
		gamePaused = false
	end
end
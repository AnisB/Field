--[[ 
This file is part of the Field project
]]

require("game.gamestatemanager")


SourceDirectory="./"
ImgDirectory="img/"
gameStateManager = nil

function love.load()
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
	gameStateManager:update(dt)
end	

function love.draw()
	gameStateManager:draw()
end
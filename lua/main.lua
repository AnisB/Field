--[[ 
This file is part of the Field project
]]
-- Regle de nommage les singletons commencent par un s_


-- Includes
-- Configuration 
require("const")
require("conf")
-- Game management
require("gamemanager")

-- Resources
require("resource.resourcemanager")


function love.load()
	-- Initialisation de l'icone
	love.window.setIcon( s_resourceManager:LoadImageData("icons/256x256.png" ))

	-- Initialisation de l'input Manager
	s_inputManager:Init()

	-- Initialisation du jeu
	s_gameManager:Init()

	PushEvent("Input", {joystick=1, duration=0.2, intersityX=0.5, intersitY=0.5})
end

function love.update(dt)
	-- Mise a jour de l'input mamanger, principalement pour les axes des joystick
	s_inputManager:update(dt)

	s_gameManager:update(dt)
end	

function love.keypressed(key, isrepeat)
	s_inputManager:keypressed(key, isrepeat)
end

function love.keyreleased(key)
	s_inputManager:keyreleased(key)
end

function love.joystickpressed(joystick, button)
	s_inputManager:joystickpressed(joystick, button)
end

function love.joystickreleased(joystick, button)
	s_inputManager:joystickreleased(joystick, button)
end

function love.draw()
	s_gameManager:draw(dt)
end

function love.focus(b)
	-- s_gameManager:focus(dt)
end
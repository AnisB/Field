--[[ 
This file is part of the Field project
]]
-- Regle de nommage les singletons commencent par un s_


-- Includes
-- Configuration 
require("const")
require("conf")
-- Game management
require("field")

-- Resources
require("resource.resourcemanager")
-- Inputs
require("input.inputmanager")


function love.load()
	-- Initialisation de l'icone
	love.window.setIcon( s_resourceManager:LoadImageData("icons/256x256.png" ))

	-- Initialisation de l'input Manager
	s_inputManager:Init()

	-- Initialisation du jeu
	s_field:Init()
end

function love.update(dt)
	-- Mise a jour de l'input mamanger, principalement pour les axes des joystick
	s_inputManager:update(dt)

	s_field:update(dt)
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
	s_field:draw(dt)
end

function love.focus(b)
	-- s_field:focus(dt)
end
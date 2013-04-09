--[[ 
This file is part of the Field project]]

ChoixTypeJeu = {}
ChoixTypeJeu.__index = ChoixTypeJeu
function ChoixTypeJeu:new()
    local self = {}
    setmetatable(self, ChoixTypeJeu)
    self.isRed=0
    return self
end

function ChoixTypeJeu:mousePressed(x, y, button)
	if x > 90 and x < 90+150 and y > 105 and y < 105+35 then
		serveur:send({type="choixTypeJeu", typeJeu="arcade"})
	elseif x > 90 and x < 90+150 and y > 205 and y < 205+35 then
		--serveur:send({type="choixTypeJeu", typeJeu="histoire"})
	end
end

function ChoixTypeJeu:mouseReleased(x, y, button) end
function ChoixTypeJeu:keyPressed(key, unicode) end
function ChoixTypeJeu:keyReleased(key, unicode) end

function ChoixTypeJeu:joystickPressed(joystick, button)
end

function ChoixTypeJeu:joystickReleased(joystick, button)
end

function ChoixTypeJeu:update(dt) end

function ChoixTypeJeu:onMessage(msg)
	if msg.type == "choixTypeJeuFini" then
		monde.typeJeu = msg.typeJeu
		if monde.typeJeu == 'arcade' then
			if msg.persos == nil then
				gameStateManager:changeState('ChoixPerso')
			else
				return -- on verra ?
			end
		end
	else
		print("[ChoixTypeJeu] wrong type :", table2.tostring(msg))
	end
end

function ChoixTypeJeu:draw()
	local hover = false
	x, y = love.mouse.getPosition()

	-- background :
	love.graphics.draw(gameStateManager.state['ConnectToServer'].bg, 0, 0)

	-- rectangles :
	if x > 90 and x < 90+150 and y > 105 and y < 105+35 then
		love.graphics.setColor(150, 150, 150, 255)
		hover = true
	else
		love.graphics.setColor(50, 50, 50, 255)
	end
	love.graphics.rectangle("fill", 90, 105, 150, 35)

	if x > 90 and x < 90+150 and y > 205 and y < 205+35 then
		love.graphics.setColor(150, 150, 150, 255)
		hover = true
	else
		love.graphics.setColor(50, 50, 50, 255)
	end
	love.graphics.rectangle("fill", 90, 205, 150, 35)

	-- text :
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.print("arcade", 100, 100)
	love.graphics.print("histoire", 100, 200)

	-- cursor :
	if hover then
		love.mouse.setVisible(false)
		love.graphics.draw(gameStateManager.state['ConnectToServer'].handcursor, x-17, y-17)
	else
		love.mouse.setVisible(true)
	end
end

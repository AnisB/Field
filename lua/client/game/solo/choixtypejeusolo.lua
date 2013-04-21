--[[ 
This file is part of the Field project]]

ChoixTypeJeuSolo = {}
ChoixTypeJeuSolo.__index = ChoixTypeJeuSolo
function ChoixTypeJeuSolo.new()
    local self = {}
    setmetatable(self, ChoixTypeJeuSolo)
    self.isRed=0
    return self
end

function ChoixTypeJeuSolo:mousePressed(x, y, button)
	if x > 90 and x < 90+150 and y > 105 and y < 105+35 then
		gameStateManager.state['ChoixPersoSolo'] = ChoixPersoSolo.new(false)
		gameStateManager:changeState('ChoixPersoSolo')
		love.mouse.setVisible(true)
	elseif x > 90 and x < 90+150 and y > 205 and y < 205+35 then
		gameStateManager.state['ChoixPersoSolo'] = ChoixPersoSolo.new(true)
		gameStateManager:changeState('ChoixPersoSolo')
		love.mouse.setVisible(true)
	elseif x > 90 and x < 90+150 and y > 605 and y < 605+35 then
		gameStateManager:changeState('Menu')
		love.mouse.setVisible(true)
	end
end

function ChoixTypeJeuSolo:mouseReleased(x, y, button) end
function ChoixTypeJeuSolo:keyPressed(key, unicode) end
function ChoixTypeJeuSolo:keyReleased(key, unicode) end

function ChoixTypeJeuSolo:joystickPressed(joystick, button)
end

function ChoixTypeJeuSolo:joystickReleased(joystick, button)
end

function ChoixTypeJeuSolo:update(dt) 

end


function ChoixTypeJeuSolo:draw()
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

	if x > 90 and x < 90+150 and y > 605 and y < 605+35 then
		love.graphics.setColor(150, 150, 150, 255)
		hover = true
	else
		love.graphics.setColor(50, 50, 50, 255)
	end
	love.graphics.rectangle("fill", 90, 605, 150, 35)


	-- text :
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.print("arcade", 100, 100)
	love.graphics.print("histoire", 100, 200)
	love.graphics.print("return", 100, 600)

	-- cursor :
	if hover then
		love.mouse.setVisible(false)
		love.graphics.draw(gameStateManager.state['ConnectToServer'].handcursor, x-17, y-17)
	else
		love.mouse.setVisible(true)
	end
end

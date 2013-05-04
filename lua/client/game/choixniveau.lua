--[[ 
This file is part of the Field project]]

ChoixNiveau = {}
ChoixNiveau.__index = ChoixNiveau
function ChoixNiveau:new()
    local self = {}
    setmetatable(self, ChoixNiveau)
    self.err = false
    self.num_level = 1
    monde.availableMaps = {"level1", "level2", "level28"}
    self.level = monde.availableMaps[self.num_level]
    return self
end

function ChoixNiveau:mousePressed(x, y, button)
	if x > 90 and x < 90+40 and y > 105 and y < 105+35 then
		self:keyPressed("q")
	elseif x > 365 and x < 365+40 and y > 105 and y < 105+35 then
		self:keyPressed("d")
	elseif x > 198 and x < 198+100 and y > 600 and y < 600+50 then
		self:keyPressed("return", 13)
	end
end

function ChoixNiveau:mouseReleased(x, y, button) end

function ChoixNiveau:keyPressed(key, unicode)
	if key == "q" then
		self.num_level = self.num_level - 1
	elseif key == "d" then
		self.num_level = self.num_level + 1
	elseif key == "return" then
		serveur:send({type= "choixNiveau", level=self.level})
	end
	if self.num_level < 1 then self.num_level = 1 end
	if self.num_level > #monde.availableMaps then self.num_level = #monde.availableMaps end
	self.level = monde.availableMaps[self.num_level]
end

function ChoixNiveau:keyReleased(key, unicode) end

function ChoixNiveau:joystickPressed(joystick, button)
end

function ChoixNiveau:joystickReleased(joystick, button)
end

function ChoixNiveau:update(dt) end

function ChoixNiveau:onMessage(msg)
	if msg.type == "choixNiveau" then
		monde.niveau = msg.level
            gameStateManager.state['Gameplay']=Gameplay.new("maps."..msg.level,true)
            gameStateManager:changeState('Gameplay')	
	else
		print("[ChoixNiveau] wrong type :", table2.tostring(msg))
	end
end

function ChoixNiveau:draw()
	local hover = false
	x, y = love.mouse.getPosition()

	-- background :
	-- love.graphics.draw(gameStateManager.state['ConnectToServer'].bg, 0, 0)

	-- rectangles :
	if x > 90 and x < 90+40 and y > 105 and y < 105+35 then
		love.graphics.setColor(150, 150, 150, 255)
		hover = true
	else
		love.graphics.setColor(50, 50, 50, 255)
	end
	love.graphics.rectangle("fill", 90, 105, 40, 35)

	if x > 365 and x < 365+40 and y > 105 and y < 105+35 then
		love.graphics.setColor(150, 150, 150, 255)
		hover = true
	else
		love.graphics.setColor(50, 50, 50, 255)
	end
	love.graphics.rectangle("fill", 365, 105, 40, 35)

	-- text :
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.print("<", 100, 100)
	love.graphics.print(">", 380, 100)

	love.graphics.print(self.level, 190, 100)

	if x > 198 and x < 198+100 and y > 600 and y < 600+50 then
		love.graphics.setColor(150, 150, 150, 255)
		hover = true
	else
		love.graphics.setColor(50, 50, 50, 255)
	end
	love.graphics.rectangle("fill", 198, 600, 100, 50)
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.print("PLAY", 198+10, 600)

	-- cursor :
	if hover then
		love.mouse.setVisible(false)
		love.graphics.draw(gameStateManager.state['ConnectToServer'].handcursor, x-17, y-17)
	else
		love.mouse.setVisible(true)
	end
end

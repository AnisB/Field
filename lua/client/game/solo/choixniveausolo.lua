--[[ 
This file is part of the Field project]]

require("game.solo.gameplaysolo")

ChoixNiveauSolo = {}
ChoixNiveauSolo.__index = ChoixNiveauSolo
function ChoixNiveauSolo.new(player,continuous)
    local self = {}
    setmetatable(self, ChoixNiveauSolo)
    self.num_level = 1
    monde.availableMaps = {"level1", "level2", "level28"}
    self.level = monde.availableMaps[self.num_level]
    self.player = player
    self.continuous=continuous
    print("recu".. self.player)
    return self
end

function ChoixNiveauSolo:mousePressed(x, y, button)
	if x > 90 and x < 90+40 and y > 105 and y < 105+35 then
		self:keyPressed("q")
	elseif x > 365 and x < 365+40 and y > 105 and y < 105+35 then
		self:keyPressed("d")
	elseif x > 198 and x < 198+100 and y > 600 and y < 600+50 then
		gameStateManager.state['GameplaySolo']= GameplaySolo.new(self.level,self.continuous,self.player)
		gameStateManager:changeState('GameplaySolo')
	
	elseif x > 1050 and x < 1050+200 and y > 650 and y < 650+50 then
		gameStateManager:changeState("ChoixPersoSolo")
	end
end

function ChoixNiveauSolo:mouseReleased(x, y, button) end

function ChoixNiveauSolo:keyPressed(key, unicode)
	if key == "q" or key== "left" then
		self.num_level = self.num_level - 1
	elseif key == "d" or key== "right" then
		self.num_level = self.num_level + 1
	elseif key == "return" then

	end
	if self.num_level < 1 then self.num_level = 1 end
	if self.num_level > #monde.availableMaps then self.num_level = #monde.availableMaps end
	self.level = monde.availableMaps[self.num_level]
end

function ChoixNiveauSolo:keyReleased(key, unicode) end

function ChoixNiveauSolo:joystickPressed(joystick, button)
end

function ChoixNiveauSolo:joystickReleased(joystick, button)
end

function ChoixNiveauSolo:update(dt) end


function ChoixNiveauSolo:draw()
	local hover = false
	x, y = love.mouse.getPosition()

	-- background :
	love.graphics.draw(gameStateManager.state['ConnectToServer'].bg, 0, 0)

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

	if x > 1050 and x < 1050+200 and y > 650 and y < 650+50 then
		love.graphics.setColor(150, 150, 150, 255)
	else
		love.graphics.setColor(50, 50, 50, 255)
	end
	love.graphics.rectangle("fill", 1050, 650, 200, 50)
	love.graphics.setColor(255, 100, 100, 255)
	love.graphics.print("Return",1050+50,655)


	-- cursor :
	if hover then
		love.mouse.setVisible(false)
		love.graphics.draw(gameStateManager.state['ConnectToServer'].handcursor, x-17, y-17)
	else
		love.mouse.setVisible(true)
	end
end

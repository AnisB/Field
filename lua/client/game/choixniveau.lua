--[[ 
This file is part of the Field project]]

ChoixNiveau = {}
ChoixNiveau.__index = ChoixNiveau
function ChoixNiveau:new()
    local self = {}
    setmetatable(self, ChoixNiveau)
    self.err = false
    self.level = "maps.level7"
    self.num_level = 1
    return self
end

function ChoixNiveau:mousePressed(x, y, button) end
function ChoixNiveau:mouseReleased(x, y, button) end

function ChoixNiveau:keyPressed(key, unicode)
	if key == "q" then
		self.num_level = self.num_level + 1
	elseif key == "d" then
		self.num_level = self.num_level - 1
	elseif unicode == 13 then
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
	love.graphics.print("Pour changer de niveau, utilisez les touches Q et D.", 200, 100)
	love.graphics.print(self.level, 200, 200)
end

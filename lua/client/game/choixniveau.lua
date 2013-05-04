--[[ 
This file is part of the Field project]]

ChoixNiveau = {}
ChoixNiveau.__index = ChoixNiveau
function ChoixNiveau:new()
    local self = {}
    setmetatable(self, ChoixNiveau)
    self.back=love.graphics.newImage("backgrounds/choixniveau/back.png")
    self.levellabel=love.graphics.newImage("backgrounds/choixniveau/level.png")

    self.play= Button.new(550,640,200,50,ButtonType.Small,"backgrounds/choixniveau/play.png")
    self.returnB= Button.newDec(1000,640,250,50,ButtonType.Large,"backgrounds/choixniveau/return.png",10,0)

    self.right= Button.new(1000,350,123,155,ButtonType.Arrow,"backgrounds/choixniveau/right.png")
    self.left= Button.newDec(90,350,123,155,ButtonType.Arrow,"backgrounds/choixniveau/left.png",10,0)

    self.err = false
    self.num_level = 1
    monde.availableMaps = {"NONE"}
    self.level = monde.availableMaps[self.num_level]
    return self
end

function ChoixNiveau:mousePressed(x, y, button)
	if self.left:isCliked(x,y) then
		self:keyPressed("q")
	elseif self.right:isCliked(x,y) then
		self:keyPressed("d")
	elseif self.returnB:isCliked(x,y) then
		-- PAS ENCORE PROGRAMME
	elseif self.play:isCliked(x,y) then
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
	x, y = love.mouse.getPosition()

	-- background :
	love.graphics.draw(self.back, 0, 0)

	love.graphics.draw(self.levellabel, 420, 200)

	love.graphics.print(self.level, 620, 200)
	self.right:draw(x,y,1)
	self.left:draw(x,y,1)
    self.play:draw(x,y,1)
    self.returnB:draw(x,y,1)

end

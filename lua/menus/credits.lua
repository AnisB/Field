--[[ 
This file is part of the Field project]]

-- Utile pour les anims
require("game.field")

Credits = {}
Credits.__index = Credits

function Credits:new()
    local self = {}
    setmetatable(self, Credits)

    -- Personnages qui bougent
    self.mm = AnimMM.new("metalman/acier")
    self.tm = AnimTM.new("themagnet")
    self.mm:load("running",true)
    self.tm:load("field",true)
	self.diffuse  = love.graphics.newQuad(0, 0, 64, 64, 128, 64)

	self.inputManager = MenuInputManager.new(self)

    -- Champ
    self.field= Field.new("Repulsive",{x=750,y=350})

    -- Init attributs
    self.field.isActive=true
    self.timer=1
    self.down=true

    return self
end


function Credits:mousePressed(x, y, button)

end

function Credits:mouseReleased(x, y, button)
end

function Credits:keyPressed(key, unicode)
    self.inputManager:keyPressed(key,unicode)
end

function Credits:keyReleased(key, unicode)
    self.inputManager:keyReleased(key,unicode)
end

function Credits:joystickPressed(key, unicode)
    self.inputManager:joystickPressed(key,unicode)
end


function Credits:joystickReleased(key, unicode)
    self.inputManager:joystickReleased(key,unicode)
end


function Credits:sendPressedKey(key, unicode) 
	if key == "return" then
		gameStateManager:changeState('Menu')
	end
end

function Credits:keyReleased(key, unicode)
end



function Credits:update(dt)
	-- Maj du field et des persos
	self.inputManager:update()
	self.field:update(dt)
	self.mm:update(dt)
	self.tm:update(dt)

	-- Clignotage du "Press Start"
	if self.down then
		self.timer= self.timer -dt 
		if self.timer<=0 then
			self.down=false
			self.timer=0
		end

	else
		self.timer= self.timer +dt 
		if self.timer >=1 then
			self.down=true
			self.timer=1
		end
	end
end

function Credits:draw()
	love.graphics.setColor(255,255,255,255)
	self.field:draw(770, 375)
	love.graphics.drawq(self.mm:getSprite(),self.diffuse, 450, 275,0,2,2)
	love.graphics.drawq(self.tm:getSprite(),self.diffuse, 700, 275,0,2,2)
	love.graphics.printf("This game was created by an indie team. It's a network cooperative game based on an assymetric gameplay about electromagnetic forces.", 100, 75,1000)
	love.graphics.printf("The team is composed of:\n Pierre Germain(Infography), Anthony Clerc(Sound Design), Julien Deville(Level Design), Anis Benyoub(Game Design, Gameplay and network Dev), Frédéric Matigot and Florent Weillaert(Network Dev).", 100, 425, 1100)
	love.graphics.setColor(200,100,100,255*self.timer)
	love.graphics.printf("Press start", 0, 650, 1280, "center")


end
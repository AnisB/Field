


require("game.field")

Credits = {}
Credits.__index = Credits

function Credits:new()
    local self = {}
    setmetatable(self, Credits)
    self.mm = AnimMM.new("metalman/acier")
    self.tm = AnimTM.new("themagnet")
    self.mm:load("running",true)
    self.tm:load("field",true)
    self.field= Field.new("Repulsive",{x=750,y=350})
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
	if key == "return" then
		gameStateManager:changeState('Menu')
	end
end

function Credits:keyReleased(key, unicode)
end



function Credits:update(dt)
	self.field:update(dt)
	self.mm:update(dt)
	self.tm:update(dt)
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
	self.field:draw(770, 400)
	love.graphics.draw(self.mm:getSprite(), 450, 300,0,2,2)
	love.graphics.draw(self.tm:getSprite(), 700, 300,0,2,2)
	love.graphics.printf("Ce jeu est une création d'un groupe de passionés de développement de jeu vidéo, c'est un jeu réseau coopératif à gameplay assymétrique basé sur les forces éléctromagnétiques.", 100, 100,1000)
	love.graphics.printf("L'équipe est composée de Pierre Germain(Graphisme), Anthony Clerc(Sound Design), Julien Deville(Level Design), Anis Benyoub(Game Design, Lead and network Dev), Frédéric Matigot et Florent Weillaert(Network Dev).", 100, 450, 1000)
	love.graphics.setColor(200,100,100,255*self.timer)
	love.graphics.printf("Appuyez sur entrée pour sortir", 0, 650, 1280, "center")


end
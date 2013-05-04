--[[ 
This file is part of the Field project]]
require("game.sound")

FirstEnter = {}
FirstEnter.__index = FirstEnter
function FirstEnter:new()
    local self = {}
    setmetatable(self, FirstEnter)
    self.timer=1
    self.img=love.graphics.newImage("img/title.png")
    self.trans=255
    self.up=true
    self.shouldPass=false
    self.passTimer=1
    return self
end


function FirstEnter:mousePressed(x, y, button)
end

function FirstEnter:mouseReleased(x, y, button)
end


function FirstEnter:keyPressed(key, unicode)
	if key=="return" and self.shouldPass==false then
		self.shouldPass=true
		Sound.playSound("firstenter")
	end
	
end

function FirstEnter:keyReleased(key, unicode)
end

function FirstEnter:joystickPressed(joystick, button)
end

function FirstEnter:joystickReleased(joystick, button)
end

function FirstEnter:update(dt)
	if self.trans<=0 then 
		self.up=false
	end
	if self.trans>=255 then 
		self.up=true
	end
	if self.up then
		self.trans=self.trans-math.floor(dt*150)
		if self.trans<=0 then
			self.trans=0
		end
	else
		self.trans=self.trans+math.floor(dt*150)
		if self.trans>=255 then
			self.trans=255
		end
	end

	if self.shouldPass then
		self.passTimer= self.passTimer - dt
		if self.passTimer<=0 then
			gameStateManager:resetAndChangeState('Menu')
		end
	end
end

function FirstEnter:draw()
	love.graphics.setColor(255,150,150,self.trans*self.passTimer)
	love.graphics.print("Press Return",500,500)
	love.graphics.setColor(255,255,255,255*self.passTimer)
	love.graphics.draw(self.img,300,100)


end


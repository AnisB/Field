--[[ 
This file is part of the Field project]]

require("game.ui.button")
Options = {}
Options.__index = Options
function Options:new()
    local self = {}
    setmetatable(self, Options)
    self.enteringDone = false
    self.timer=0
    self.returnB=Button.new(1000,625,200,50,ButtonType.Large,"backgrounds/options/return.png")
    self.audio=Button.newDec(100,200,200,50,ButtonType.Small,"backgrounds/options/audio.png",-10,-10)
    self.video=Button.newDec(100,300,200,50,ButtonType.Small,"backgrounds/options/video.png",-10,-10)
    self.gameplay=Button.newDec(100,400,200,50,ButtonType.VLarge,"backgrounds/options/gameplay.png",20,20)
    self.back=love.graphics.newImage("backgrounds/options/back.png")
    return self
end

function Options:mousePressed(x, y, button)
		if x > 1050 and x < 1050+200 and y > 650 and y < 650+50 then
			gameStateManager:changeState("Menu")
			self.enteringDone=false
			self.timer=0
		end
end

function Options:mouseReleased(x, y, button) 
end

function Options:keyPressed(key, unicode) 
end

function Options:keyReleased(key, unicode) 
end

function Options:joystickPressed(joystick, button)
end

function Options:joystickReleased(joystick, button)
end

function Options:update(dt) 
	if not self.enteringDone then
		self.timer =self.timer +dt
		if self.timer>=1 then
			self.timer=1
			self.enteringDone=true
		end
	end
end


function Options:draw()
	love.graphics.setColor(255,255,255,255*self.timer)
	love.graphics.draw(self.back,0,0)
	x, y = love.mouse.getPosition()

	self.audio:draw(x,y,self.timer)
	self.video:draw(x,y,self.timer)
	self.gameplay:draw(x,y,self.timer)
	self.returnB:draw(x,y,self.timer)





end

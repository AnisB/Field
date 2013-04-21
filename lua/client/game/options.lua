--[[ 
This file is part of the Field project]]

Options = {}
Options.__index = Options
function Options:new()
    local self = {}
    setmetatable(self, Options)
    self.enteringDone = false
    self.timer=0
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
	love.graphics.draw(gameStateManager.state['ConnectToServer'].bg, 0, 0)	
	x, y = love.mouse.getPosition()




	 	if x > 1050 and x < 1050+200 and y > 650 and y < 650+50 then
	 		love.graphics.setColor(150, 150, 150, 255*self.timer)
	 	else
	 		love.graphics.setColor(50, 50, 50, 255*self.timer)
	 	end
	 	love.graphics.rectangle("fill", 1050, 650, 200, 50)
	 	love.graphics.setColor(255, 100, 100, 255*self.timer)
	 	love.graphics.print("Return",1050+50,655)


end

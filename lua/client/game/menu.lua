--[[ 
This file is part of the Field project]]

Menu = {}
Menu.__index = Menu
function Menu:new()
    local self = {}
    setmetatable(self, Menu)
    self.err = false
    self.isRed=0
    self.img=love.graphics.newImage("img/title.png")
    self.timer=0
    self.enteringDone=false
    self.shouldQuit=false
    self.filter=1
    return self
end

function Menu:mousePressed(x, y, button)
	if not self.shouldQuit then
		if x > 550 and x < 550+200 and y > 350 and y < 350+50 then
		  -- gameStateManager:changeState('Menu')
		end


		if x > 550 and x < 550+200 and y > 450 and y < 450+50 then
			gameStateManager:changeState('ConnectToServer')
		end


		if x > 550 and x < 550+200 and y > 550 and y < 550+50 then
			gameStateManager:changeState('Options')
		end


		if x > 1050 and x < 1050+200 and y > 650 and y < 650+50 then
			self.shouldQuit=true
			self.filter=0.5
		end
	else
		if x > 540 and x < 540+100 and y > 550 and y < 550+50 then
			love.event.push("quit")
	 	end

	 	if x > 640 and x < 640+100 and y > 550 and y < 550+50 then
			self.shouldQuit=false
			self.filter=1
	 	end
	end
end

function Menu:mouseReleased(x, y, button) 
end

function Menu:keyPressed(key, unicode) 
end

function Menu:keyReleased(key, unicode) 
end

function Menu:joystickPressed(joystick, button)
end

function Menu:joystickReleased(joystick, button)
end

function Menu:update(dt) 
	if not self.enteringDone then
		self.timer =self.timer +dt
		if self.timer>=1 then
			self.timer=1
			self.enteringDone=true
		end
	end
end


function Menu:draw()
	love.graphics.setColor(255,255,255,255*self.timer*self.filter)
	love.graphics.draw(gameStateManager.state['ConnectToServer'].bg, 0, 0)	
	love.graphics.draw(self.img,300,100)
	x, y = love.mouse.getPosition()



	-- rectangles :
	 if not self.shouldQuit then
	 	if x > 550 and x < 550+200 and y > 350 and y < 350+50 then
	 		love.graphics.setColor(150, 150, 150, 255)
	 	else
	 		love.graphics.setColor(50, 50, 50, 255)
	 	end
	 	love.graphics.rectangle("fill", 550, 350, 200, 50)

	 	love.graphics.setColor(255, 100, 100, 255)
	 	love.graphics.print("Solo",620,355)


	 	if x > 550 and x < 550+200 and y > 450 and y < 450+50 then
	 		love.graphics.setColor(150, 150, 150, 255)
	 	else
	 		love.graphics.setColor(50, 50, 50, 255)
	 	end
	 	love.graphics.rectangle("fill", 550, 450, 200, 50)

	 	love.graphics.setColor(255, 100, 100, 255)
	 	love.graphics.print("Coop",620,455)


	 	if x > 550 and x < 550+200 and y > 550 and y < 550+50 then
	 		love.graphics.setColor(150, 150, 150, 255)
	 	else
	 		love.graphics.setColor(50, 50, 50, 255)
	 	end
	 	love.graphics.rectangle("fill", 550, 550, 200, 50)
	 	love.graphics.setColor(255, 100, 100, 255)
	 	love.graphics.print("Options",600,555)
	 	if x > 1050 and x < 1050+200 and y > 650 and y < 650+50 then
	 		love.graphics.setColor(150, 150, 150, 255)
	 	else
	 		love.graphics.setColor(50, 50, 50, 255)
	 	end
	 	love.graphics.rectangle("fill", 1050, 650, 200, 50)
	 	love.graphics.setColor(255, 100, 100, 255)
	 	love.graphics.print("Quit",1050+70,655)
	 else

	 	love.graphics.setColor(50, 50, 50, 255*self.filter)
	 	love.graphics.rectangle("fill", 550, 350, 200, 50)
	 	love.graphics.setColor(255, 100, 100, 255*self.filter)
	 	love.graphics.print("Solo",620,355)
	 	love.graphics.setColor(50, 50, 50, 255*self.filter)
	 	love.graphics.rectangle("fill", 550, 450, 200, 50)
	 	love.graphics.setColor(255, 100, 100, 255*self.filter)
	 	love.graphics.print("Coop",620,455)
	 	love.graphics.setColor(50, 50, 50, 255*self.filter)
	 	love.graphics.rectangle("fill", 550, 550, 200, 50)
	 	love.graphics.setColor(255, 100, 100, 255*self.filter)
	 	love.graphics.print("Options",600,555)
	 	love.graphics.setColor(150, 150, 150, 255*self.filter)
	 	love.graphics.setColor(50, 50, 50, 255)
	 	love.graphics.rectangle("fill", 1050, 650, 200, 50)
	 	love.graphics.setColor(255, 100, 100, 255*self.filter)
	 	love.graphics.print("Quit",1050+70,655)


	 	love.graphics.setColor(50, 50, 50, 255)
	 	love.graphics.rectangle("fill", 400, 300, 500, 350)
	 	love.graphics.setColor(255, 255, 255, 255)
	 	love.graphics.print("Etes-vous sûr de vouloir ",430,320)
	 	love.graphics.print("quitter?",590,360)

	 	if x > 540 and x < 540+100 and y > 550 and y < 550+50 then
	 		love.graphics.setColor(150, 150, 150, 255)
	 	else
	 		love.graphics.setColor(50, 50, 50, 255)
	 	end
	 	love.graphics.rectangle("fill", 540, 550, 100, 50)
	 	love.graphics.setColor(255, 100, 100, 255)
	 	love.graphics.print("Oui",570,555)
	 	if x > 640 and x < 640+100 and y > 550 and y < 550+50 then
	 		love.graphics.setColor(150, 150, 150, 255)
	 	else
	 		love.graphics.setColor(50, 50, 50, 255)
	 	end
	 	love.graphics.rectangle("fill", 640, 550, 100, 50)
	 	love.graphics.setColor(255, 255, 255, 255)
	 	love.graphics.print("Non",660,555)

	 end


		

end

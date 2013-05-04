--[[ 
This file is part of the Field project]]


require("game.ui.button")
Menu = {}
Menu.__index = Menu
function Menu:new()
    local self = {}
    setmetatable(self, Menu)
    self.err = false
    self.isRed=0
    self.timer=0
    self.enteringDone=false
    self.shouldQuit=false
    self.filter=1

    self.back=love.graphics.newImage("backgrounds/menu/back.png")
    self.solo=Button.new(150,250,200,50,ButtonType.Small,"backgrounds/menu/solo.png")
    self.coop=Button.new(150,325,200,50,ButtonType.Small,"backgrounds/menu/coop.png")
    self.options=Button.new(150,400,250,50,ButtonType.Large,"backgrounds/menu/options.png")
    self.credits=Button.new(150,475,250,50,ButtonType.Large,"backgrounds/menu/credits.png")
    self.quit=Button.new(165,600,200,50,ButtonType.Small,"backgrounds/menu/quit.png")

    self.font = love.graphics.newFont(FontDirectory .. "font.ttf", 25)
    love.graphics.setFont(self.font)


    return self
end

function Menu:mousePressed(x, y, button)
	if not self.shouldQuit then
		if self.solo:isCliked(x,y) then
			self.timer=0
			self.enteringDone=false
			gameStateManager:changeState('ChoixTypeJeuSolo')
		end


		if self.coop:isCliked(x,y) then
			self.timer=0
			self.enteringDone=false			
			gameStateManager:changeState('ConnectToServer')
		end


		if self.options:isCliked(x,y) then
			self.timer=0
			self.enteringDone=false			
			gameStateManager:changeState('Options')
		end

		if self.credits:isCliked(x,y) then
			self.timer=0
			self.enteringDone=false			
			gameStateManager:changeState('Credits')
		end

		if self.quit:isCliked(x,y) then
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

function Menu:reset()
    self.font = love.graphics.newFont(FontDirectory .. "font.ttf", 25)
    love.graphics.setFont(self.font)
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
	love.graphics.draw(self.back,0,0)
	x, y = love.mouse.getPosition()



	-- rectangles :
	 if not self.shouldQuit then
	 	self.solo:draw(x,y,self.timer)
	 	self.coop:draw(x,y,self.timer)
	 	self.options:draw(x,y,self.timer)
	 	self.credits:draw(x,y,self.timer)
	 	self.quit:draw(x,y,self.timer)
	 else
	 	self.solo:draw(0,0,self.filter)
	 	self.coop:draw(0,0,self.filter)
	 	self.options:draw(0,0,self.filter)
	 	self.credits:draw(0,0,self.filter)
	 	self.quit:draw(0,0,self.filter)


	 	love.graphics.setColor(50, 50, 50, 120)
	 	love.graphics.rectangle("fill", 400, 300, 500, 350)
	 	love.graphics.setColor(255, 255, 255, 255)
	 	love.graphics.print("Are you sure about",450,320)
	 	love.graphics.print("quitting?",560,360)

	 	if x > 540 and x < 540+100 and y > 550 and y < 550+50 then
	 		love.graphics.setColor(150, 150, 150, 255)
	 	else
	 		love.graphics.setColor(50, 50, 50, 255)
	 	end
	 	love.graphics.rectangle("fill", 530, 550, 100, 50)
	 	love.graphics.setColor(255, 100,100, 255)
	 	love.graphics.print("Yes",550,555)
	 	if x > 640 and x < 640+100 and y > 550 and y < 550+50 then
	 		love.graphics.setColor(150, 150, 150, 255)
	 	else
	 		love.graphics.setColor(50, 50, 50, 255)
	 	end
	 	love.graphics.rectangle("fill", 660, 550, 100, 50)
	 	love.graphics.setColor(255, 255, 255, 255)
	 	love.graphics.print("No",675,555)

	 end


		

end

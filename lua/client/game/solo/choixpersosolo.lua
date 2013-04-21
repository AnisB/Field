--[[ 
This file is part of the Field project]]

ChoixPersoSolo = {}
ChoixPersoSolo.__index = ChoixPersoSolo
function ChoixPersoSolo.new(continuous)
    local self = {}
    setmetatable(self, ChoixPersoSolo)
    self.isRed=0
    self.mm = love.graphics.newImage(ImgDirectory .. "metalman.png")
    self.tm = love.graphics.newImage(ImgDirectory .. "themagnet.png")
    self.continuous=continuous
    return self
end

function ChoixPersoSolo:mousePressed(x, y, button)
	if x > 90 and x < 90+300 and y > 90 and y < 90+420 then
		self.isRed=1
	elseif x > 490 and x < 490+340 and y > 90 and y < 90+420 then
		self.isRed=2
	elseif x > 390 and x < 390+100 and y > 600 and y < 600+50 then
		if self.isRed~=0 then
			if self.isRed==1 then
				gameStateManager.state['ChoixNiveauSolo'] = ChoixNiveauSolo.new("metalman",self.continuous)
			elseif self.isRed==2 then

				gameStateManager.state['ChoixNiveauSolo'] = ChoixNiveauSolo.new("themagnet",self.continuous)
			end
			gameStateManager:changeState('ChoixNiveauSolo')
		end
	
	elseif x > 1050 and x < 1050+200 and y > 650 and y < 650+50 then
		gameStateManager:changeState("ChoixTypeJeuSolo")
	end
end

function ChoixPersoSolo:mouseReleased(x, y, button) end
function ChoixPersoSolo:keyPressed(key, unicode) end
function ChoixPersoSolo:keyReleased(key, unicode) end

function ChoixPersoSolo:joystickPressed(joystick, button)
end

function ChoixPersoSolo:joystickReleased(joystick, button)
end

function ChoixPersoSolo:update(dt) end


function ChoixPersoSolo:draw()
	local hover = false
	x, y = love.mouse.getPosition()

	-- background :
	love.graphics.draw(gameStateManager.state['ConnectToServer'].bg, 0, 0)

	-- rectangles :
	if x > 90 and x < 90+300 and y > 90 and y < 90+420 then
		love.graphics.setColor(150, 150, 150, 255)
		hover = true
	else
		love.graphics.setColor(50, 50, 50, 255)
	end
	love.graphics.rectangle("fill", 90, 90, 300, 420)

	if x > 490 and x < 490+340 and y > 90 and y < 90+420 then
		love.graphics.setColor(150, 150, 150, 255)
		hover = true
	else
		love.graphics.setColor(50, 50, 50, 255)
	end
	love.graphics.rectangle("fill", 490, 90, 340, 420)

	if self.isRed~=0 then
		if x > 390 and x < 390+100 and y > 600 and y < 600+50 then
			love.graphics.setColor(150, 150, 150, 255)
			hover = true
		else
			love.graphics.setColor(50, 50, 50, 255)
		end
	else
			love.graphics.setColor(50, 50, 50, 255)
	end
	love.graphics.rectangle("fill", 390, 600, 100, 50)

	-- text :
	love.graphics.setColor(255, 255, 255, 255)

	love.graphics.draw(self.mm, 100, 100)
	love.graphics.draw(self.tm, 500, 100)

	if self.isRed==1 then
		love.graphics.setColor(255, 0, 0, 255)
	else
		love.graphics.setColor(255, 255, 255, 255)
	end
	love.graphics.print("metalman", 150, 450)

	if self.isRed==2 then
		love.graphics.setColor(255, 0, 0, 255)
	else
		love.graphics.setColor(255, 255, 255, 255)
	end
	love.graphics.print("the magnet", 570, 450)

	if self.isRed==0 then
		love.graphics.setColor(150, 150, 150, 255)
	else
		love.graphics.setColor(255, 255, 255, 255)
	end
	love.graphics.print("PLAY", 400, 600)

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

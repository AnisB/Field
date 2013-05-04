--[[ 
This file is part of the Field project]]

ChoixPerso = {}
ChoixPerso.__index = ChoixPerso
function ChoixPerso:new()
    local self = {}
    setmetatable(self, ChoixPerso)
    self.err = false
    self.isRed=0
    self.mm = love.graphics.newImage(ImgDirectory .. "metalman.png")
    self.tm = love.graphics.newImage(ImgDirectory .. "themagnet.png")
    return self
end

function ChoixPerso:mousePressed(x, y, button)
	if x > 90 and x < 90+300 and y > 90 and y < 90+420 then
		serveur:send({type="choixPerso", confirm=false, perso="metalman"})
		self.isRed=1
	elseif x > 490 and x < 490+340 and y > 90 and y < 90+420 then
		serveur:send({type="choixPerso", confirm=false, perso="themagnet"})
		self.isRed=2
	elseif x > 390 and x < 390+100 and y > 600 and y < 600+50 then
		serveur:send({type="choixPerso", confirm=true})
	end
end

function ChoixPerso:mouseReleased(x, y, button) end
function ChoixPerso:keyPressed(key, unicode) end
function ChoixPerso:keyReleased(key, unicode) end

function ChoixPerso:joystickPressed(joystick, button)
end

function ChoixPerso:joystickReleased(joystick, button)
end

function ChoixPerso:update(dt) end

function ChoixPerso:onMessage(msg)
	if msg.type == "choixPerso" then
		if msg.player == monde.cookie then
			monde.moi = {}
			monde.moi.perso = msg.perso
			monde[msg.perso] = monde.moi
		else
			monde.lui = {}
			monde.lui.perso = msg.perso
			monde.lui.cookie = msg.player
			monde[msg.perso] = monde.lui
		end
	elseif msg.type == "choixPersoFini" then
		if monde.typeJeu == "arcade" then
			gameStateManager:changeState('ChoixNiveau')
		end
	elseif msg.type == "err" then
		self.err = true
	else
		print("[ChoixPerso] wrong type :", table2.tostring(msg))
	end
end

function ChoixPerso:draw()
	local hover = false
	x, y = love.mouse.getPosition()

	-- background :
	-- love.graphics.draw(gameStateManager.state['ConnectToServer'].bg, 0, 0)

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

	if x > 390 and x < 390+100 and y > 600 and y < 600+50 then
		love.graphics.setColor(150, 150, 150, 255)
		hover = true
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

	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.print("PLAY", 400, 600)

	if self.err then
		love.graphics.setColor(255, 0, 0, 255)
		love.graphics.print("err", 400, 650)
		love.graphics.setColor(255, 255, 255, 255)
	end

	-- cursor :
	if hover then
		love.mouse.setVisible(false)
		love.graphics.draw(gameStateManager.state['ConnectToServer'].handcursor, x-17, y-17)
	else
		love.mouse.setVisible(true)
	end
end

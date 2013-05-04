--[[ 
This file is part of the Field project]]

ChoixPerso = {}
ChoixPerso.__index = ChoixPerso
function ChoixPerso:new()
    local self = {}
    setmetatable(self, ChoixPerso)
    self.err = false
    self.mm = love.graphics.newImage("backgrounds/choixperso/metalmanimg.png")
    self.tm = love.graphics.newImage("backgrounds/choixperso/magnetimg.png")

    self.back= love.graphics.newImage("backgrounds/choixperso/back.png")
    self.themagnet = Button.newDec(200,200,420,300,ButtonType.Perso,"backgrounds/choixperso/magnet.png",0,300)
    self.metalman= Button.newDec(670,200,420,300,ButtonType.Perso,"backgrounds/choixperso/metalman.png",0,300)
    self.play= Button.new(550,640,200,50,ButtonType.Small,"backgrounds/choixperso/play.png")
    self.returnB= Button.newDec(1000,640,250,50,ButtonType.Large,"backgrounds/choixperso/return.png",10,0)

    self.play:setEnable(false)
    self.continuous=continuous

    self.selected=-1

    self.enteringDone=false
    self.timer=0
    return self
end

function ChoixPerso:mousePressed(x, y, button)
	if self.metalman:isCliked(x,y) then
		serveur:send({type="choixPerso", confirm=false, perso="metalman"})
		self.isRed=1
		self.metalman:setSelected(true)
		self.themagnet:setSelected(false)
		self.play:setEnable(true)
	elseif self.themagnet:isCliked(x,y) then
		serveur:send({type="choixPerso", confirm=false, perso="themagnet"})
		self.isRed=2
		self.themagnet:setSelected(true)
		self.metalman:setSelected(false)
		self.play:setEnable(true)
	elseif self.play:isCliked(x,y) then
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

function ChoixPerso:update(dt) 
		if not self.enteringDone then
		self.timer =self.timer +dt
		if self.timer>=1 then
			self.timer=1
			self.enteringDone=true
		end
	end
end

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
	love.graphics.setColor(255,255,255,255*self.timer)
	love.graphics.draw(self.back, 0, 0)

	self.themagnet:draw(x,y,self.timer)
    self.metalman:draw(x,y,self.timer)
    self.play:draw(x,y,self.timer)
    self.returnB:draw(x,y,self.timer)

	love.graphics.setColor(255,255,255,255*self.timer)
    love.graphics.draw(self.tm,300,210)
    love.graphics.draw(self.mm,710,210)

	if self.err then
		love.graphics.setColor(255, 0, 0, 255)
		love.graphics.print("err", 400, 650)
		love.graphics.setColor(255, 255, 255, 255)
	end

end

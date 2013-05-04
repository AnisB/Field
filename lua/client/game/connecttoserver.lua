--[[ 
This file is part of the Field project]]


ConnectToServer = {}
ConnectToServer.__index = ConnectToServer
function ConnectToServer:new()
    local self = {}
    setmetatable(self, ConnectToServer)
    self.timer=0
    self.font = love.graphics.newFont(FontDirectory .. "font.ttf", 25)
    love.graphics.setFont(self.font)

    self.back = love.graphics.newImage("backgrounds/connect/back.png")

    self.ipaddrlabel=love.graphics.newImage("backgrounds/connect/serverip.png")
    self.login=love.graphics.newImage("backgrounds/connect/login.png")
    self.pass=love.graphics.newImage("backgrounds/connect/pass.png")

    self.play= Button.new(550,640,200,50,ButtonType.Small,"backgrounds/choixniveau/play.png")
    self.returnB= Button.newDec(1000,640,250,50,ButtonType.Large,"backgrounds/choixniveau/return.png",10,0)
    self.ipaddr = "127.0.0.1"
    self.pseudo = ""
    self.focused = "ipaddr"
    self.discovered = false
    self.waiting = false
    return self
end

function ConnectToServer:mousePressed(x, y, button)
	if x > 50 and x < 650 and y > 100 and y < 150 then
		self.focused = "ipaddr"
	elseif x > 50 and x < 650 and y > 200 and y < 250 then
		self.focused = "pseudo"
	elseif self.play:isCliked(x,y) then
		if self.waiting==false then
			self.waiting = true
			self:connect()
		end
	end
	if self.returnB:isCliked(x,y) then
		gameStateManager:changeState('Menu')
		love.mouse.setVisible(true)
	end

end

function ConnectToServer:mouseReleased(x, y, button)
end


function ConnectToServer:keyPressed(key, unicode)

if self.waiting==false then
	if key == "return" then
		if self.waiting==false then
			self.waiting = true
			self:connect()
		end
	elseif self.focused == "ipaddr" then
		if key == "backspace" then
			self.ipaddr = string.sub(self.ipaddr, 0, -2)
		elseif key == "tab" then
			self.focused="pseudo"
		else
			local car
			if key == "a" or key == "1" then car = "1"
			elseif key == "z" or key == "2" then car = "2"
			elseif key == "e" or key == "3" then car = "3"
			elseif key == "r" or key == "4" then car = "4"
			elseif key == "t" or key == "5" then car = "5"
			elseif key == "y" or key == "6" then car = "6"
			elseif key == "u" or key == "7" then car = "7"
			elseif key == "i" or key == "8" then car = "8"
			elseif key == "o" or key == "9" then car = "9"
			elseif key == "p" or key == "0" then car = "0"
			elseif key == "." or key == ";" then car = "."
			else return end
			self.ipaddr = self.ipaddr .. car
		end
	else
		if key=="backspace" then
			self.pseudo = string.sub(self.pseudo, 0, -2)
			elseif key == "tab" then
				self.focused="ipaddr"
			elseif key == "lshift" or  key == "rshift" or  key == "rctrl"  or  key == "lctrl"  then
		else
			self.pseudo = self.pseudo .. key
		end
	end
end
end

function ConnectToServer:keyReleased(key, unicode) end

function ConnectToServer:joystickPressed(joystick, button)
end

function ConnectToServer:joystickReleased(joystick, button)
end

function ConnectToServer:update(dt)
	discoveryListener:update(dt)
	self.timer = self.timer + dt
end

function ConnectToServer:connect()
	-- lube :
    conn = lube.tcpClient()
	conn.handshake = "hello"
	serveur = common.instance(Client, conn) -- oui, le serveur est un "client" :)

	local okay = conn:connect(self.ipaddr, 3410, true)
	print("Connection to server =", okay)
	if okay then
		conn.callbacks.recv = rcvCallback
		print("CONNECTED !!")
		monde.cookie = self.pseudo
		serveur:send({type= "login", pseudo=self.pseudo, cookie=self.pseudo})
	end
	-- /lube
end

function ConnectToServer:onMessage(msg)
	if msg.type == "attenteFinie" then
		gameStateManager:changeState('ChoixTypeJeu') -- WaitingForDistant
	elseif msg.type == "discovery" then
		if self.discovered == true then
			return
		end
		self.ipaddr = msg.ip
		self.discovered = true
		print('IP DISCOVER =', msg.ip)
	else
		print("[ConnectToServer] wrong type :", table2.tostring(msg))
	end
end

function ConnectToServer:draw()
	x, y = love.mouse.getPosition()



	-- background :
	love.graphics.draw(self.back, 0, 0)


    love.graphics.draw(self.ipaddrlabel,90,200)
    love.graphics.draw(self.login,90,300)
    love.graphics.draw(self.pass,90,400)
	-- rectangles :
	if self.focused == "ipaddr" then
		love.graphics.setColor(150, 150, 150, 255)
	else
		love.graphics.setColor(50, 50, 50, 255)
	end
	love.graphics.rectangle("fill", 450, 205, 250, 35)

	if self.focused == "pseudo" then
		love.graphics.setColor(150, 150, 150, 255)
	else
		love.graphics.setColor(50, 50, 50, 255)
	end
	love.graphics.rectangle("fill", 450, 305, 250, 35)
	

	-- text :
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.print(self.ipaddr, 470, 205)
	love.graphics.print(self.pseudo, 470, 305)
	if self.waiting then
		love.graphics.setColor(255, 0, 0, 255)
		local nb_dots = self.timer % 3
		local wait = "waiting"
		while nb_dots > 0 do
			wait = wait .. "."
			nb_dots = nb_dots - 1
		end
		love.graphics.print(wait, 400, 400)
		love.graphics.setColor(255, 255, 255, 255)
	end

	self.play:draw(x,y,1)
	self.returnB:draw(x,y,1)

end


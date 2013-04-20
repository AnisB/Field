--[[ 
This file is part of the Field project]]


ConnectToServer = {}
ConnectToServer.__index = ConnectToServer
function ConnectToServer:new()
    local self = {}
    setmetatable(self, ConnectToServer)
    self.timer=0
    self.font = love.graphics.newFont(FontDirectory .. "font.ttf", 30)
    love.graphics.setFont(self.font)
    self.bg = love.graphics.newImage(ImgDirectory .. "fondgui.png")
    self.handcursor = love.graphics.newImage(ImgDirectory .. "handcursor.png")
    self.ipaddr = "127.0.0.1"
    self.pseudo = "luc"
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
	elseif x > 198 and x < 198+100 and y > 600 and y < 600+50 then
		if self.waiting==false then
			self.waiting = true
			self:connect()
		end
	end
	if x > 400 and x < 400+100 and y > 600 and y < 600+50 then
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
	local hover = false
	x, y = love.mouse.getPosition()
	if (x > 50 and x < 650 and y > 100 and y < 150) or
	   (x > 50 and x < 650 and y > 200 and y < 250) then
		hover = true
	end

	-- background :
	love.graphics.draw(self.bg, 0, 0)

	-- rectangles :
	if self.focused == "ipaddr" then
		love.graphics.setColor(150, 150, 150, 255)
	else
		love.graphics.setColor(50, 50, 50, 255)
	end
	love.graphics.rectangle("fill", 370, 105, 250, 35)

	if self.focused == "pseudo" then
		love.graphics.setColor(150, 150, 150, 255)
	else
		love.graphics.setColor(50, 50, 50, 255)
	end
	love.graphics.rectangle("fill", 370, 205, 250, 35)
	

	-- text :
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.print("IP du serveur :", 100, 100)
	love.graphics.print(self.ipaddr, 380, 100)
	love.graphics.print("Pseudo :", 100, 200)
	love.graphics.print(self.pseudo, 380, 200)
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

	-- bouton play :
	if x > 198 and x < 198+100 and y > 600 and y < 600+50 then
		love.graphics.setColor(150, 150, 150, 255)
		hover = true
	else
		love.graphics.setColor(50, 50, 50, 255)
	end
	love.graphics.rectangle("fill", 198, 600, 100, 50)
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.print("PLAY", 198+10, 600)

	-- bouton play :
	if x > 400 and x < 400+100 and y > 600 and y < 600+50 then
		love.graphics.setColor(150, 150, 150, 255)
		hover = true
	else
		love.graphics.setColor(50, 50, 50, 255)
	end
	love.graphics.rectangle("fill", 400, 600, 150, 50)
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.print("Return", 400+10, 600)


	-- cursor :
	if hover then
		love.mouse.setVisible(false)
		love.graphics.draw(self.handcursor, x-17, y-17)
	else
		love.mouse.setVisible(true)
	end
end


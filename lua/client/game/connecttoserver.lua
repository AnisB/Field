--[[ 
This file is part of the Field project]]


ConnectToServer = {}
ConnectToServer.__index = ConnectToServer
function ConnectToServer:new()
    local self = {}
    setmetatable(self, ConnectToServer)
    self.timer=0
    --self.police = love.graphics.newFont("/home/fred/trucs/anyfont.ttf", 20)
    --love.graphics.setFont(self.police)
    self.ipaddr = "127.0.0.1"
    self.pseudo = "luc"
    self.focused = "ipaddr"
    self.waiting = false
    return self
end


function ConnectToServer:mousePressed(x, y, button)
	if x > 200 and x < 250 and y > 200 and y < 250 then
		self.focused = "ipaddr"
	else
		self.focused = "pseudo"
	end
end

function ConnectToServer:mouseReleased(x, y, button)
end


function ConnectToServer:keyPressed(key, unicode)
	if unicode == 13 then
		self.waiting = true
		self:connect()
	elseif self.focused == "ipaddr" then
		if unicode == 8 then
			self.ipaddr = string.sub(self.ipaddr, 0, -2)
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
		if unicode == 8 then
			self.pseudo = string.sub(self.pseudo, 0, -2)
		else
			self.pseudo = self.pseudo .. key
		end
	end
end

function ConnectToServer:keyReleased(key, unicode) end

function ConnectToServer:update(dt)
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
	else
		print("[ConnectToServer] wrong type :", table2.tostring(msg))
	end
end

function ConnectToServer:draw()
	love.graphics.print("Entrez l'adresse IP du serveur si vous y arrivez :", 100, 100)
	love.graphics.print(self.ipaddr, 200, 200)
	love.graphics.print(self.pseudo, 200, 300)
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
end


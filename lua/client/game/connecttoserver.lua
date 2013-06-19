--[[ 
This file is part of the Field project]]


ConnectToServer = {}
ConnectToServer.__index = ConnectToServer

require("game.ui.textfield")
function ConnectToServer:new()
    local self = {}
    setmetatable(self, ConnectToServer)

    self.font = love.graphics.newFont(FontDirectory .. "font.ttf", 25)
    love.graphics.setFont(self.font)

    self.timer=0

    self.commonBackground = CommonBackground.new()    
    self.ipaddrlabel=love.graphics.newImage("backgrounds/connect/serverip.png")
    self.login=love.graphics.newImage("backgrounds/connect/login.png")
    self.pass=love.graphics.newImage("backgrounds/connect/pass.png")

    self.play= Button.new(550,640,200,50,"backgrounds/choixniveau/play.png")
    self.returnB= Button.new(1000,640,250,50, "backgrounds/choixniveau/return.png")

    self.ipaddrfield = TextField.new( 275,355, 200, 35,"127.0.0.1", TextField.Types.IP)
    self.pseudofield = TextField.new( 275, 430, 200, 35,"Player", TextField.Types.Text)
    self.ipaddr = "127.0.0.1"
    self.pseudo = ""
    self.focused = "ipaddr"
    self.discovered = false
    self.waiting = false


    self.selection = {
        self.ipaddrfield,
        self.pseudofield,
        self.play,
        self.returnB
    }
    self.selected = 1
    self.ipaddrfield:setSelected(true)

    return self
end

function ConnectToServer:mousePressed(x, y, button)

end


function ConnectToServer:reset()
	self.waiting = false
	self.discovered = false
end

function ConnectToServer:mouseReleased(x, y, button)
end


function ConnectToServer:keyPressed(key, unicode)
	if self.waiting==false then
		if key == "return" then
			if self.play.selected then
				if self.waiting==false then
					self.waiting = true
					self:connect()
				end
	     	elseif self.returnB.selected then
			     	-- Cancel connection here
			     	gameStateManager:changeState('Menu')
			end
		elseif key =="tab" or key =="down" then
			self:incrementSelection()	
	    elseif key =="up" then
	    	self:decrementSelection()
	    else
	    	if self.selection[self.selected].className == "TextField" then
	    		self.selection[self.selected]:keyPressed(key,unicode)
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
	self.commonBackground:update(dt)
	discoveryListener:update(dt)
	self.timer = self.timer + dt
end


function ConnectToServer:incrementSelection()
	self.selection[self.selected]:setSelected(false)
	if self.selected == #self.selection then
		self.selected = 0
	end
	self.selected = self.selected + 1
	self.selection[self.selected]:setSelected(true)
end

function ConnectToServer:decrementSelection()
	self.selection[self.selected]:setSelected(false)
		if self.selected == 1 then
		self.selected = #self.selection + 1
	end
	self.selected = self.selected - 1
	self.selection[self.selected]:setSelected(true)
end



function ConnectToServer:connect()
	-- lube :
    conn = lube.tcpClient()
	conn.handshake = "hello"
	serveur = common.instance(Client, conn) -- oui, le serveur est un "client" :)

	print(self.ipaddrfield.text)
	local okay = conn:connect(self.ipaddrfield.text, 3410, true)
	print("Connection to server =", okay)
	if okay then
		conn.callbacks.recv = rcvCallback
		print("CONNECTED !!")
		monde.cookie = self.pseudofield.text
		serveur:send({type= "login", pseudo=self.pseudofield.text, cookie=self.pseudofield.text})
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

	-- background :
	self.commonBackground:draw(1)

    love.graphics.draw(self.ipaddrlabel,40,350)
    love.graphics.draw(self.login,40,425)
    love.graphics.draw(self.pass,40,500)

	-- rectangles :
	self.ipaddrfield:draw(1)
	self.pseudofield:draw(1)
	-- text :
	if self.waiting then
		love.graphics.setColor(255, 0, 0, 255)
		local nb_dots = self.timer % 3
		local wait = "waiting"
		while nb_dots > 0 do
			wait = wait .. "."
			nb_dots = nb_dots - 1
		end
		love.graphics.print(wait, 500, 600)
		love.graphics.setColor(255, 255, 255, 255)
	end

	self.play:draw(1)
	self.returnB:draw(1)

end


--[[ 
This file is part of the Field project]]

ChoixPerso = {}
ChoixPerso.__index = ChoixPerso
function ChoixPerso:new()
    local self = {}
    setmetatable(self, ChoixPerso)
    self.err = {}

    self.mm = BasicAnim.new("standingmm",true,0.2,6)
    self.tm = BasicAnim.new("standingtm",true,0.2,6)

    self.background = CommonBackground.new(true)

    self.themagnet = ButtonPerso.new(450,200,"backgrounds/choixperso/magnet.png")
    self.metalman = ButtonPerso.new(800,200,"backgrounds/choixperso/metalman.png")
    self.play = Button.new(125,400,200,50,   "backgrounds/choixperso/play.png")
    self.returnB = Button.newDec(100,540,250,50, "backgrounds/choixperso/return.png",10,0)

    self.play:setEnable(false)
    self.continuous=continuous

    self.selectedPerso=-1

    self.enteringDone=false
    self.timer=0

    self.selection = {
        self.play,
        self.themagnet,
        self.metalman,
        self.returnB
    }
    self.selected = 2
    self.themagnet:setSelected(true)



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

function ChoixPerso:mouseReleased(x, y, button) 
end

function ChoixPerso:keyPressed(key, unicode)
	if key == 'right' or key =='tab' then
		self:incrementSelection()
	elseif key =='left' then
		self:decrementSelection()
	elseif key == 'down' then
		self:forceReturn()
	elseif key == 'up' then
		self:forcePlay()
	end			

	if key == "return" then
		if self.metalman.selected then
			serveur:send({type="choixPerso", confirm=false, perso="metalman"})
			self.selectedPerso=1
			self.metalman:setFocused(true)
			self.themagnet:setFocused(false)
			self.play:setEnable(true)
			self:forcePlay()
	    elseif self.themagnet.selected  then
	    	self.selectedPerso=2
	    	self.themagnet:setFocused(true)
	    	self.metalman:setFocused(false)
	    	self.play:setEnable(true)
			self:forcePlay()
			serveur:send({type="choixPerso", confirm=false, perso="themagnet"})
	    elseif self.play.selected  then
	    	serveur:send({type="choixPerso", confirm=true})
			self.enteringDone=false
		end
	elseif self.returnB.selected  then
	
	end
	-- end
end
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
		self.err.enabled = true
		self.err.content=msg.content
	else
		print("[ChoixPerso] wrong type :", table2.tostring(msg))
	end
end


function ChoixPerso:incrementSelection()
	self.selection[self.selected]:setSelected(false)
	if self.selected == #self.selection then
		self.selected = 0
	end
	self.selected = self.selected + 1
	self.selection[self.selected]:setSelected(true)
end

function ChoixPerso:decrementSelection()
	self.selection[self.selected]:setSelected(false)
		if self.selected == 1 then
		self.selected = #self.selection + 1
	end
	self.selected = self.selected - 1
	self.selection[self.selected]:setSelected(true)
end

function ChoixPerso:forcePlay()
	self.selection[self.selected]:setSelected(false)
	self.selected = 1
	self.play:setSelected(true)
end

function ChoixPerso:forceReturn()
	self.selection[self.selected]:setSelected(false)
		if self.selected == 1 then
		self.selected = #self.selection + 1
	end
	self.selected = #self.selection
	self.returnB:setSelected(true)
end




function ChoixPerso:draw()

	-- background :

	-- background :
	self.background:draw(self.timer)
	self.themagnet:draw(self.timer)
    self.metalman:draw(self.timer)
    self.play:draw(self.timer)
    self.returnB:draw(self.timer)

	love.graphics.setColor(255,255,255,255*self.timer)
    love.graphics.draw(self.tm:getSprite(),500,210)
    love.graphics.draw(self.mm:getSprite(),1100,210,0,-1,1)


	if self.err.enabled==true then
		love.graphics.setColor(255, 0, 0, 255)
		love.graphics.print(self.err.content, 200, 600)
		love.graphics.setColor(255, 255, 255, 255)
	end

end

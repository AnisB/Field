--[[ 
This file is part of the Field project]]

ChoixPerso = {}
ChoixPerso.__index = ChoixPerso
function ChoixPerso:new()
    local self = {}
    setmetatable(self, ChoixPerso)

    self.inputManager = MenuInputManager.new(self)
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
    self.selectedPersoDistant=-1

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

function ChoixPerso:reset()
    self.selectedPerso=-1
    self.selectedPersoDistant=-1
    self.enteringDone=false
    self.timer=0
    self.selection[self.selected].selected = false
    self.selected = 2
    self.selection[self.selected].selected = true
    self.play:setEnable(false)
    self.themagnet:setFocusedSecond(false)
    self.metalman:setFocusedSecond(false)
    self.themagnet:setFocused(false)
    self.metalman:setFocused(false)

end

function ChoixPerso:mousePressed(x, y, button)

end

function ChoixPerso:mouseReleased(x, y, button) 
end
function ChoixPerso:keyPressed(key, unicode)
    self.inputManager:keyPressed(key,unicode,true)
end
function ChoixPerso:keyReleased(key, unicode)
    self.inputManager:keyReleased(key,unicode)
end

function ChoixPerso:joystickPressed(key, unicode)
    self.inputManager:joystickPressed(key,unicode)
end


function ChoixPerso:joystickReleased(key, unicode)
    self.inputManager:joystickReleased(key,unicode)
end


function ChoixPerso:sendPressedKey(key, unicode)
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
			self:selectPersoOrder("metalman")
	    elseif self.themagnet.selected  then
	    	self:selectPersoOrder("themagnet")
	    elseif self.play.selected  then
	    	self:playOrder()
    	elseif self.returnB.selected  then
    		self:backChoixTypeJeu()
    	end
	end
end

function ChoixPerso:selectPersoOrder(perso)
	serveur:send({type="syncroChoix", pck ={confirm=false, current = "ChoixPerso", perso=perso}})
end
function ChoixPerso:selectHisPerso(perso)
	if perso =="metalman" then
		self.selectedPersoDistant=2
		self.themagnet:setFocusedSecond(false)
		self.metalman:setFocusedSecond(true)
    elseif perso =="themagnet" then
    	self.selectedPersoDistant=1
		self.themagnet:setFocusedSecond(true)
		self.metalman:setFocusedSecond(false)
    end
end 

function ChoixPerso:selectMyPerso(perso)
	if perso =="metalman" then
    	self.selectedPerso=2
		self.metalman:setFocused(true)
		self.themagnet:setFocused(false)
    elseif perso =="themagnet" then
    	self.selectedPerso=1
		self.themagnet:setFocused(true)
		self.metalman:setFocused(false)
    end

end 


function ChoixPerso:testPlay()
	if self.selectedPersoDistant>=1 and self.selectedPerso>=1 then
		self.play:setEnable(true)
		self:forcePlay()
	end
end 

function ChoixPerso:playOrder()
	serveur:send({type="syncro", pck ={next="ChoixNiveau", current ="ChoixPerso"}})
	self.enteringDone=false
end 

function ChoixPerso:backChoixTypeJeu()
	print("GOING BACK CLIENT SOURCE")
	serveur:send({type="syncro", pck={next="ChoixTypeJeu", current="ChoixPerso"}})
end 

function ChoixPerso:update(dt) 
	self.inputManager:update()
		if not self.enteringDone then
		self.timer =self.timer +dt
		if self.timer>=1 then
			self.timer=1
			self.enteringDone=true
		end
	end
end

function ChoixPerso:onMessage(msg)
	if msg.type == "syncroChoix" then
		if msg.pck.player == monde.cookie then
			self:setMySelection(msg.pck)
		else
			self:setHisSelection(msg.pck)
		end
		self:testPlay()

	elseif msg.type == "syncro" then
		if msg.pck.next =="ChoixNiveau" then
			if monde.typeJeu == "arcade" then
				gameStateManager:changeState('ChoixNiveau')
				self.enteringDone=false
			elseif monde.typeJeu == "histoire" then
				gameStateManager:changeState('ChoixNiveau')
				self.enteringDone=false
			else
				assert(false)
			end
		elseif msg.pck.next == "ChoixTypeJeu" then
	print("GOING BACK CLIENT APPLY")

			self:reset()
			gameStateManager:changeState('ChoixTypeJeu')
		end				
	elseif msg.type == "error" then
		self.err.enabled = true
		self.err.content=msg.pck.content
	else
		print("[ChoixPerso] wrong type :", table2.tostring(msg))
	end
end

function ChoixPerso:setMySelection(pck)
	monde.moi = {}
	monde.moi.perso = pck.perso
	monde[pck.perso] = monde.moi
	self:selectMyPerso(pck.perso)
end

function ChoixPerso:setHisSelection(pck)
	monde.lui = {}
	monde.lui.perso = pck.perso
	monde.lui.cookie = pck.player
	monde[pck.perso] = monde.lui
	self:selectHisPerso(pck.perso)
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

--[[ 
This file is part of the Field project]]

require("game.ui.backgroundperso")
require("game.ui.buttonperso")
ChoixPersoSolo = {}
ChoixPersoSolo.__index = ChoixPersoSolo
function ChoixPersoSolo.new(continuous)
    local self = {}
    setmetatable(self, ChoixPersoSolo)
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

function ChoixPersoSolo:mousePressed(x, y, button)
end

function ChoixPersoSolo:mouseReleased(x, y, button) 
end
function ChoixPersoSolo:keyPressed(key, unicode)
	if key == 'right' or key =='tab' then
		self:incrementSelection()
	elseif key =='left' then
		self:decrementSelection()
	elseif key == 'down' then
		self:forceReturn()
	elseif key == 'up' then
		self:forcePlay()
	elseif key == "escape" then
		gameStateManager:changeState('ChoixTypeJeuSolo')
	end			

	if key == "return" then
		if self.metalman.selected then
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
	    elseif self.play.selected  then
	    	if self.selectedPerso~=-1 then
	    		if self.selectedPerso==1 then
	    			gameStateManager.state['ChoixNiveauSolo'] = ChoixNiveauSolo.new("metalman",self.continuous)
	    		elseif self.selectedPerso==2 then
	    			gameStateManager.state['ChoixNiveauSolo'] = ChoixNiveauSolo.new("themagnet",self.continuous)
	    		end
	    		gameStateManager:changeState('ChoixNiveauSolo')
	    		self.enteringDone=false
	    	end
		elseif self.returnB.selected  then
			gameStateManager:changeState("ChoixTypeJeuSolo")
			self.enteringDone=false		
		end
	end
end
function ChoixPersoSolo:keyReleased(key, unicode)
end

function ChoixPersoSolo:joystickPressed(joystick, button)
end

function ChoixPersoSolo:joystickReleased(joystick, button)
end

function ChoixPersoSolo:update(dt)
	self.background:update(dt) 
	self.tm:update(dt)
	self.mm:update(dt)
		if not self.enteringDone then
		self.timer =self.timer +dt
		if self.timer>=1 then
			self.timer=1
			self.enteringDone=true
		end
	end
end

function ChoixPersoSolo:incrementSelection()
	self.selection[self.selected]:setSelected(false)
	if self.selected == #self.selection then
		self.selected = 0
	end
	self.selected = self.selected + 1
	self.selection[self.selected]:setSelected(true)
end

function ChoixPersoSolo:decrementSelection()
	self.selection[self.selected]:setSelected(false)
		if self.selected == 1 then
		self.selected = #self.selection + 1
	end
	self.selected = self.selected - 1
	self.selection[self.selected]:setSelected(true)
end

function ChoixPersoSolo:forcePlay()
	self.selection[self.selected]:setSelected(false)
	self.selected = 1
	self.play:setSelected(true)
end

function ChoixPersoSolo:forceReturn()
	self.selection[self.selected]:setSelected(false)
		if self.selected == 1 then
		self.selected = #self.selection + 1
	end
	self.selected = #self.selection
	self.returnB:setSelected(true)
end


function ChoixPersoSolo:draw()

	-- background :
	self.background:draw(self.timer)
	self.themagnet:draw(self.timer)
    self.metalman:draw(self.timer)
    self.play:draw(self.timer)
    self.returnB:draw(self.timer)

	love.graphics.setColor(255,255,255,255*self.timer)
    love.graphics.draw(self.tm:getSprite(),500,210)
    love.graphics.draw(self.mm:getSprite(),1100,210,0,-1,1)

end

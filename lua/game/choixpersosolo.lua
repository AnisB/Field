--[[ 
This file is part of the Field project]]

require("ui.layout")

require("ui.buttonperso")

ChoixPersoSolo = {}
ChoixPersoSolo.__index = ChoixPersoSolo

function ChoixPersoSolo.new(continuous)
    local self = {}
    setmetatable(self, ChoixPersoSolo)

    self.mm = BasicAnim.new("standingmm",true,0.2,6)
    self.tm = BasicAnim.new("standingtm",true,0.2,6)

    local commonBackground = CommonBackground.new(true)

    local themagnet = ButtonPerso.new(450,200,"backgrounds/choixperso/magnet.png","themagnet")
    local metalman = ButtonPerso.new(800,200,"backgrounds/choixperso/metalman.png","metalman")
    local play = Button.new(125,400,200,50,   "backgrounds/choixperso/play.png", "play")
    local ret = Button.new(100,540,250,50, "backgrounds/choixperso/return.png", "ret")

    ret:decaler(10,0)
    self.layout = UILayout.new()

    self.layout:addDrawable(commonBackground)

    self.layout:addSelectable(themagnet)
    self.layout:addSelectable(metalman)
    self.layout:addSelectable(ret)
    self.layout:addSelectable(play)

    self.layout:Init()

    self.continuous=continuous

    self.selectedPerso=-1

    return self
end


function ChoixPersoSolo:keyPressed(key, player)
	self.layout:inputPressed(key, player)

    if key == InputType.START then
    	local name = self.layout:getSelectedName()
		if name =="ret" then
			s_gameStateManager:changeState('ChoixTypeJeuSolo')
		end
		if name =="themagnet" then
			self.selectedPerso=1
			self.layout:setFocused("themagnet",true)
			self.layout:setFocused("metalman",false)
			self.layout:Init()
		end
		if name =="metalman" then
			self.selectedPerso=2
			self.layout:setFocused("themagnet",false)
			self.layout:setFocused("metalman",true)
			self.layout:Init()
		end
		if name =="play" then
	    	if self.selectedPerso~=-1 then
	    		if self.selectedPerso==1 then
	    			s_gameStateManager.state['ChoixNiveauSolo'] = ChoixNiveauSolo.new("metalman",self.continuous)
	    		elseif self.selectedPerso==2 then
	    			s_gameStateManager.state['ChoixNiveauSolo'] = ChoixNiveauSolo.new("themagnet",self.continuous)
	    		end
	    		s_gameStateManager:changeState('ChoixNiveauSolo')
	    	end
		end
	end
end
function ChoixPersoSolo:keyReleased(key, unicode)
end

function ChoixPersoSolo:update(dt)
	self.layout:update(dt)
	self.tm:update(dt)
	self.mm:update(dt)
end

function ChoixPersoSolo:forcePlay()
	self.selection[self.selected]:setSelected(false)
	self.selected = 1
	self.play:setSelected(true)
end



function ChoixPersoSolo:draw(filter)

	self.layout:draw(filter)

	love.graphics.setColor(255,255,255,255*filter)
    love.graphics.draw(self.tm:getSprite(),500,210)
    love.graphics.draw(self.mm:getSprite(),1100,210,0,-1,1)

end

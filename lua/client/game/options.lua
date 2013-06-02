--[[ 
This file is part of the Field project]]

require("game.ui.button")
Options = {}
Options.__index = Options
function Options:new()
    local self = {}
    setmetatable(self, Options)
    self.enteringDone = false
    self.timer=0
    self.returnB=Button.new(1000,625,200,50,"backgrounds/options/return.png")
    self.audio=Button.newDec(100,300,200,50,"backgrounds/options/audio.png",-10,-10)
    self.video=Button.newDec(100,375,200,50,"backgrounds/options/video.png",-10,-10)
    self.gameplay=Button.newDec(100,425,200,50 ,"backgrounds/options/gameplay.png",20,20)
    self.commonBackground = CommonBackground.new()

    self.selection = {
        self.audio,
        self.video,
        self.gameplay,
        self.returnB
    }
    self.selected = 1
    self.audio:setSelected(true)

    return self
end

function Options:mousePressed(x, y, button)
end

function Options:mouseReleased(x, y, button) 
end

function Options:incrementSelection()
	self.selection[self.selected]:setSelected(false)
	if self.selected == #self.selection then
		self.selected = 0
	end
	self.selected = self.selected + 1
	self.selection[self.selected]:setSelected(true)
end

function Options:decrementSelection()
	self.selection[self.selected]:setSelected(false)
		if self.selected == 1 then
		self.selected = #self.selection + 1
	end
	self.selected = self.selected - 1
	self.selection[self.selected]:setSelected(true)
end

function Options:keyPressed(key, unicode) 
	if key == 'down' or key =='tab' then
			self:incrementSelection()
		elseif key =='up' then
			self:decrementSelection()
	
		elseif key == "return" then
			self.timer=0
			self.enteringDone=false			
			gameStateManager:changeState('Menu')
		end
end



function Options:keyReleased(key, unicode) 
end

function Options:joystickPressed(joystick, button)
end

function Options:joystickReleased(joystick, button)
end

function Options:update(dt)
	self.commonBackground:update(dt) 
	if not self.enteringDone then
		self.timer =self.timer +dt
		if self.timer>=1 then
			self.timer=1
			self.enteringDone=true
		end
	end
end


function Options:draw()
	love.graphics.setColor(255,255,255,255*self.timer)
	x, y = love.mouse.getPosition()
	self.commonBackground:draw(self.timer) 

	self.audio:draw(self.timer)
	self.video:draw(self.timer)
	self.gameplay:draw(self.timer)
	self.returnB:draw(self.timer)





end

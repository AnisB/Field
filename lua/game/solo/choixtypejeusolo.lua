--[[ 
This file is part of the Field project]]

ChoixTypeJeuSolo = {}
ChoixTypeJeuSolo.__index = ChoixTypeJeuSolo
function ChoixTypeJeuSolo.new()
    local self = {}
    setmetatable(self, ChoixTypeJeuSolo)
    self.commonBackground = CommonBackground.new()
    self.story=Button.new(125,375,200,50, "backgrounds/solo/story.png")
    self.arcade=Button.new(100,425,250,50, "backgrounds/solo/arcade.png")
    self.returnB=Button.newDec(100,625,250,50, "backgrounds/solo/return.png",10,0)
    self.enteringDone=false
    self.timer=0

    self.inputManager =  MenuInputManager.new(self)

    self.selection = {
        self.story,
        self.arcade,
        self.returnB
    }
    self.selected = 1
    self.story:setSelected(true)

    return self
end

function ChoixTypeJeuSolo:mousePressed(x, y, button)
	if self.arcade:isCliked(x,y) then
		gameStateManager.state['ChoixPersoSolo'] = ChoixPersoSolo.new(false)
		gameStateManager:changeState('ChoixPersoSolo')
		self.enteringDone=false		
		self.timer=0
	elseif self.story:isCliked(x,y) then
		gameStateManager.state['ChoixPersoSolo'] = ChoixPersoSolo.new(true)
		gameStateManager:changeState('ChoixPersoSolo')
		self.timer=0
		self.enteringDone=false		
	elseif self.returnB:isCliked(x,y) then
		gameStateManager:resetAndChangeState('Menu')
		self.timer=0
		self.enteringDone=false
	end
end

function ChoixTypeJeuSolo:mouseReleased(x, y, button) 
end


function ChoixTypeJeuSolo:keyPressed(key, unicode)
    self.inputManager:keyPressed(key,unicode)
end
function ChoixTypeJeuSolo:keyReleased(key, unicode)
    self.inputManager:keyReleased(key,unicode)
end

function ChoixTypeJeuSolo:joystickPressed(key, unicode)
    self.inputManager:joystickPressed(key,unicode)
end


function ChoixTypeJeuSolo:joystickReleased(key, unicode)
    self.inputManager:joystickReleased(key,unicode)
end


function ChoixTypeJeuSolo:sendPressedKey(key, unicode) 
if key == 'down' or key =='tab' then
			self:incrementSelection()
		elseif key =='up' then
			self:decrementSelection()
		elseif key == "escape" then
			gameStateManager:changeState('Menu')
		elseif key == "return" then

			if self.story.selected then
				gameStateManager.state['ChoixPersoSolo'] = ChoixPersoSolo.new(true)
				gameStateManager:changeState('ChoixPersoSolo')
				self.timer=0
				self.enteringDone=false	
			end


			if self.arcade.selected then
				gameStateManager.state['ChoixPersoSolo'] = ChoixPersoSolo.new(false)
				gameStateManager:changeState('ChoixPersoSolo')
				self.enteringDone=false		
				self.timer=0
			end


			if self.returnB.selected then
				gameStateManager:resetAndChangeState('Menu')
				self.timer=0
				self.enteringDone=false
			end
		end
end

function ChoixTypeJeuSolo:incrementSelection()
	self.selection[self.selected]:setSelected(false)
	if self.selected == #self.selection then
		self.selected = 0
	end
	self.selected = self.selected + 1
	self.selection[self.selected]:setSelected(true)
end

function ChoixTypeJeuSolo:decrementSelection()
	self.selection[self.selected]:setSelected(false)
		if self.selected == 1 then
		self.selected = #self.selection + 1
	end
	self.selected = self.selected - 1
	self.selection[self.selected]:setSelected(true)
end

function ChoixTypeJeuSolo:update(dt) 
	self.inputManager:update()
	self.commonBackground:update(dt)
	if not self.enteringDone then
		self.timer =self.timer +dt
		if self.timer>=1 then
			self.timer=1
			self.enteringDone=true
		end
	end
end


function ChoixTypeJeuSolo:draw()

	-- background :
	self.commonBackground:draw(self.timer)

	self.story:draw(self.timer)
	self.arcade:draw(self.timer)
	self.returnB:draw(self.timer)
end

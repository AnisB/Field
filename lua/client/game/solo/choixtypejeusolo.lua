--[[ 
This file is part of the Field project]]

ChoixTypeJeuSolo = {}
ChoixTypeJeuSolo.__index = ChoixTypeJeuSolo
function ChoixTypeJeuSolo.new()
    local self = {}
    setmetatable(self, ChoixTypeJeuSolo)
    self.back=love.graphics.newImage("backgrounds/solo/back.png")
    self.story=Button.new(150,325,200,50,ButtonType.Large,"backgrounds/solo/story.png")
    self.arcade=Button.new(150,400,250,50,ButtonType.Large,"backgrounds/solo/arcade.png")
    self.returnB=Button.newDec(50,625,250,50,ButtonType.Large,"backgrounds/solo/return.png",10,0)
    self.enteringDone=false
    self.timer=0
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

function ChoixTypeJeuSolo:mouseReleased(x, y, button) end
function ChoixTypeJeuSolo:keyPressed(key, unicode) end
function ChoixTypeJeuSolo:keyReleased(key, unicode) end

function ChoixTypeJeuSolo:joystickPressed(joystick, button)
end

function ChoixTypeJeuSolo:joystickReleased(joystick, button)
end

function ChoixTypeJeuSolo:update(dt) 
	if not self.enteringDone then
		self.timer =self.timer +dt
		if self.timer>=1 then
			self.timer=1
			self.enteringDone=true
		end
	end
end


function ChoixTypeJeuSolo:draw()
	x, y = love.mouse.getPosition()

	-- background :
	love.graphics.draw(self.back, 0, 0)

	self.story:draw(x,y,self.timer)
	self.arcade:draw(x,y,self.timer)
	self.returnB:draw(x,y,self.timer)
end

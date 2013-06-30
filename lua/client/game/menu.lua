--[[ 
This file is part of the Field project]]


require("game.ui.button")
require("game.ui.commonbg")
require("game.ui.autoloopingbackground")
require("game.ui.confirmationpopup")
require("game.basicanim")

require("game.menuinputmanager")


Menu = {}
Menu.__index = Menu
function Menu.new()
    local self = {}
    setmetatable(self, Menu)
    self.err = false
    self.timer=0
    self.enteringDone=false
    self.shouldQuit=false
    self.filter=1

    self.commonBackground = CommonBackground.new()
    self.solo=Button.new(155,300,200,50,"backgrounds/menu/solo.png")
    self.coop=Button.new(155,355,200,50,"backgrounds/menu/coop.png")
    self.options=Button.new(125,410,250,50,"backgrounds/menu/options.png")
    self.credits=Button.new(125,465,250,50,"backgrounds/menu/credits.png")
    self.quit=Button.new(175,600,200,50,"backgrounds/menu/quit.png")
    self.confirmation = ConfirmationPopUp.new()

    self.inputManager = MenuInputManager.new(self) 
    self.font = love.graphics.newFont(FontDirectory .. "font.ttf", 25)
    love.graphics.setFont(self.font)

    self.selection = {
        self.solo,
        self.coop,
        self.options,
        self.credits,
        self.quit
    }
    self.selected = 1
    self.solo:setSelected(true)
    return self
end

function Menu:mousePressed(x, y, button)

end

function Menu:reset()
    self.font = love.graphics.newFont(FontDirectory .. "font.ttf", 25)
    love.graphics.setFont(self.font)
    self.enteringDone=false
    self.shouldQuit=false
    self.filter=1
end

function Menu:keyPressed(key, unicode)
    self.inputManager:keyPressed(key,unicode)
end
function Menu:keyReleased(key, unicode)
    self.inputManager:keyReleased(key,unicode)
end

function Menu:joystickPressed(key, unicode)
    self.inputManager:joystickPressed(key,unicode)
end


function Menu:joystickReleased(key, unicode)
    self.inputManager:joystickReleased(key,unicode)
end


function Menu:sendPressedKey(key, unicode) 
	if self.shouldQuit then
		self.confirmation:keyPressed(key,unicode)
	else
		if key == 'down' or key =='tab' then
			self:incrementSelection()
		elseif key =='up' then
			self:decrementSelection()
		elseif key == "escape" then
				self.shouldQuit=true
				self.filter=0.5
				self.confirmation:setEnable(true)
		elseif key == "return" then

			if self.solo.selected then
				self.timer=0
				self.enteringDone=false
				gameStateManager:changeState('ChoixTypeJeuSolo')
			end


			if self.coop.selected then
				self.timer=0
				self.enteringDone=false			
				gameStateManager:changeState('ConnectToServer')
			end


			if self.options.selected then
				self.timer=0
				self.enteringDone=false			
				gameStateManager:changeState('Options')
			end

			if self.credits.selected then
				self.timer=0
				self.enteringDone=false			
				gameStateManager:changeState('Credits')
			end

			if self.quit.selected then
				self.shouldQuit=true
				self.filter=0.5
				self.confirmation:setEnable(true)
			end
		end
	end
end

function Menu:sendReleasedKey(key, unicode) 
end

function Menu:mouseReleased(x, y, button) 
end



function Menu:incrementSelection()
	self.selection[self.selected]:setSelected(false)
	if self.selected == #self.selection then
		self.selected = 0
	end
	self.selected = self.selected + 1
	self.selection[self.selected]:setSelected(true)
end

function Menu:decrementSelection()
	self.selection[self.selected]:setSelected(false)
		if self.selected == 1 then
		self.selected = #self.selection + 1
	end
	self.selected = self.selected - 1
	self.selection[self.selected]:setSelected(true)
end

function Menu:update(dt) 
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


function Menu:draw()

	x, y = love.mouse.getPosition()

	local color = 255*self.timer*self.filter
	love.graphics.setColor(color,color,color,255)


	-- rectangles :
	 if not self.shouldQuit then
	 	self.commonBackground:draw(self.timer*self.filter)

	 	self.solo:draw(self.timer)
	 	self.coop:draw(self.timer)
	 	self.options:draw(self.timer)
	 	self.credits:draw(self.timer)
	 	self.quit:draw(self.timer)
	 else
	 	self.commonBackground:draw(self.timer*self.filter)

	 	self.solo:draw(self.filter)
	 	self.coop:draw(self.filter)
	 	self.options:draw(self.filter)
	 	self.credits:draw(self.filter)
	 	self.quit:draw(self.filter)
	 	self.confirmation:draw()

	 end


		

end

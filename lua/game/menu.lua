--[[ 
This file is part of the Field project]]


require("ui.button")
require("ui.layout")
require("ui.commonbg")
-- require("ui.autoloopingbackground")
require("ui.confirmationpopup")
-- require("game.basicanim")

-- require("game.menuinputmanager")


Menu = {}
Menu.__index = Menu
function Menu.new()
    local self = {}
    setmetatable(self, Menu)
    self.shouldQuit=false
    self.filter=1

    local commonBackground = CommonBackground.new()
    local solo=Button.new(155,300,200,50,"backgrounds/menu/solo.png", "solo")
    local coop=Button.new(155,355,200,50,"backgrounds/menu/coop.png", "coop")
    local options=Button.new(125,410,250,50,"backgrounds/menu/options.png","options")
    local credits=Button.new(125,465,250,50,"backgrounds/menu/credits.png", "credits")
    local quit=Button.new(175,600,200,50,"backgrounds/menu/quit.png", "quit")

    local confirmation = ConfirmationPopUp.new()

    self.layout = UILayout.new()

    self.layout:addDrawable(commonBackground)

    self.layout:addSelectable(solo)
    self.layout:addSelectable(coop)
    self.layout:addSelectable(options)
    self.layout:addSelectable(credits)
    self.layout:addSelectable(quit)

    self.layout:setPopUp(confirmation)
    self.layout:Init()

    return self
end

function Menu:mousePressed(x, y, button)

end

function Menu:reset()
    -- self.font = love.graphics.newFont(FontDirectory .. "font.ttf", 25)
    -- love.graphics.setFont(self.font)
    -- self.enteringDone=false
    -- self.shouldQuit=false
    -- self.filter=1
end

function Menu:keyPressed(key, unicode)
    self.layout:inputPressed(key)

    if key == InputType.START then
    	local name = self.layout:getSelectedName()
    	if( not self.layout.isPopUp) then
			if name =="solo" then
				s_gameStateManager:changeState('ChoixTypeJeuSolo')
			end


	-- 		if self.coop.selected then
	-- 			self.timer=0
	-- 			self.enteringDone=false			
	-- 			gameStateManager:changeState('ConnectToServer')
	-- 		end


	-- 		if self.options.selected then
	-- 			self.timer=0
	-- 			self.enteringDone=false			
	-- 			gameStateManager:changeState('Options')
	-- 		end

	-- 		if self.credits.selected then
	-- 			self.timer=0
	-- 			self.enteringDone=false			
	-- 			gameStateManager:changeState('Credits')
	-- 		end
			if name=="quit" then
				self.layout:enablePopUp(true)
			end
		else
            if name=="yes" then
                love.event.push("quit")
            elseif name =="no" then       
				self.layout:enablePopUp(false)
                s_gameStateManager:resetAndChangeState('Menu')
            end
		end
	end
end
function Menu:keyReleased(key, unicode)
    -- self.inputManager:keyReleased(key,unicode)
end

function Menu:sendPressedKey(key, unicode) 
	-- if self.shouldQuit then
	-- 	self.confirmation:keyPressed(key,unicode)
	-- else
	-- 	if key == 'down' or key =='tab' then
	-- 		self:incrementSelection()
	-- 	elseif key =='up' then
	-- 		self:decrementSelection()
	-- 	elseif key == "escape" then
	-- 			self.shouldQuit=true
	-- 			self.filter=0.5
	-- 			self.confirmation:setEnable(true)
	-- 	elseif key == "return" then

	-- 		if self.solo.selected then
	-- 			self.timer=0
	-- 			self.enteringDone=false
	-- 			gameStateManager:changeState('ChoixTypeJeuSolo')
	-- 		end


	-- 		if self.coop.selected then
	-- 			self.timer=0
	-- 			self.enteringDone=false			
	-- 			gameStateManager:changeState('ConnectToServer')
	-- 		end


	-- 		if self.options.selected then
	-- 			self.timer=0
	-- 			self.enteringDone=false			
	-- 			gameStateManager:changeState('Options')
	-- 		end

	-- 		if self.credits.selected then
	-- 			self.timer=0
	-- 			self.enteringDone=false			
	-- 			gameStateManager:changeState('Credits')
	-- 		end

	-- 		if self.quit.selected then
	-- 			self.shouldQuit=true
	-- 			self.filter=0.5
	-- 			self.confirmation:setEnable(true)
	-- 		end
	-- 	end
	-- end
end

function Menu:update(dt) 
	self.layout:update(dt)
end


function Menu:draw(filter)
	self.layout:draw(filter)		
end

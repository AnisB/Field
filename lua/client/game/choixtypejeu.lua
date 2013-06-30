--[[ 
This file is part of the Field project]]

ChoixTypeJeu = {}
ChoixTypeJeu.__index = ChoixTypeJeu
function ChoixTypeJeu:new()
    local self = {}
    setmetatable(self, ChoixTypeJeu)

    self.inputManager = MenuInputManager.new(self)
    self.commonBackground = CommonBackground.new()    
    self.story=Button.new(150,325,200,50, "backgrounds/solo/story.png")
    self.arcade=Button.new(150,400,250,50, "backgrounds/solo/arcade.png")
    self.returnB=Button.new(50,625,250,50, "backgrounds/solo/return.png")
    self.selection = {
        self.story,
        self.arcade,
        self.returnB
    }
    self.selected = 1
    self.story:setSelected(true)
    return self
end

function ChoixTypeJeu:mousePressed(x, y, button)
end

function ChoixTypeJeu:incrementSelection()
	self.selection[self.selected]:setSelected(false)
	if self.selected == #self.selection then
		self.selected = 0
	end
	self.selected = self.selected + 1
	self.selection[self.selected]:setSelected(true)
end

function ChoixTypeJeu:decrementSelection()
	self.selection[self.selected]:setSelected(false)
		if self.selected == 1 then
		self.selected = #self.selection + 1
	end
	self.selected = self.selected - 1
	self.selection[self.selected]:setSelected(true)
end

function ChoixTypeJeu:mouseReleased(x, y, button) end

function ChoixTypeJeu:keyPressed(key, unicode)
    self.inputManager:keyPressed(key,unicode,true)
end
function ChoixTypeJeu:keyReleased(key, unicode)
    self.inputManager:keyReleased(key,unicode)
end

function ChoixTypeJeu:joystickPressed(key, unicode)
    self.inputManager:joystickPressed(key,unicode)
end


function ChoixTypeJeu:joystickReleased(key, unicode)
    self.inputManager:joystickReleased(key,unicode)
end


function ChoixTypeJeu:sendPressedKey(key, unicode)
	if key == 'down' or key =='tab' then
			self:incrementSelection()
		elseif key =='up' then
			self:decrementSelection()
	
		elseif key == "return" then

			if self.story.selected then
				self:GoPersoOrder("histoire")
			end


			if self.arcade.selected then
				self:GoPersoOrder("arcade")
			end


			if self.returnB.selected then
				self:DisconnectOrder()
				-- Disconnection to put here
			end
		end
end



function ChoixTypeJeu:GoPersoOrder(type)
    monde.typeJeu = type
    print( "SET TO", monde.typeJeu  )
    serveur:send({type="syncro", sender = monde.cookie, pck={next="ChoixPerso", current="ChoixTypeJeu", typeJeu = type}})    
    gameStateManager:changeState('ChoixPerso')
end

function ChoixTypeJeu:DisconnectOrder()
    serveur:send({type="syncro", sender = monde.cookie, pck={next="ConnectToServer", current="ChoixTypeJeu"}})    
    gameStateManager:resetAndChangeState('ConnectToServer')        
end

function ChoixTypeJeu:GoPersoApply(type)
	print("APPLY RECU", type)
    monde.typeJeu = type
    gameStateManager:changeState('ChoixPerso')
end

function ChoixTypeJeu:DisconnectApply()
    gameStateManager:resetAndChangeState('ConnectToServer')
    serveur:disconnect() 
end


function ChoixTypeJeu:update(dt) 
	self.inputManager:update()
	self.commonBackground:update(dt)
end

function ChoixTypeJeu:onMessage(msg)

	if msg.type=="syncro" and msg.pck.next=="ConnectToServer"then
        self:DisconnectApply()  
    elseif msg.type=="syncro" and msg.pck.next=="ChoixPerso" then
        self:GoPersoApply(msg.pck.typeJeu)   
    elseif msg.type=="reset" then
        -- We got a problem
        --gameStateManager:forceDisconnect()
    else
    	assert(false)
        -- Ce message n'est pas censé atterir ici
    end 
end

function ChoixTypeJeu:draw()
	-- background :
	self.commonBackground:draw(1)

	self.story:draw(1)
	self.arcade:draw(1)
	self.returnB:draw(1)
end

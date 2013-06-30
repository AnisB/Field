--[[ 
This file is part of the Field project]]

ChoixNiveau = {}
ChoixNiveau.__index = ChoixNiveau
function ChoixNiveau:new()
    local self = {}
    setmetatable(self, ChoixNiveau)

    self.inputManager = MenuInputManager.new(self)
    self.back=BackgroundNiveau.new()
    self.levellabel=love.graphics.newImage("backgrounds/choixniveau/level.png")

    self.play= Button.new(150,340,200,50,   "backgrounds/choixniveau/play.png")
    self.returnB= Button.newDec(125,440,250,50, "backgrounds/choixniveau/return.png",10,0)

    self.right= Button.new(1100,300,123,155,"backgrounds/choixniveau/right.png")
    self.left= Button.newDec(500,300,123,155,"backgrounds/choixniveau/left.png",10,0)

    self.err = false
    self.num_level = 1
    monde.availableMaps = {"NONE"}
    self.prev={}

    self.level = monde.availableMaps[self.num_level]

    self.selection = {
        self.play,
        self.returnB
    }
    self.selected = 1
    self.play:setSelected(true)
    return self
end

function ChoixNiveau:mousePressed(x, y, button)

end

function ChoixNiveau:incrementSelection()
	self.selection[self.selected]:setSelected(false)
	if self.selected == #self.selection then
		self.selected = 0
	end
	self.selected = self.selected + 1
	self.selection[self.selected]:setSelected(true)
end

function ChoixNiveau:decrementSelection()
	self.selection[self.selected]:setSelected(false)
		if self.selected == 1 then
		self.selected = #self.selection + 1
	end
	self.selected = self.selected - 1
	self.selection[self.selected]:setSelected(true)
end


function ChoixNiveau:mouseReleased(x, y, button) end

function ChoixNiveau:keyPressed(key, unicode)
    self.inputManager:keyPressed(key,unicode)
end
function ChoixNiveau:keyReleased(key, unicode)
    self.inputManager:keyReleased(key,unicode)
end

function ChoixNiveau:joystickPressed(key, unicode)
    self.inputManager:joystickPressed(key,unicode)
end


function ChoixNiveau:joystickReleased(key, unicode)
    self.inputManager:joystickReleased(key,unicode)
end


function ChoixNiveau:sendPressedKey(key, unicode)
	if key == "down" then
		self:incrementSelection()
	elseif key == "up" then
		self:decrementSelection()
	elseif key =="left" then
		self.num_level = self.num_level - 1
		self:synchroViewedLevel()
	elseif key == "right" then
		self.num_level = self.num_level + 1
		self:synchroViewedLevel()
	elseif key == "return" then
		if self.level~="NONE" and self.play.selected then
			self:goGameplayOrder() 
		elseif self.returnB.selected then
			self:backChoixPersoOrder() 
		end
	end
	if self.num_level < 1 then self.num_level = 1 end
	if self.num_level > #monde.availableMaps then self.num_level = #monde.availableMaps end
	self.level = monde.availableMaps[self.num_level]
	if self.prev[self.level]==nil then
			self.prev[self.level]=love.graphics.newImage("maps/multi/"..self.level.."-fieldmap/prev.png")
	end
end

function ChoixNiveau:update(dt) 
	self.inputManager:update()
end

function ChoixNiveau:onMessage(msg)

	if msg.type=="syncro" and msg.pck.next=="Gameplay"then
        self:goGameplayApply(msg.pck.level)     
    elseif msg.type=="syncro" and msg.pck.next=="ChoixNiveau" then
        self:backChoixPersoApply()   
    elseif msg.type=="reset" then
        -- We got a problem
        --gameStateManager:forceDisconnect()
    elseif msg.type == "syncroLevel" then
    	self:synchroViewedLevelApply(msg.pck.level)	
	else
		print("[ChoixNiveau] wrong type :", table2.tostring(msg))
	end
end



function ChoixNiveau:synchroViewedLevel()
	print("Syncro level order", self.num_level,#monde.availableMaps)
	if self.num_level > 0 and self.num_level<= #monde.availableMaps then
		print("Envoi Ordre")
		serveur:send({type="syncroLevel", pck={perso=monde.moi.perso, current="ChoixNiveau", level=self.num_level}})    
	end
end
function ChoixNiveau:synchroViewedLevelApply(level)
	print("Syncro level apply")
	self.num_level = level
	if self.num_level < 1 then self.num_level = 1 end
	if self.num_level > #monde.availableMaps then self.num_level = #monde.availableMaps end
	self.level = monde.availableMaps[self.num_level]
	if self.prev[self.level]==nil then
			self.prev[self.level]=love.graphics.newImage("maps/multi/"..self.level.."-fieldmap/prev.png")
	end

end

function ChoixNiveau:goGameplayOrder()
    serveur:send({type="syncro", pck={perso=monde.moi.perso, next="Gameplay", current="ChoixNiveau", level = self.level}})    
    gameStateManager.state['Gameplay']=Gameplay.new("maps/multi/"..self.level,true)
    gameStateManager:changeState('Gameplay')
end

function ChoixNiveau:backChoixPersoOrder()
    serveur:send({type="syncro", pck={perso=monde.moi.perso, next="ChoixPerso", current="ChoixNiveau"}})    
    gameStateManager:changeState('ChoixPerso')        
end

function ChoixNiveau:goGameplayApply(level)
    gameStateManager.state['Gameplay']=Gameplay.new("maps/multi/"..level,true)
    gameStateManager:changeState('Gameplay')
end

function ChoixNiveau:backChoixPersoApply()
    gameStateManager:changeState('ChoixPerso')        
end


function ChoixNiveau:draw()

	-- background :
	self.back:draw(1)

	love.graphics.draw(self.levellabel, 720, 200)
	love.graphics.print(self.level, 920, 200)
	self.right:draw(1)
	self.left:draw(1)
    self.play:draw(1)
    self.returnB:draw(1)

    if self.prev[self.level]~=nil then
    	love.graphics.draw(self.prev[self.level], 647, 260,0,0.35,0.35)
	end


end

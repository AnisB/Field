--[[ 
This file is part of the Field project]]

ChoixTypeJeu = {}
ChoixTypeJeu.__index = ChoixTypeJeu
function ChoixTypeJeu:new()
    local self = {}
    setmetatable(self, ChoixTypeJeu)
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
	if key == 'down' or key =='tab' then
			self:incrementSelection()
		elseif key =='up' then
			self:decrementSelection()
	
		elseif key == "return" then

			if self.story.selected then
				-- serveur:send({type="choixTypeJeu", typeJeu="story"})
			end


			if self.arcade.selected then
				serveur:send({type="choixTypeJeu", typeJeu="arcade"})
			end


			if self.returnB.selected then
				-- Disconnection to put here
			end
		end
end
function ChoixTypeJeu:keyReleased(key, unicode) end

function ChoixTypeJeu:joystickPressed(joystick, button)
end

function ChoixTypeJeu:joystickReleased(joystick, button)
end

function ChoixTypeJeu:update(dt) 
	self.commonBackground:update(dt)
end

function ChoixTypeJeu:onMessage(msg)
	if msg.type == "choixTypeJeuFini" then
		monde.typeJeu = msg.typeJeu
		if monde.typeJeu == 'arcade' then
			if msg.persos == nil then
				gameStateManager:changeState('ChoixPerso')
			else
				return -- on verra ?
			end
		end
	else
		print("[ChoixTypeJeu] wrong type :", table2.tostring(msg))
	end
end

function ChoixTypeJeu:draw()
	-- background :
	self.commonBackground:draw(1)

	self.story:draw(1)
	self.arcade:draw(1)
	self.returnB:draw(1)
end

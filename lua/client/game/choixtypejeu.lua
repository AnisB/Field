--[[ 
This file is part of the Field project]]

ChoixTypeJeu = {}
ChoixTypeJeu.__index = ChoixTypeJeu
function ChoixTypeJeu:new()
    local self = {}
    setmetatable(self, ChoixTypeJeu)
    self.back=love.graphics.newImage("backgrounds/solo/back.png")
    self.story=Button.new(150,325,200,50,ButtonType.Large,"backgrounds/solo/story.png")
    self.arcade=Button.new(150,400,250,50,ButtonType.Large,"backgrounds/solo/arcade.png")
    self.returnB=Button.new(50,625,250,50,ButtonType.Large,"backgrounds/solo/return.png")
    return self
end

function ChoixTypeJeu:mousePressed(x, y, button)
	if self.arcade:isCliked(x,y) then
		serveur:send({type="choixTypeJeu", typeJeu="arcade"})
	elseif self.story:isCliked(x,y) then
		--serveur:send({type="choixTypeJeu", typeJeu="histoire"})
	end
end

function ChoixTypeJeu:mouseReleased(x, y, button) end
function ChoixTypeJeu:keyPressed(key, unicode) end
function ChoixTypeJeu:keyReleased(key, unicode) end

function ChoixTypeJeu:joystickPressed(joystick, button)
end

function ChoixTypeJeu:joystickReleased(joystick, button)
end

function ChoixTypeJeu:update(dt) end

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
	x, y = love.mouse.getPosition()

	-- background :
	love.graphics.draw(self.back, 0, 0)

	self.story:draw(x,y,1)
	self.arcade:draw(x,y,1)
	self.returnB:draw(x,y,1)
end

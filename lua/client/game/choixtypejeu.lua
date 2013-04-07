--[[ 
This file is part of the Field project]]

ChoixTypeJeu = {}
ChoixTypeJeu.__index = ChoixTypeJeu
function ChoixTypeJeu:new()
    local self = {}
    setmetatable(self, ChoixTypeJeu)
    self.isRed=0
    return self
end

function ChoixTypeJeu:mousePressed(x, y, button)
	if x > 200 and x < 250 and y > 200 and y < 250 then
		serveur:send({type="choixTypeJeu", typeJeu="arcade"})
	else
		serveur:send({type="choixTypeJeu", typeJeu="histoire"})
	end
end

function ChoixTypeJeu:mouseReleased(x, y, button) end
function ChoixTypeJeu:keyPressed(key, unicode) end
function ChoixTypeJeu:keyReleased(key, unicode) end
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
	love.graphics.print("arcade", 200, 200)
	love.graphics.print("histoire", 200, 300)

end

--[[ 
This file is part of the Field project]]

ChoixPerso = {}
ChoixPerso.__index = ChoixPerso
function ChoixPerso:new()
    local self = {}
    setmetatable(self, ChoixPerso)
    self.err = false
    self.isRed=0
    return self
end

function ChoixPerso:mousePressed(x, y, button)
	if x > 200 and x < 250 and y > 200 and y < 250 then
		serveur:send({type="choixPerso", confirm=false, perso="metalman"})
		self.isRed=1
	elseif x > 200 and x < 250 and y > 300 and y < 350 then
		serveur:send({type="choixPerso", confirm=false, perso="themagnet"})
		self.isRed=2
	else
		serveur:send({type="choixPerso", confirm=true})
	end
end

function ChoixPerso:mouseReleased(x, y, button) end
function ChoixPerso:keyPressed(key, unicode) end
function ChoixPerso:keyReleased(key, unicode) end
function ChoixPerso:update(dt) end

function ChoixPerso:onMessage(msg)
	if msg.type == "choixPerso" then
		if msg.player == monde.cookie then
			monde.moi = {}
			monde.moi.perso = msg.perso
			monde[msg.perso] = monde.moi
		else
			monde.lui = {}
			monde.lui.perso = msg.perso
			monde.lui.cookie = msg.player
			monde[msg.perso] = monde.lui
		end
	elseif msg.type == "choixPersoFini" then
		gameStateManager:changeState('Gameplay')
	elseif msg.type == "err" then
		self.err = true
	else
		print("[ChoixPerso] wrong type :", table2.tostring(msg))
	end
end

function ChoixPerso:draw()
		if self.isRed==1 then
		love.graphics.setColor(255, 0, 0, 255)
	else
		love.graphics.setColor(255, 255, 255, 255)
	end
	love.graphics.print("metalman", 200, 200)

	if self.isRed==2 then
		love.graphics.setColor(255, 0, 0, 255)
	else
		love.graphics.setColor(255, 255, 255, 255)
	end
	love.graphics.print("themagnet", 200, 300)
	love.graphics.setColor(255, 255, 255, 255)

	love.graphics.print("PLAY", 200, 400)
	if self.err then
		love.graphics.print("ERR", 600, 100)
	end
end

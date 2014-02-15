
require("game.gamestatemanager")
require("const")


Field = {}
Field.__index = Field


InputType = {		UP = 'up', DOWN = 'down', LEFT = 'left', RIGHT = 'right', 
						ACTION1 = 'action1', ACTION2 = 'action2', ACTION3 = 'action3',
						ACTION4 = 'action4', ACTION5 = 'action5', ACTION6 = 'action6',
						START = 'start', HELP = 'help', MENU = 'menu', NONE='none'}

Field.Player = { PLAYERONE = 'p1', PLAYERTWO = 'p2', UNKNOWN = 'uk'}

function Field.new()
	local self = {}
	setmetatable(self, Field)
	return self
end


function Field:Init()
	self.keys =  require("input.keys")
end

-- Gestion des touches
function Field:inputPressed(akey)
	    -- print("Pressed", akey)
	    local result = self:FindOwner(akey)
	    s_gameStateManager:inputPressed(result.key, result.player)
end

function Field:inputReleased(akey)
	    -- print("Released", akey)
	    local result = self:FindOwner(akey)
	    s_gameStateManager:inputReleased(result.key, result.player)
end

function Field:update(dt)
	    s_gameStateManager:update(dt)
end

function Field:FindOwner(parKey)
	for i,v in pairs(self.keys['PLAYERONE']) do
		if(v==parKey) then
			return {player=Field.Player.PLAYERONE, key = InputType[i]}
		end
	end
	for i,v in pairs(self.keys['PLAYERTWO']) do
		if(v==parKey) then
			return {player=Field.Player.PLAYERTWO, key = InputType[i]}
		end
	end
	return {player=Field.Player.UNKNOWN, key = parKey}

end

function Field:draw()
	    s_gameStateManager:draw(dt)
end

s_field = Field.new()
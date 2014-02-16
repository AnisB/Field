
require("game.gamestatemanager")
require("const")


GameManager = {}
GameManager.__index = GameManager


InputType = {		UP = 'up', DOWN = 'down', LEFT = 'left', RIGHT = 'right', 
						ACTION1 = 'action1', ACTION2 = 'action2', ACTION3 = 'action3',
						ACTION4 = 'action4', ACTION5 = 'action5', ACTION6 = 'action6',
						START = 'start', HELP = 'help', MENU = 'menu', NONE='none'}

GameManager.Player = { PLAYERONE = 'p1', PLAYERTWO = 'p2', UNKNOWN = 'uk'}

function GameManager.new()
	local self = {}
	setmetatable(self, GameManager)
	return self
end


function GameManager:Init()
	self.keys =  require("input.keys")
end

-- Gestion des touches
function GameManager:inputPressed(akey)
	    -- print("Pressed", akey)
	    local result = self:FindOwner(akey)
	    s_gameStateManager:inputPressed(result.key, result.player)
end

function GameManager:inputReleased(akey)
	    -- print("Released", akey)
	    local result = self:FindOwner(akey)
	    s_gameStateManager:inputReleased(result.key, result.player)
end

function GameManager:update(dt)
	    s_gameStateManager:update(dt)
end

function GameManager:FindOwner(parKey)
	for i,v in pairs(self.keys['PLAYERONE']) do
		if(v==parKey) then
			return {player=GameManager.Player.PLAYERONE, key = InputType[i]}
		end
	end
	for i,v in pairs(self.keys['PLAYERTWO']) do
		if(v==parKey) then
			return {player=GameManager.Player.PLAYERTWO, key = InputType[i]}
		end
	end
	return {player=GameManager.Player.UNKNOWN, key = parKey}

end

function GameManager:draw()
	    s_gameStateManager:draw(dt)
end

s_gameManager = GameManager.new()
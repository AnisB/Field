
--[[ 
This file is a part of the Field project
]]

require('prelude')
require("storyline")
require("FirstEnter")
require("connecttoserver")
require("waitingfordistant")
require("levelbegin")
require("gameplay")
--require("levelchange")
--require()
GameState {}
GameStateManager.__index = GameStateManager

function GameStateManager:new()
	local self = {}
	setmetatable(self, GameStateManager)
	self.state = {}
	self.state['Prelude'] = Prelude:new()
	self.state['Storyline'] = Storyline:new()
	self.state['FirstEnter'] = FirstEnter:new()
	self.state['ConnectToServer'] = ConnectToServer:new()
	self.state['WaitingForDistant'] = WaitingForDistant:new()
	self.state['LevelBegin'] = LevelBegin:new()
	self.state['Gameplay'] = Gameplay:new()
	--self.state['LevelChange'] = LevelChange:new()
	--self.state['PartyEnd'] = PartyEnd:new()
	
	return self
end

function GameStateManager:mousePressed(x, y, button)
	self.state[self.currentState]:mousePressed(x,y,button)
end

function GameStateManager:mouseReleased(x, y, button)
	self.state[self.currentState]:mouseReleased(x,y,button)
end

function GameStateManager:keyPressed(key, unicode)
	self.state[self.currentState]:keyPressed(key, unicode)
end

function GameStateManager:keyReleased(key, unicode)
	self.state[self.currentState]:keyReleased(key, unicode)
end

function GameStateManager:update(dt)
	self.state[self.currentState]:update(dt)
end

function GameStateManager:draw()	
	self.state[self.currentState]:draw()
end

function GameStateManager:changeState(newState)
	self.currentState=newState
end

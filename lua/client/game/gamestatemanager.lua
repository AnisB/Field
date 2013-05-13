--[[ 
This file is a part of the Field project
]]

require("game.prelude")
require("game.storyline")
require("game.firstenter")
require("game.connecttoserver")
require("game.choixtypejeu")
require("game.choixperso")
require("game.choixniveau")
require("game.waitingfordistant")
require("game.levelbegin")
require("game.gameplay")
require("game.menu")
require("game.credits")
require("game.options")
require("game.solo.choixniveausolo")
require("game.solo.choixtypejeusolo")
require("game.solo.choixpersosolo")
--require("game.levelchange")
--require()
GameStateManager = {}
GameStateManager.__index = GameStateManager

function GameStateManager.new()
	local self = {}
	setmetatable(self, GameStateManager)

	-- Global States
	self.state = {}
	self.state['Prelude'] = Prelude.new()
	self.state['Storyline'] = Storyline.new()
	self.state['FirstEnter'] = FirstEnter.new()
	self.state['Menu'] = Menu.new()
	self.state['Credits'] = Credits.new()
	self.state['Options'] = Options.new()

	-- Jeu Réseau
	self.state['ConnectToServer'] = ConnectToServer.new()
	self.state['ChoixTypeJeu'] = ChoixTypeJeu.new()
	self.state['ChoixPerso'] = ChoixPerso.new()
	self.state['ChoixNiveau'] = ChoixNiveau.new()
	self.state['WaitingForDistant'] = WaitingForDistant.new()
	self.state['LevelBegin'] = LevelBegin.new()
	-- self.state['Gameplay'] = Gameplay.new()
	--self.state['LevelChange'] = LevelChange.new()
	--self.state['PartyEnd'] = PartyEnd.new()


	-- Jeu Solo
	self.state['ChoixTypeJeuSolo'] = ChoixTypeJeuSolo.new()	
	-- self.state['ChoixNiveauSolo'] = ChoixNiveauSolo.new("themagnet",false)

	self.state['ChoixPersoSolo'] = nil
	-- self.state['GameplaySolo'] = GameplaySolo.new("level1",false,"metalman")
-- 
	-- Init
	self.currentState='FirstEnter'
	return self
end

function GameStateManager:onMessage(msg)
	if self.state[self.currentState].onMessage then
		self.state[self.currentState]:onMessage(msg)
	end
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

function GameStateManager:joystickPressed(joystick, button)
	if self.currentState=='Gameplay' then
		self.state[self.currentState]:joystickPressed(joystick, button)
	end
end

function GameStateManager:joystickReleased(joystick, button)
	if self.currentState=='Gameplay' then
		self.state[self.currentState]:joystickReleased(joystick, button)
	end
end

function GameStateManager:update(dt)
	self.state[self.currentState]:update(dt)
end

function GameStateManager:reset()	
	self.state[self.currentState]:reset()
end
function GameStateManager:draw()	
	self.state[self.currentState]:draw()
end
function GameStateManager:changeState(newState)
	self.currentState=newState
end

function GameStateManager:resetAndChangeState(newState)
	self.state[newState]:reset()
	self.currentState=newState
end

function GameStateManager:failed()
	print(self.currentState)
	self.state[self.currentState]:failed()
end

function GameStateManager:finish()
	self.state[self.currentState]:finish()
end

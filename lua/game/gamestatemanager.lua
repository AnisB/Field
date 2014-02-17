--[[ 
This file is a part of the Field project
]]

--  Verifications graphiques
require("render.graphicchecks")
-- Ecran titre
require("game.firstenter")

-- require("game.cinematic.cinematic")


-- require("game.choixtypejeu")
-- require("game.choixperso")
-- require("game.choixniveau")
-- require("game.waitingfordistant")
-- require("game.levelbegin")
-- require("game.gameplay")
require("game.menu")
-- require("game.credits")
-- require("game.options")


require("game.choixtypejeusolo")
require("game.choixpersosolo")
require("game.choixniveausolo")
require("game.gameplaysolo")

require("game.solo.levelfailedsolo")
require("game.solo.levelendingsolo")



GameStateManager = {}
GameStateManager.__index = GameStateManager

function GameStateManager.new()
	local self = {}
	setmetatable(self, GameStateManager)

	-- Loader
    self.loader = require 'resource/love-loader'

    local states = {}
-- 	-- Global States
-- 	self.state = {}
	-- self.state['Prelude'] = Prelude.new()
-- 	self.state['Storyline'] = Storyline.new()
	states['GraphicChecks'] = GraphicChecks.new()
	states['FirstEnter'] = FirstEnter.new()
	states['Menu'] = Menu.new()
-- 	self.state['Credits'] = Credits.new()
-- 	self.state['Options'] = Options.new()

-- 	-- Jeu Réseau
-- 	self.state['ConnectToServer'] = ConnectToServer.new()
-- 	self.state['ChoixTypeJeu'] = ChoixTypeJeu.new()
-- 	self.state['ChoixPerso'] = ChoixPerso.new()
-- 	self.state['ChoixNiveau'] = ChoixNiveau.new()
-- 	self.state['WaitingForDistant'] = WaitingForDistant.new()
-- 	self.state['LevelBegin'] = LevelBegin.new()
-- 	self.state['Gameplay'] = nil

-- 	-- self.state['Cinematic'] = Cinematic.new("exemple")



-- 	-- Jeu Solo
	states['ChoixTypeJeuSolo'] = ChoixTypeJeuSolo.new()	
	states['ChoixPersoSolo'] = nil
	-- states['ChoixNiveauSolo'] = nil
	states['GameplaySolo'] = nil
	states['LevelEndingSolo'] = nil
	states['LevelFailedSolo'] = nil
	states['ChoixNiveauSolo'] = ChoixNiveauSolo.new("metalman",false)
-- -- 
-- 	-- Init
	self.state = states
	self.currentState='ChoixNiveauSolo'
	self.nextState='ChoixNiveauSolo'
	self.isTransiton = 0
	self.transitionTime = 1.0
	self.timer = 0.0
	self.state[self.currentState]:reset()
	return self
end

function GetCurrentState()
	return s_gameStateManager.state[s_gameStateManager.currentState]
end
function GameStateManager:inputPressed(key, unicode)
	if(self.isTransiton == 0) then
		self.state[self.currentState]:keyPressed(key, unicode)
	end
end

function GameStateManager:inputReleased(key, unicode)
	if(self.isTransiton == 0) then
		self.state[self.currentState]:keyReleased(key, unicode)
	end
end

function GameStateManager:update(dt)
	-- Mise a jour de l'état
	self.state[self.currentState]:update(dt)

	-- Transition en fondu
	if(self.isTransiton == 1) then
		self.timer = self.timer +dt
		if(self.timer>=1.0) then
			self.isTransiton = 2
			self.timer= 1.0
			self.currentState = self.nextState
		end
	elseif  (self.isTransiton == 2) then
		self.timer = self.timer -dt
		if(self.timer<=0.0) then
			self.timer = 0.0
			self.isTransiton = 0
			self.currentState = self.nextState
		end
	end
end

function GameStateManager:reset()	
	self.state[self.currentState]:reset()
end
function GameStateManager:draw()	
	if(not self.isTransiton) then
		self.state[self.currentState]:draw(1.0)
	else
		self.state[self.currentState]:draw(1.0-self.timer)
	end
end
function GameStateManager:changeState(newState)
	self.nextState = newState
	self.isTransiton =  1
end
function GameStateManager:resetLoader()
	self.loader = nil
	self.loader = require 'game/love-loader'
end


function GameStateManager:resetAndChangeState(newState)
	self.state[newState]:reset()
	self.currentState=newState
end

function GameStateManager:failed()
	self.state[self.currentState]:failed()
end

function GameStateManager:finish()
	self.state[self.currentState]:finish()
end

s_gameStateManager = GameStateManager.new()

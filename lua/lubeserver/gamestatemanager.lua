require('gamestates.attente')
require('gamestates.choixtypejeu')
require('gamestates.arcadechoixperso')
require('gamestates.arcadechoixniveau')
require('gamestates.arcade')
require('gamestates.histoirechoixperso')
require('gamestates.histoire')

GameStateManager = {}

function GameStateManager:init()
	self.states = {
		attente= common.instance(Attente),
		choixTypeJeu= common.instance(ChoixTypeJeu),
		arcadeChoixPerso= common.instance(ArcadeChoixPerso),
		arcadeChoixNiveau= common.instance(ArcadeChoixNiveau),
		arcade= common.instance(Arcade),
		histoireChoixPerso= common.instance(HistoireChoixPerso),
		histoire= common.instance(Histoire)
	}
	self.currentState = "attente"
end

function GameStateManager:changeState(newState)
	if debug_lvl > 3 then
		print("[debug]["..self.currentState.."][changeState]", newState)
	end
	self.currentState = newState
end

-- A partir de là : les méthodes qui doivent être réimplémentées par les States

function GameStateManager:update(dt)
	self.states[self.currentState]:update(dt)
end

function GameStateManager:onMessage(msg, client)
	if debug_lvl > 6 then
		print("[debug]["..self.currentState.."][onMessage]", table2.tostring(msg))
	end
	self.states[self.currentState]:onMessage(msg, client)
end

GameStateManager = common.class("GameStateManager", GameStateManager)
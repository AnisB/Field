--[[ 
This file is part of the Field project
]]


Action = {}
Action.__index =  Action

Action.Cibles = { MobileSprites = "MobileSprites", AnimatedEntities = "AnimatedEntities"}

Action.Types = { Position = "Position", Velocity = "Velocity", Visibility = "Visibility", Animation = "Animation"}

function Action.new(time, cible, id, idAction, Args, ScenarioLoader)
    local self = {}
    setmetatable(self, Action)

    self.time = time 
    self.cible = cible 
    self.id = id 
    self.idAction = idAction
    self.args = Args

    self.scenarioLoader = ScenarioLoader

    self.done = false
    return self
end

function Action:shouldBeDone(time)
	return(time >= self.time )
end


function Action:execute(time)

	local cible = nil
	if self.cible == Action.Cibles.AnimatedEntities then
		cible = self.scenarioLoader:getEntity(self.id)
	elseif self.cible == Action.Cibles.MobileSprites then
		cible = self.scenarioLoader:getMobileSprite(self.id)
	end

	if self.idAction == Action.Types.Position then
		cible:setPosition(self.args)
	elseif self.idAction == Action.Types.Velocity then
		cible:setVelocity(self.args)
	elseif self.idAction == Action.Types.Visibility then
		cible:setVisibility(self.args)
	elseif self.idAction == Action.Types.Animation then
		cible:setAnimation(self.args)
	end
end


function Action:draw()
		love.graphics.draw(toDraw, self.posx, self.posy)
end
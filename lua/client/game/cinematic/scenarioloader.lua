--[[ 
This file is part of the Field project
]]

-- Includes génériques
require("const")


-- Inlcudes relatifs aux objets
require("game.cinematic.animatedentity")
require("game.cinematic.action")
require("game.cinematic.mobilesprite")

require("game.solo.tilesetssolo")


ScenarioLoader = {}
ScenarioLoader.__index =  ScenarioLoader

function ScenarioLoader.new(ScenarioLoaderFile)
    local self = {}
    setmetatable(self, ScenarioLoader)
    -- self.scenario = require (ScenarioLoaderFile.."-fieldscneario/content")
    self.scenario = require ("scenario/"..ScenarioLoaderFile)

    -- Init
    self.animatedEntities ={}
    self.mobileSprites ={}

    self.actions ={}


    self:createAnimatedEntities(self.scenario.AnimatedEntities)
    self:createMobileSprites(self.scenario.MobileSprites)
    self:createActions(self.scenario.Actions)
    return self
end


function ScenarioLoader:createAnimatedEntities(list)
    for i,j in pairs(list) do
        table.insert(self.animatedEntities, AnimatedEntity.new(j.id, j.pos, j.isVisible, j.sprite, j.delay, j.loop, j.nbFrames, j.velocity, j.normalMapped))
    end
end


function ScenarioLoader:createMobileSprites(list)
    for i,j in pairs(list) do
        table.insert(self.mobileSprites, MobileSprite.new(j.id, j.pos, j.isVisible, j.sprite, j.velocity, j.normalMapped))
    end
end

function ScenarioLoader:createActions(list)
    for i,j in pairs(list) do
        print(j.t, j[1], j[2], j[3], j[4])
        table.insert(self.actions, Action.new(j.t, j[1], j[2], j[3], j[4],self))
    end
end

function ScenarioLoader:getEntity(id)
    for i,j in pairs(self.animatedEntities) do
        print(j.id, id)
        if j.id == id then
            return j
        end
    end
end

function ScenarioLoader:getMobileSprite(id)
    for i,j in pairs(self.mobileSprites) do
        print(j.id, id)

        if j.id == id then
            return j
        end
    end
end

function ScenarioLoader:update(dt)

    for i,b in pairs(self.mobileSprites) do
          b:update(dt)
    end

    for i,b in pairs(self.animatedEntities) do
          b:update(dt)
    end
end

function ScenarioLoader:isSeen(pos1,pos2,w,h)
    if (pos1.x-pos2.x-w)>(windowW/2) or (pos1.x-pos2.x)<(-windowW/2) or (pos1.y-pos2.y-h)>(windowH/2) or (pos1.y-pos2.y)<(-windowH/2) then
        return false
    else
        return true
    end
end

function ScenarioLoader:draw()
    for i,p in pairs(self.mobileSprites) do
          p:draw()
    end

    for i,p in pairs(self.animatedEntities) do
          p:draw()
    end
end
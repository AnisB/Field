--[[ 
This file is part of the Field project
]]

-- Includes génériques
require("const")


-- Inlcudes relatifs aux objets
require("game.cinematic.animatedentity")
require("game.solo.tilesetssolo")


ScenarioLoader = {}
ScenarioLoader.__index =  ScenarioLoader

function ScenarioLoader.new(ScenarioLoaderFile)
    local self = {}
    setmetatable(self, ScenarioLoader)
    self.map = require (ScenarioLoaderFile.."-fieldscneario/content")

    -- Init
    self.sprites ={}

    -- Creation du Layer
    self.tilesets={}

    for i,d in pairs(self.map.layers) do
        if d.name=="foreground" then
                table.insert(self.tilesets,TilesetsSolo.new(self.map.tilesets,d,ScenarioLoaderFile))
            elseif d.name=="Calque de Tile 1" then
                table.insert(self.tilesets,TilesetsSolo.new(self.map.tilesets,d,ScenarioLoaderFile))
            elseif d.name=="front" then
                table.insert(self.tilesets,TilesetsSolo.new(self.map.tilesets,d,ScenarioLoaderFile))
            elseif  d.name=="sprites" then
            -- Gestion d'un sprite animé
            self:createSprite(d)   
            end    
    end
    return self
end


function ScenarioLoader:createArcs(map)
    for i,j in pairs(map.objects) do
        table.insert(self.sprites, AnimatedEntity.new()
    end
end


function ScenarioLoader:update(dt)

    for i,b in pairs(self.sprites) do
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

function ScenarioLoader:draw(pos)
    
    for i,p in pairs(self.tilesets) do
            p:draw({x=pos.x-windowW/2,y=windowH/2-pos.y})
    end

    for i,p in pairs(self.sprites) do
        if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
          p:draw(pos.x-windowW/2,windowH/2-pos.y)
        end
	end
end
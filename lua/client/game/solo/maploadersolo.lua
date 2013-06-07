--[[ 
This file is part of the Field project
]]


require("game.solo.platformsolo")
require("game.solo.camerasolo")
require("const")
require("game.solo.wallsolo")
require("game.solo.destroyablesolo")
require("game.solo.tilesetssolo")
require("game.solo.movablesolo")
require("game.solo.gateinterruptorsolo")
require("game.solo.gatesolo")
require("game.solo.acidsolo")
require("game.solo.arcsolo")
require("game.solo.generatorsolo")
require("game.solo.interruptorsolo")
require("game.solo.metalsolo")
require("game.solo.levelendsolo")



MapLoaderSolo = {}
MapLoaderSolo.__index =  MapLoaderSolo

function MapLoaderSolo.new(MapLoaderSoloFile,magnetManager)
    local self = {}
    setmetatable(self, MapLoaderSolo)
    print("maps/"..MapLoaderSoloFile.."\.fieldmap/map.lua")
    self.map = require (MapLoaderSoloFile.."-fieldmap/map")
    self.magnetManager=magnetManager

    -- Init
    self.walls ={}
    self.platforms={}
    self.destroyables={}
    self.movables={}
    self.generators={}
    self.interruptors={}
    self.gateinterruptors={}
    self.gates={}
    self.metals={}
    self.acids={}
    self.arcs={}
    self.levelends={}
    self.allowedPowers={}
    -- Creation du Layer
    self.tilesets={}

    for i,d in pairs(self.map.layers) do
        if d.name=="wall" then
            self:createWalls(d)
            elseif d.name=="foreground" then
                table.insert(self.tilesets,TilesetsSolo.new(self.map.tilesets,d,MapLoaderSoloFile))
            elseif d.name=="Calque de Tile 1" then
                table.insert(self.tilesets,TilesetsSolo.new(self.map.tilesets,d,MapLoaderSoloFile))
            elseif d.name=="front" then
                table.insert(self.tilesets,TilesetsSolo.new(self.map.tilesets,d,MapLoaderSoloFile))
            elseif  d.name=="platform" then
                -- Gestion des platformes
                self:createPlatforms(d)    

                elseif  d.name=="destroyable" then
                -- Gestion des destructibles
                self:createDestroyables(d) 

                elseif  d.name=="movable" then
                -- Gestion des movables
                self:createMovables(d)     

                elseif  d.name=="generator" then
                -- Gestion des generateurs
                self:createGenerators(d) 

                elseif  d.name=="switch" then
                -- Gestion des interrupteurs
                self:createInterruptors(d)

                elseif  d.name=="metal" then
                -- Gestion des méteaux
                self:createMetals(d)   

                elseif  d.name=="gateswitch" then
                -- Gestion des interrutpeurs de porte
                self:createGateInterruptors(d)

                elseif  d.name=="gate" then
                -- Gestion des portes
                self:createGates(d) 
                elseif  d.name=="acid" then
                -- Gestion des acides
                self:createAcids(d)   
                elseif  d.name=="arc" then
                -- Gestion des arcs
                self:createArcs(d)
                elseif  d.name=="levelend" then
                -- Gestion des fin de niveau
                self:createLevelEnds(d)   
                elseif  d.name=="metalman" then
                -- Gestion de position
                self.metalManPos={x=d.objects[1].x,y=d.objects[1].y}  
                self.metalManPowers=d.objects[1].properties["powers"]
                elseif  d.name=="themagnet" then
                -- Gestion de position
                self.theMagnetPos={x=d.objects[1].x,y=d.objects[1].y}
                self.theMagnetPowers=d.objects[1].properties["powers"]
            end    
            
    end

    return self
end


function MapLoaderSolo:createPlatforms(map)
    for i,j in pairs(map.objects) do
        table.insert(self.platforms, PlatformSolo.new({x=(j.x),y=(j.y)},j.width,nil,nil,nil))
    end
end



function MapLoaderSolo:createWalls(map)
    for i,j in pairs(map.objects) do
        table.insert(self.walls, WallSolo.new({x=(j.x),y=(j.y)},j.height,nil,nil,nil))
    end
end

function MapLoaderSolo:createMovables(map)
    for i,j in pairs(map.objects) do
        table.insert(self.movables, MovableSolo.new({x=(j.x),y=(j.y)},j.shape,i))
    end
end

function MapLoaderSolo:createDestroyables(map)
    for i,j in pairs(map.objects) do
        table.insert(self.destroyables, DestroyableSolo.new({x=(j.x),y=(j.y)},j.shape,nil,j.width,j.height,i))
    end
end


function MapLoaderSolo:createGenerators(map)
    for i,j in pairs(map.objects) do
        local g =GeneratorSolo.new({x=(j.x),y=(j.y)},true,j.type,j.properties["id"],i)
        self.magnetManager:addGenerator(g)
        table.insert(self.generators,g)
    end
end

function MapLoaderSolo:createInterruptors(map)
    for i,j in pairs(map.objects) do
        table.insert(self.interruptors, InterruptorSolo.new({x=(j.x),y=(j.y)},true,j.properties["id"],self.magnetManager,j.properties["image"],i))
    end
end

function MapLoaderSolo:createGateInterruptors(map)
    for i,j in pairs(map.objects) do
        table.insert(self.gateinterruptors, GateInterruptorSolo.new({x=(j.x),y=(j.y)},true,j.properties["openid"],j.properties["closeid"],self,j.properties["enabled"],i))
    end
end

function MapLoaderSolo:createGates(map)
    for i,j in pairs(map.objects) do
        table.insert(self.gates, GateSolo.new({x=(j.x),y=(j.y)},j.width,j.height,j.properties["openid"],j.properties["closeid"],j.properties["prev"],j.properties["next"],j.properties["animid"],j.properties["enabled"],j.properties["type"],self,i));
    end
end

function MapLoaderSolo:createAcids(map)
    for i,j in pairs(map.objects) do
        table.insert(self.acids, AcidSolo.new({x=(j.x),y=(j.y)},j.width,j.height,j.properties["type"],i))
    end
end

function MapLoaderSolo:createLevelEnds(map)
    for i,j in pairs(map.objects) do
        table.insert(self.levelends, LevelEndSolo.new({x=(j.x),y=(j.y)},j.width,j.height,j.properties["next"]))
    end
end

function MapLoaderSolo:createArcs(map)
    for i,j in pairs(map.objects) do
        table.insert(self.arcs, ArcSolo.new({x=(j.x),y=(j.y)},j.width,j.height,j.properties["type"],i))
    end
end


function MapLoaderSolo:createMetals(map)
    for i,j in pairs(map.objects) do
        local m =MetalSolo.new({x=j.x,y=j.y},j.shape,j.properties["physic"],j.type,j.properties["magnet"],i)
        self.magnetManager:addMetal(m)        
        table.insert(self.metals,m)
    end
end

function MapLoaderSolo:update(dt)

    for i,b in pairs(self.destroyables) do
          b:update(dt)
    end

    for i,p in pairs(self.platforms) do
        p:update(dt)
    end

    for i,p in pairs(self.metals) do
        p:update(dt)
    end

    for i,p in pairs(self.walls) do
        p:update(dt)
    end

    for i,p in pairs(self.movables) do
        p:update(dt)
    end

    for i,p in pairs(self.interruptors) do
        p:update(dt)
    end

    for i,p in pairs(self.generators) do
        p:update(dt)
    end
    
    for i,p in pairs(self.gateinterruptors) do
        p:update(dt)
    end    

    for i,p in pairs(self.gates) do
        p:update(dt)
    end

    for i,p in pairs(self.acids) do
        p:update(dt)
    end

    for i,p in pairs(self.arcs) do
        p:update(dt)
    end
    for i,p in pairs(self.levelends) do
        p:update(dt)
    end
end


function MapLoaderSolo:init()

    for i,b in pairs(self.destroyables) do
          b:init()
    end

    for i,p in pairs(self.platforms) do
        p:init()
    end

    for i,p in pairs(self.metals) do
        p:init()
    end

    for i,p in pairs(self.walls) do
        p:init()
    end

    for i,p in pairs(self.movables) do
        p:init()
    end

    for i,p in pairs(self.interruptors) do
        p:init()
    end

    for i,p in pairs(self.generators) do
        p:init()
    end
    
    for i,p in pairs(self.gateinterruptors) do
        p:init()
    end    

    for i,p in pairs(self.gates) do
        p:init()
    end

    for i,p in pairs(self.acids) do
        p:init()
    end

    -- for i,p in pairs(self.arcs) do
    --     p:init(dt)
    -- end
    -- for i,p in pairs(self.levelends) do
    --     p:init(dt)
    -- end
end

function MapLoaderSolo:isSeen(pos1,pos2,w,h)
    if (pos1.x-pos2.x-w)>(windowW/2) or (pos1.x-pos2.x)<(-windowW/2) or (pos1.y-pos2.y-h)>(windowH/2) or (pos1.y-pos2.y)<(-windowH/2) then
        return false
    else
        return true
    end
end

function MapLoaderSolo:draw(pos)
    
    for i,p in pairs(self.tilesets) do
            p:draw({x=pos.x-windowW/2,y=windowH/2-pos.y})
    end
    for i,p in pairs(self.metals) do
        if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
          p:draw(pos.x-windowW/2,windowH/2-pos.y)
        end
	end

    for i,p in pairs(self.destroyables) do
        if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
          p:draw(pos.x-windowW/2,windowH/2-pos.y)
        end
    end

	for i,p in pairs(self.platforms) do
        if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
          p:draw(pos.x-windowW/2,windowH/2-pos.y)
        end
    end

	for i,p in pairs(self.walls) do
        if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
          p:draw(pos.x-windowW/2,windowH/2-pos.y)
        end
    end

    for i,p in pairs(self.movables) do
        if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
          p:draw(pos.x-windowW/2,windowH/2-pos.y)
        end
    end

    for i,p in pairs(self.interruptors) do
        if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
          p:draw(pos.x-windowW/2,windowH/2-pos.y)
        end
    end

    for i,p in pairs(self.generators) do
        if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
          p:draw(pos.x-windowW/2,windowH/2-pos.y)
        end
    end
    
    for i,p in pairs(self.gateinterruptors) do
        if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
          p:draw(pos.x-windowW/2,windowH/2-pos.y)
        end
    end    


end




function MapLoaderSolo:firstPlanDraw(pos)
 
    for i,p in pairs(self.acids) do
        if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
          p:draw(pos.x-windowW/2,windowH/2-pos.y)
        end
    end


    for i,p in pairs(self.arcs) do
        if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
          p:draw(pos.x-windowW/2,windowH/2-pos.y)
        end
    end

    for i,p in pairs(self.gates) do
        if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
          p:draw(pos.x-windowW/2,windowH/2-pos.y)
        end
    end
end

function MapLoaderSolo:openG(id)
    for i,p in pairs(self.gates) do
        if(p.openID==id) then
            p:openG()
        end
    end
end

function MapLoaderSolo:closeG(id)
    for i,p in pairs(self.gates) do
        if(p.closeID==id) then
            p:closeG()
        end
    end
end

function MapLoaderSolo:openPG(id)
    for i,p in pairs(self.gates) do
        if(p.animid==id) then
            p:openG()
        end
    end
end

function MapLoaderSolo:closeNG(id)
    for i,p in pairs(self.gates) do
        if(p.animid==id) then
            p:closeG()
        end
    end
end

function MapLoaderSolo:handleTry(tryer)
    for i,p in pairs(self.interruptors) do
        p:handleTry(tryer)
    end    
    for i,p in pairs(self.gateinterruptors) do
        p:handleTry(tryer)
    end    
end

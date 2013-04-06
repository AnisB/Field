--[[ 
This file is part of the Field project
]]


require("game.platform")
require("game.camera")
require("const")
require("game.wall")
require("game.destroyable")
require("game.tilesets")
require("game.movable")
require("game.gateinterruptor")
require("game.gate")
require("game.acid")
require("game.arc")
require("game.levelend")


MapLoader = {}
MapLoader.__index =  MapLoader

function MapLoader.new(MapLoaderFile,magnetManager)
    local self = {}
    setmetatable(self, MapLoader)
    self.map = require(MapLoaderFile)
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

    -- self.metalManPos={}
    -- self.theMagnetPos={}

    for i,d in pairs(self.map.layers) do
        if d.name=="wall" then
            self:createWalls(d)
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
                elseif  d.name=="themagnet" then
                -- Gestion de position
                self.theMagnetPos={x=d.objects[1].x,y=d.objects[1].y}             
            end    
            
    end
    -- Creation du Layer
    self.tilesets= Tilesets.new(self.map.tilesets,self.map.layers[1])

    return self
end


function MapLoader:createPlatforms(map)
    for i,j in pairs(map.objects) do
        table.insert(self.platforms, Platform.new({x=(j.x),y=(j.y)},j.width,nil,nil,nil))
    end
end



function MapLoader:createWalls(map)
    for i,j in pairs(map.objects) do
        table.insert(self.walls, Wall.new({x=(j.x),y=(j.y)},j.height,nil,nil,nil))
    end
end

function MapLoader:createMovables(map)
    for i,j in pairs(map.objects) do
        table.insert(self.movables, Movable.new({x=(j.x),y=(j.y)},j.shape, false,nil,i))
    end
end

function MapLoader:createDestroyables(map)
    for i,j in pairs(map.objects) do
        table.insert(self.destroyables, Destroyable.new({x=(j.x),y=(j.y)},j.shape,nil,j.width,j.height,i))
    end
end


function MapLoader:createGenerators(map)
    for i,j in pairs(map.objects) do
        local g =Generator.new({x=(j.x),y=(j.y)},true,j.type,j.properties["id"],i)
        self.magnetManager:addGenerator(g)
        table.insert(self.generators,g)
    end
end

function MapLoader:createInterruptors(map)
    for i,j in pairs(map.objects) do
        table.insert(self.interruptors, Interruptor.new({x=(j.x),y=(j.y)},true,j.properties["id"],self.magnetManager,j.properties["image"],i))
    end
end

function MapLoader:createGateInterruptors(map)
    for i,j in pairs(map.objects) do
        table.insert(self.gateinterruptors, GateInterruptor.new({x=(j.x),y=(j.y)},true,j.properties["id"],self,j.properties["enabled"],i))
    end
end

function MapLoader:createGates(map)
    for i,j in pairs(map.objects) do
        print("Door")
        table.insert(self.gates, Gate.new({x=(j.x),y=(j.y)},j.width,j.height,j.properties["id"],j.properties["enabled"],i));
    end
end

function MapLoader:createAcids(map)
    for i,j in pairs(map.objects) do
        print("acid")
        table.insert(self.acids, Acid.new({x=(j.x),y=(j.y)},j.width,j.height,j.properties["type"],i))
    end
end

function MapLoader:createLevelEnds(map)
    for i,j in pairs(map.objects) do
        table.insert(self.levelends, LevelEnd.new({x=(j.x),y=(j.y)},j.width,j.height,j.properties["next"]))
    end
end

function MapLoader:createArcs(map)
    for i,j in pairs(map.objects) do
        table.insert(self.arcs, Arc.new({x=(j.x),y=(j.y)},j.width,j.height,j.properties["type"],i))
    end
end


function MapLoader:createMetals(map)
    for i,j in pairs(map.objects) do
        print(j.properties["physic"])
        local m =Metal.new({x=j.x,y=j.y},j.shape,j.properties["physic"],j.type,j.properties["magnet"],i)
        self.magnetManager:addMetal(m)        
        table.insert(self.metals,m)
    end
end

function MapLoader:update(dt)

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
end

function MapLoader:isSeen(pos1,pos2,w,h)
    if (pos1.x-pos2.x-w)>(windowW/2) or (pos1.x-pos2.x)<(-windowW/2) or (pos1.y-pos2.y-h)>(windowH/2) or (pos1.y-pos2.y)<(-windowH/2) then
        return false
    else
        return true
    end
end
function MapLoader:draw(pos)
    self.tilesets:draw({x=pos.x-windowW/2,y=windowH/2-pos.y})

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

    for i,p in pairs(self.gates) do
        if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
          p:draw(pos.x-windowW/2,windowH/2-pos.y)
        end
    end
end

function MapLoader:toSend(pos)

    local returnSend=""
    for i,p in pairs(self.metals) do
        if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
          returnSend=returnSend..p:send(pos.x-windowW/2,windowH/2-pos.y)
        end
    end

    for i,p in pairs(self.destroyables) do
        if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
          returnSend=returnSend..p:send(pos.x-windowW/2,windowH/2-pos.y)
        end
    end

    for i,p in pairs(self.movables) do
        if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
          returnSend=returnSend..p:send(pos.x-windowW/2,windowH/2-pos.y)
        end
    end

    for i,p in pairs(self.interruptors) do
        if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
          returnSend=returnSend..p:send(pos.x-windowW/2,windowH/2-pos.y)
        end
    end

    for i,p in pairs(self.generators) do
        if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
          returnSend=returnSend..p:send(pos.x-windowW/2,windowH/2-pos.y)
        end
    end
    
    for i,p in pairs(self.gateinterruptors) do
        if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
          returnSend=returnSend..p:send(pos.x-windowW/2,windowH/2-pos.y)
        end
    end    

    for i,p in pairs(self.gates) do
        if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
          returnSend=returnSend..p:send(pos.x-windowW/2,windowH/2-pos.y)
        end
    end

    return returnSend
end

function MapLoader:firstPlanDraw(pos)
 
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
end

function MapLoader:openG(id)
    for i,p in pairs(self.gates) do
        if(p.id==id) then
            p:openG()
        end
    end
end

function MapLoader:closeG(id)
    for i,p in pairs(self.gates) do
        if(p.id==id) then
            p:closeG()
        end
    end
end

function MapLoader:handleTry()
    for i,p in pairs(self.interruptors) do
        p:handleTry()
    end    
    for i,p in pairs(self.gateinterruptors) do
        p:handleTry()
    end    
end

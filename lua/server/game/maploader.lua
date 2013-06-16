--[[ 
This file is part of the Field project
]]

-- Includes génériques
require("const")

require("game.platform")
require("game.camera")
require("game.wall")
require("game.destroyable")
require("game.tilesets")
require("game.movable")
require("game.gateinterruptor")
require("game.arcinterruptor")
require("game.gate")
require("game.acid")
require("game.arc")
require("game.levelend")
require("game.eventtimer")


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
    self.arcinterruptors={}
    self.gates={}
    self.metals={}
    self.acids={}
    self.arcs={}
    self.levelends={}
    self.allowedPowers={}
    self.timers={}



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
                elseif  d.name=="arcswitch" then
                -- Gestion des interrutpeurs de porte
                self:createArcInterruptors(d)

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
    -- -- Creation du Layer
    -- self.tilesets= Tilesets.new(self.map.tilesets,self.map.layers[1])

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
        table.insert(self.movables, Movable.new({x=(j.x),y=(j.y)},j.shape,i))
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
        table.insert(self.gateinterruptors, GateInterruptor.new({x=(j.x),y=(j.y)},true,j.properties["openid"],j.properties["closeid"],self,j.properties["enabled"],i))
    end
end

function MapLoader:createArcInterruptors(map)
    for i,j in pairs(map.objects) do
        table.insert(self.arcinterruptors, ArcInterruptor.new({x=(j.x),y=(j.y)},true,j.properties["id"],self,j.properties["enabled"],i))
    end
end


function MapLoader:createGates(map)
    for i,j in pairs(map.objects) do
        table.insert(self.gates, Gate.new({x=(j.x),y=(j.y)},j.width,j.height,j.properties["openid"],j.properties["closeid"],j.properties["prev"],j.properties["next"],j.properties["animid"],j.properties["enabled"],j.properties["type"],self,i));
    end
end

function MapLoader:createAcids(map)
    for i,j in pairs(map.objects) do
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
        local m =Metal.new({x=j.x,y=j.y},j.shape,j.properties["physic"],j.type,j.properties["magnet"],i)
        self.magnetManager:addMetal(m)        
        table.insert(self.metals,m)
    end
end


function MapLoader:createTimers(map)
    for i,j in pairs(map.objects) do
        local m =EventTimer.new(
            j.properties["id"],
            j.properties["duration"],
            j.properties["state"],
            j.properties["loop"],
            j.properties,
            self,
            self.magnetManager
            )       
        self.timers[j.properties["id"]] = m
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
     for i,p in pairs(self.arcinterruptors) do
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

    for i,p in pairs(self.timers) do
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
    for i,p in pairs(self.arcinterruptors) do
        if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
          p:draw(pos.x-windowW/2,windowH/2-pos.y)
        end
    end    
end

function MapLoader:toSend(pos)

	local maptable={}
    local metals=""
    for i,p in pairs(self.metals) do
        if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
			metals=metals..p:send(pos.x-windowW/2,windowH/2-pos.y)
        end
    end
	maptable.metal=metals

	local destroyables=""
    for i,p in pairs(self.destroyables) do
        if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
			destroyables=destroyables..p:send(pos.x-windowW/2,windowH/2-pos.y)
        end
    end
	maptable.destroyable=destroyables

	local movables=""
    for i,p in pairs(self.movables) do
        if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
			movables=movables..p:send(pos.x-windowW/2,windowH/2-pos.y)
        end
    end
	maptable.movable=movables

	local interruptors=""
    for i,p in pairs(self.interruptors) do
        if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
			interruptors=interruptors..p:send(pos.x-windowW/2,windowH/2-pos.y)
        end
    end
	maptable.interruptor=interruptors

	local generators=""
    for i,p in pairs(self.generators) do
        if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
			generators=generators..p:send(pos.x-windowW/2,windowH/2-pos.y).."#".."true"
        else
            generators=generators..p:send(pos.x-windowW/2,windowH/2-pos.y).."#".."false"
        end
    end
	maptable.generator=generators
    
	local gateinterruptors=""
    for i,p in pairs(self.gateinterruptors) do
        if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
			gateinterruptors=gateinterruptors..p:send(pos.x-windowW/2,windowH/2-pos.y)
        end
    end
	maptable.gateinterruptor=gateinterruptors    

    local arcinterruptors=""
    for i,p in pairs(self.arcinterruptors) do
        if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
            arcinterruptors=arcinterruptors..p:send(pos.x-windowW/2,windowH/2-pos.y)
        end
    end
    maptable.arcinterruptor=arcinterruptors  

	local gates=""
    for i,p in pairs(self.gates) do
        if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
			gates=gates..p:send(pos.x-windowW/2,windowH/2-pos.y)
        end
    end
	maptable.gate=gates

    local acids=""
    for i,p in pairs(self.acids) do
        if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
			acids=acids..p:send(pos.x-windowW/2,windowH/2-pos.y)
        end
    end
    maptable.acid=acids

    local arcs=""
    for i,p in pairs(self.arcs) do
        if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
			arcs=arcs..p:send(pos.x-windowW/2,windowH/2-pos.y)
        end
    end
    maptable.arc=arcs

    return maptable
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

    for i,p in pairs(self.gates) do
        if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
          p:draw(pos.x-windowW/2,windowH/2-pos.y)
        end
    end
end
function MapLoader:openG(id)
    for i,p in pairs(self.gates) do
        if(p.openID==id) then
            p:openG()
            done = true
        end
    end
    if done then
        for i,p in pairs(self.gateinterruptors) do
            if(p.gateOpenID==id) then
                p:syncronizeState(true)
            end
        end
    end
end

function MapLoader:closeG(id)
    for i,p in pairs(self.gates) do
        if(p.closeID==id) then
            p:closeG()
            done = true
        end
    end
    if done then
        for i,p in pairs(self.gateinterruptors) do
            if(p.gateCloseID==id) then
                p:syncronizeState(false)
            end
        end
    end
end

function MapLoader:openPG(id)
    for i,p in pairs(self.gates) do
        if(p.animid==id) then
            p:openG()
        end
    end
end

function MapLoader:closeNG(id)
    for i,p in pairs(self.gates) do
        if(p.animid==id) then
            p:closeG()
        end
    end    
end


-- Actions sur les timers


function MapLoader:enableT(id)
    for i,p in pairs(self.timers) do
        if(p.id==id) then
            p.enabled = true
            done = true
        end
    end
end

function MapLoader:disableT(id)
    for i,p in pairs(self.timers) do
        if(p.id==id) then
            p.enabled = false
            done = true
        end
    end
end

function MapLoader:switchT(id)
    for i,p in pairs(self.timers) do
        if(p.id==id) then
            p.enabled = not p.enabled
        end
    end
end


-- Actions sur les arcs


function MapLoader:enableA(id)
    for i,p in pairs(self.arcs) do
        if(p.id==id) then
            p:activateA()
            done = true
        end
    end
    if done then
        for i,p in pairs(self.arcinterruptors) do
            if(p.arcID==id) then
                p:syncronizeState(true)
            end
        end
    end
end

function MapLoader:disableA(id)
    for i,p in pairs(self.arcs) do
        if(p.id==id) then
            p:disableA()
            done = true
        end
    end
    if done then
        for i,p in pairs(self.arcinterruptors) do
            if(p.arcID==id) then
                p:syncronizeState(false)
            end
        end
    end
end

function MapLoader:switchA(id)
    for i,p in pairs(self.arcs) do
        if(p.id==id) then
             if p.enabled then
                p:disableA()
                newState = false
            else
                p:activateA()
                newState = true
            end
            done = true
        end
    end
    if done then
        for i,p in pairs(self.arcinterruptors) do
            if(p.arcID==id) then
                p:syncronizeState(newState)
            end
        end
    end
end




-- Interraction des joueurs

function MapLoader:handleTry(tryer)
    for i,p in pairs(self.interruptors) do
        p:handleTry(tryer)
    end    
    for i,p in pairs(self.gateinterruptors) do
        p:handleTry(tryer)
    end  
    for i,p in pairs(self.arcinterruptors) do
        p:handleTry(tryer)
    end    
end
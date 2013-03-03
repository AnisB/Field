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
    self.interruptors={}
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
                -- Gestion des generateurs
                self:createInterruptors(d)
                elseif  d.name=="metal" then
                -- Gestion des generateurs
                self:createInterruptors(d)    
            end    
            
    end
    -- Creation du Layer
    self.tilesets= Tilesets.new(self.map.tilesets,self.map.layers[1])

    return self
end


function MapLoader:createBlocs(map)

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
        table.insert(self.movables, Movable.new({x=(j.x),y=(j.y)},'Sphere', false,nil))
    end
end

function MapLoader:createDestroyables(map)
    for i,j in pairs(map.objects) do
        table.insert(self.destroyables, Destroyable.new({x=(j.x),y=(j.y)},'Rectangle',nil))
    end
end


function MapLoader:createGenerators(map)
    for i,j in pairs(map.objects) do
        local g =Generator.new({x=(j.x),y=(j.y)},true)
        self.magnetManager:addGenerator(g)
        table.insert(self.generators,g)
    end
end

function MapLoader:createInterruptors(map)
    for i,j in pairs(map.objects) do
        table.insert(self.interruptors, Interruptor.new({x=(j.x),y=(j.y)},'Rectangle',j.generator,self.magnetManager))
    end
end

function MapLoader:createMetals(map)
    for i,j in pairs(map.objects) do
        local m =Metal.new({x=(j.x),y=(j.y)},'Rectangle',false,'Acier')
        self.magnetManager:addMetal(m)        
        table.insert(self.metals,m)
    end
end

function MapLoader:update(dt)
end

function MapLoader:isSeen(pos1,pos2)
    if (pos1.x-pos2.x)>windowH/2 then
        print("out")
    else
        print("in")
    end
    return true
end
function MapLoader:draw(pos)
    self.tilesets:draw({x=pos.x-windowW/2,y=windowH/2-pos.y})
    for i,b in pairs(self.destroyables) do
          b:draw(pos.x-windowW/2,windowH/2-pos.y)
	end

	for i,p in pairs(self.platforms) do
		p:draw(pos.x-windowW/2,windowH/2-pos.y)
	end

	for i,p in pairs(self.walls) do
		p:draw(pos.x-windowW/2,windowH/2-pos.y)
	end

    for i,p in pairs(self.movables) do
        p:draw(pos.x-windowW/2,windowH/2-pos.y)
    end

end


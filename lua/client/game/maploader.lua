--[[ 
This file is part of the Field project
]]


require("game.platform")
require("game.metal")
require("const")
require("game.wall")
require("game.destroyable")
require("game.tilesets")
require("game.movable")
require("game.gateinterruptor")
require("game.interruptor")
require("game.gate")
require("game.acid")
require("game.arc")
require("game.levelend")


MapLoader = {}
MapLoader.__index =  MapLoader

function MapLoader.new(MapLoaderFile)
    local self = {}
    setmetatable(self, MapLoader)
    self.map = require(MapLoaderFile)
    self.magnetManager=magnetManager

    -- Init
    self.destroyables={}
    self.movables={}
    self.generators={}
    self.interruptors={}
    self.gateinterruptors={}
    self.gates={}
    self.metals={}
    self.acids={}
    self.arcs={}

    -- Creation du Layer
    self.tilesets= Tilesets.new(self.map.tilesets,self.map.layers[1])

    return self
end


function MapLoader:update(dt)

    for i,b in pairs(self.destroyables) do
          b:update(dt)
    end


    for i,p in pairs(self.metals) do
        p:update(dt)
    end

    for i,p in pairs(self.movables) do
        p:update(dt)
    end

    for i,p in pairs(self.interruptors) do
        p:update(dt)
    end

    -- for i,p in pairs(self.generators) do
    --     p:update(dt)
    -- end
    
    -- for i,p in pairs(self.gateinterruptors) do
    --     p:update(dt)
    -- end    

    -- for i,p in pairs(self.gates) do
    --     p:update(dt)
    -- end

    -- for i,p in pairs(self.acids) do
    --     p:update(dt)
    -- end

    -- for i,p in pairs(self.arcs) do
    --     p:update(dt)
    -- end
end


function MapLoader:draw(pos)
    self.tilesets:draw({x=pos.x-windowW/2,y=windowH/2-pos.y})

    for i,p in pairs(self.metals) do
          p:draw()
	end

    for i,p in pairs(self.destroyables) do
          p:draw()
    end

    for i,p in pairs(self.movables) do
          p:draw()
    end

    for i,p in pairs(self.interruptors) do
          p:draw()
    end

 --    for i,p in pairs(self.generators) do
 --        if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
 --          p:draw(pos.x-windowW/2,windowH/2-pos.y)
 --        end
 --    end
    
    for i,p in pairs(self.gateinterruptors) do
          p:draw()
    end    

 --    for i,p in pairs(self.gates) do
 --        if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
 --          p:draw(pos.x-windowW/2,windowH/2-pos.y)
 --        end
 --    end
end


function MapLoader:handlePacket(maps)
    self.metals={}
    self.destroyables={}
    self.movables={}
    self.interruptors={}
    self.gateinterruptors={}
    if  maps.metal~=nil then
        print("not nil")
        for v in string.gmatch(maps.metal, "[^@]+") do
                t={}
                for d in string.gmatch(v, "[^#]+") do
                    table.insert(t,d)
                end
                table.insert(self.metals,Metal.new({x=tonumber(t[5]),y=tonumber(t[6])},t[2],t[3],tonumber(t[4])))

            end
    end

    if  maps.destroyable~=nil then
        for v in string.gmatch(maps.destroyable, "[^@]+") do
                t={}
                for d in string.gmatch(v, "[^#]+") do
                    table.insert(t,d)
                end
                table.insert(self.destroyables,Destroyable.new({x=tonumber(t[4]),y=tonumber(t[5])},t[2],tonumber(t[3])))
            end
    end

    if  maps.movable~=nil then
        for v in string.gmatch(maps.movable, "[^@]+") do
                t={}
                for d in string.gmatch(v, "[^#]+") do
                    table.insert(t,d)
                end
                table.insert(self.movables,Movable.new({x=tonumber(t[4]),y=tonumber(t[5])},t[2],tonumber(t[3])))
            end
    end

    if  maps.interruptor~=nil then
        for v in string.gmatch(maps.interruptor, "[^@]+") do
                t={}
                for d in string.gmatch(v, "[^#]+") do
                    table.insert(t,d)
                end
                table.insert(self.interruptors,Interruptor.new({x=tonumber(t[4]),y=tonumber(t[5])},t[2],tonumber(t[3])))
            end
    end


    if  maps.gateinterruptor~=nil then
        for v in string.gmatch(maps.gateinterruptor, "[^@]+") do
                t={}
                for d in string.gmatch(v, "[^#]+") do
                    table.insert(t,d)
                end
                table.insert(self.gateinterruptors,GateInterruptor.new({x=tonumber(t[4]),y=tonumber(t[5])},t[2],tonumber(t[3])))
            end
    end    

end
function MapLoader:firstPlanDraw(pos)
 
    -- for i,p in pairs(self.acids) do
    --     if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
    --       p:draw(pos.x-windowW/2,windowH/2-pos.y)
    --     end
    -- end


    -- for i,p in pairs(self.arcs) do
    --     if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
    --       p:draw(pos.x-windowW/2,windowH/2-pos.y)
    --     end
    -- end
end
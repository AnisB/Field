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
require("game.generator")


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

for i,p in pairs(self.generators) do
    p:update(dt)
end

for i,p in pairs(self.gateinterruptors) do
    p:update(dt)
end    

    -- for i,p in pairs(self.gates) do
    --     p:update(dt)
    -- end

    for i,p in pairs(self.acids) do
        p:update(dt)
    end

    -- for i,p in pairs(self.arcs) do
    --     p:update(dt)
    -- end
end


function MapLoader:draw(pos)
    self.tilesets:draw({x=pos.x-windowW/2,y=windowH/2-pos.y})

    for i,p in pairs(self.metals) do
        if p.drawed==true then
          p:draw()
      end
  end

  for i,p in pairs(self.destroyables) do
    if p.drawed==true then
      p:draw()
  end
end

for i,p in pairs(self.movables) do
    if p.drawed==true then
      p:draw()
  end
end

for i,p in pairs(self.interruptors) do
    if p.drawed==true then
      p:draw()
  end
end

for i,p in pairs(self.generators) do

    if p.drawed==true then
      p:draw()
  end
end

for i,p in pairs(self.gateinterruptors) do
    if p.drawed==true then
      p:draw()
  end
end    
for i,p in pairs(self.acids) do
    if p.drawed==true then
      p:acids()
    end
end    
 --    for i,p in pairs(self.gates) do
 --        if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
 --          p:draw(pos.x-windowW/2,windowH/2-pos.y)
 --        end
 --    end
end


function MapLoader:handlePacket(maps)
    for i,p in pairs(self.metals) do
      p.drawed=false
  end

  for i,p in pairs(self.destroyables) do
      p.drawed=false
  end

  for i,p in pairs(self.movables) do
      p.drawed=false
  end

  for i,p in pairs(self.interruptors) do
      p.drawed=false
  end    
  for i,p in pairs(self.gateinterruptors) do
      p.drawed=false
  end
  for i,p in pairs(self.generators) do
      p.drawed=false
  end  
  for i,p in pairs(self.acids) do
      p.drawed=false
  end 


  if  maps.metal~=nil then
    for v in string.gmatch(maps.metal, "[^@]+") do
        t={}
        for d in string.gmatch(v, "[^#]+") do
            table.insert(t,d)
        end
        if self.metals[tonumber(t[2])]==nil then
            self.metals[tonumber(t[2])]=Metal.new({x=tonumber(t[6]),y=tonumber(t[7])},t[3],t[4],tonumber(t[5]))
        else
            self.metals[tonumber(t[2])]:syncronize({x=tonumber(t[6]),y=tonumber(t[7])},t[4],tonumber(t[5]))
        end
    end
end

if  maps.destroyable~=nil then
    for v in string.gmatch(maps.destroyable, "[^@]+") do
        t={}
        for d in string.gmatch(v, "[^#]+") do
            table.insert(t,d)
        end
        if self.destroyables[tonumber(t[2])]==nil then
            self.destroyables[tonumber(t[2])]=Destroyable.new({x=tonumber(t[5]),y=tonumber(t[6])},t[3],tonumber(t[4]))
        else
            self.destroyables[tonumber(t[2])]:syncronize({x=tonumber(t[5]),y=tonumber(t[6])},t[3],tonumber(t[4]))
        end
    end
end

if  maps.movable~=nil then
    for v in string.gmatch(maps.movable, "[^@]+") do
        t={}
        for d in string.gmatch(v, "[^#]+") do
            table.insert(t,d)
        end
        if self.movables[tonumber(t[2])]==nil then
            self.movables[tonumber(t[2])]=Movable.new({x=tonumber(t[5]),y=tonumber(t[6])},t[3],tonumber(t[4]))
        else
            self.movables[tonumber(t[2])]:syncronize({x=tonumber(t[5]),y=tonumber(t[6])},t[3],tonumber(t[4]))
        end
    end
end

if  maps.interruptor~=nil then
    for v in string.gmatch(maps.interruptor, "[^@]+") do
        t={}
        for d in string.gmatch(v, "[^#]+") do
            table.insert(t,d)
        end
        if self.interruptors[tonumber(t[2])]==nil then
            self.interruptors[tonumber(t[2])]=Interruptor.new({x=tonumber(t[5]),y=tonumber(t[6])},t[3],tonumber(t[4]))
        else
            self.interruptors[tonumber(t[2])]:syncronize({x=tonumber(t[5]),y=tonumber(t[6])},t[3],tonumber(t[4]))
        end
    end
end


if  maps.gateinterruptor~=nil then
    for v in string.gmatch(maps.gateinterruptor, "[^@]+") do
        t={}
        for d in string.gmatch(v, "[^#]+") do
            table.insert(t,d)
        end
        if self.gateinterruptors[tonumber(t[2])]==nil then
            self.gateinterruptors[tonumber(t[2])]=GateInterruptor.new({x=tonumber(t[5]),y=tonumber(t[6])},t[3],tonumber(t[4]))
        else
            self.gateinterruptors[tonumber(t[2])]:syncronize({x=tonumber(t[5]),y=tonumber(t[6])},t[3],tonumber(t[4]))
        end            
    end
end    

if  maps.generator~=nil then
    for v in string.gmatch(maps.generator, "[^@]+") do
        t={}
        for d in string.gmatch(v, "[^#]+") do
            table.insert(t,d)
        end
        print(v)
        if self.generators[tonumber(t[2])]==nil then
            self.generators[tonumber(t[2])]=Generator.new({x=tonumber(t[5]),y=tonumber(t[6])},t[8],t[3],tonumber(t[4]))
        else
            self.generators[tonumber(t[2])]:syncronize({x=tonumber(t[5]),y=tonumber(t[6])},t[8],t[3],tonumber(t[4]),t[7])
        end            
    end
end 

if  maps.acid~=nil then
    for v in string.gmatch(maps.acid, "[^@]+") do
        t={}
        for d in string.gmatch(v, "[^#]+") do
            table.insert(t,d)
        end
        if self.acid[tonumber(t[2])]==nil then
            self.acid[tonumber(t[2])]=Acid.new({x=tonumber(t[5]),y=tonumber(t[6])},t[3],t[4],tonumber(t[5]))
        else
            self.acid[tonumber(t[2])]:syncronize({x=tonumber(t[5]),y=tonumber(t[6])},t[4],tonumber(t[5]))
        end            
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
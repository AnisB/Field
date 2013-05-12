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
    self.map = require(MapLoaderFile.."-fieldmap/map")
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
    self.tilesets={}
  for i,d in pairs(self.map.layers) do
  	if d.name=="foreground" then
  		print("here"..MapLoaderFile)
  		table.insert(self.tilesets,Tilesets.new(self.map.tilesets,d,MapLoaderFile))
  			
  		elseif d.name=="Calque de Tile 1" then
  			table.insert(self.tilesets,Tilesets.new(self.map.tilesets,d,MapLoaderFile))
  		elseif d.name=="front" then
  			table.insert(self.tilesets,Tilesets.new(self.map.tilesets,d,MapLoaderFile))
  		end
end
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


function MapLoader:draw(pos)
    for i,p in pairs(self.tilesets) do
            p:draw({x=pos.x-windowW/2,y=windowH/2-pos.y})
    end
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
	
    for i,p in pairs(self.gates) do
    if p.drawed==true then
			p:draw()
        end
    end
	
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

	for i,p in pairs(self.arcs) do
		p.drawed=false
	end 
	for i,p in pairs(self.gates) do
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
			if self.generators[tonumber(t[2])]==nil then
				self.generators[tonumber(t[2])]=Generator.new({x=tonumber(t[5]),y=tonumber(t[6])},t[8],t[3],tonumber(t[4]))
			else
				self.generators[tonumber(t[2])]:syncronize({x=tonumber(t[5]),y=tonumber(t[6])},t[8],t[3],tonumber(t[4]),t[7],t[9])
			end            
		end
	end 

	if  maps.acid~=nil then
		for v in string.gmatch(maps.acid, "[^@]+") do
			t={}
			for d in string.gmatch(v, "[^#]+") do
				table.insert(t,d)
			end
			if self.acids[tonumber(t[2])]==nil then
				self.acids[tonumber(t[2])]=Acid.new({x=tonumber(t[6]),y=tonumber(t[7])},t[3],t[4],tonumber(t[5]))
			else
        if(t[8]=="true") then
          self.acids[tonumber(t[2])]:syncronizeSplash({x=tonumber(t[6]),y=tonumber(t[7])},t[4],tonumber(t[5]),{x=tonumber(t[11]),y=tonumber(t[12])},t[9],tonumber(t[10]))
        else
          self.acids[tonumber(t[2])]:syncronize({x=tonumber(t[6]),y=tonumber(t[7])},t[4],tonumber(t[5]))
        end
			end            
		end
	end


	if  maps.arc~=nil then
		for v in string.gmatch(maps.arc, "[^@]+") do
			t={}
			for d in string.gmatch(v, "[^#]+") do
				table.insert(t,d)
			end
			if self.arcs[tonumber(t[2])]==nil then
				self.arcs[tonumber(t[2])]=Arc.new({x=tonumber(t[6]),y=tonumber(t[7])},t[3],t[4],tonumber(t[5]))
			else
				self.arcs[tonumber(t[2])]:syncronize({x=tonumber(t[6]),y=tonumber(t[7])},t[4],tonumber(t[5]))
			end            
		end
	end

	if  maps.gate~=nil then
		for v in string.gmatch(maps.gate, "[^@]+") do
			t={}
			for d in string.gmatch(v, "[^#]+") do
				table.insert(t,d)
			end
			if self.gates[tonumber(t[2])]==nil then
				print(v)
				self.gates[tonumber(t[2])]=Gate.new({x=tonumber(t[6]),y=tonumber(t[7])},t[3],t[4],tonumber(t[5]),tonumber(t[8]),tonumber(t[9]))
			else
				self.gates[tonumber(t[2])]:syncronize({x=tonumber(t[6]),y=tonumber(t[7])},t[4],tonumber(t[5]))
			end            
		end
	end 
end

function MapLoader:firstPlanDraw(pos)

    for i,p in pairs(self.acids) do
		if p.drawed then
			p:draw()
        end
    end

    for i,p in pairs(self.arcs) do
		if p.drawed then
			p:draw()
        end
    end

end
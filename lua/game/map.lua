--[[ 
This file is part of the Field project
]]


require("game.platform")
require("game.bloc")
require("game.camera")
require("game.sphere")
require("const")
require("game.wall")
require("game.destructs")

Map = {}
Map.__index =  Map

function Map.new(mapFile,cam)
    local self = {}
    setmetatable(self, Map)
    self.camera = cam
    self.file = love.filesystem.newFile(mapFile)
	self.file:open('r')
	self.lines = self.file:lines()
	self.invmap ={}
	local i=1
	for l in self.lines do
          self.invmap[i]={}
          	j =1
			for token in string.gmatch(l, "[^%s]+") do
				-- print(token..i..j)
			   self.invmap[i][j]=token
			   j=j+1
			end
          i=i+1
    end
    self.map={}
    for i=1,#self.invmap[1],1 do
    	self.map[i]={}
    end

    for i=1,#self.invmap,1 do
    	for j=1,#self.invmap[i],1 do
    		self.map[j][i]=self.invmap[i][j]
    	end
    end
    self.nc=#self.map[1]
    self.nl=#self.map

    -- for i=1,#self.map[1],1 do
    -- 	local l=" "
    -- 	for j=1,#self.map,1 do
    -- 		l=(l.." "..self.map[j][i])
    -- 	end
    -- 	print(l)
    -- end


    --     for i=1,#self.invmap[1],1 do
    -- 	local l=" "
    -- 	for j=1,#self.invmap,1 do
    -- 		l=(l.." "..self.invmap[j][i])
    -- 	end
    -- 	print(l)
    -- end

    
    -- Gestion des blocs
    self.blocs={}
    self:createBlocs(self.map)


    -- Gestion des platformes
    self.platforms={}
    self:createPlatforms(self.invmap)
    

    -- Gestion des Sphere
    self.spheres={}
    self:createSpheres(self.map)

    -- Gestion des Murs
    self.walls ={}
    self:createWalls(self.map)

    -- Gestion des Desctrutibles
    self.destrucs ={}
    self:createDestructs(self.map)


    -- for k = 1, 2,1 do
    -- 	    for q = 1, 4,1 do
    -- 	    	print(self.map[k][q])
    -- 	    end
    -- end


    return self
end


function Map:createBlocs(map)
     for k = 1, #map,1 do
     	for j = 1, #map[k],1 do
     		if map[k][j]=="C" then
     			local pos= {x=(k -1)*unitWorldSize,y=(j -1)*unitWorldSize}
     			table.insert(self.blocs, Bloc.new(pos,nil))
     		end
     	end
     end
end


function Map:createDestructs(map)
     for k = 1, #map,1 do
        for j = 1, #map[k],1 do
            if map[k][j]=="K" then
                local pos= {x=(k -1)*unitWorldSize,y=(j -1)*unitWorldSize}
                table.insert(self.blocs, Destructs.new(pos,nil))
            end
        end
     end
end


function Map:createPlatforms(map)
     for k = 1, #map,1 do
     	local j=1
     	while j <= #map[k] do
     		if map[k][j] =="P" then

     			local c=0
     			local pbx=k
     			local pby=j
     			while j <= #map[k] and map[k][j] =="P" do
     				c=c+1
     				j=j+1
     			end

     			local position = {x=(pby-1)*unitWorldSize, y=(pbx-1)*unitWorldSize}
     			table.insert(self.platforms, Platform.new(position,c*unitWorldSize,nil,nil,nil))
     		end
     		j=j+1
     	end
     end
end


function Map:createSpheres(map)
     for k = 1, #map,1 do
     	for j = 1, #map[k],1 do
     		if map[k][j]=="S" then
     			local pos= {x=(k-1)*unitWorldSize,y=(j-1)*unitWorldSize}
     			table.insert(self.spheres, Sphere.new(pos,nil))
     		end
     	end
     end
end

function Map:createWalls(map)
     for k = 1, #map,1 do
     	local j=1
     	while j <= #map[k] do
     		if map[k][j] =="W" then
     			local c=0
     			local pbx=k
     			local pby=j
     			while j <= #map[k] and map[k][j] =="W" do
     				c=c+1
     				j=j+1
     			end
     			local position ={x=(pbx-1)*unitWorldSize, y=(pby-1)*unitWorldSize}
     			table.insert(self.walls, Wall.new(position,c*unitWorldSize,nil,nil,nil))
     		end
     		j=j+1
     	end
     end
end


function Map:update(dt)
end


function Map:draw(pos)

    for i,b in ipairs(self.blocs) do
		b:draw(pos.x-windowW/2,windowH/2-pos.y)
	end

	for i,p in ipairs(self.platforms) do
		p:draw(pos.x-windowW/2,windowH/2-pos.y)
	end

	for i,p in ipairs(self.walls) do
		p:draw(pos.x-windowW/2,windowH/2-pos.y)
	end

	for i,p in ipairs(self.spheres) do
		p:draw(pos.x-windowW/2,windowH/2-pos.y)
	end
end


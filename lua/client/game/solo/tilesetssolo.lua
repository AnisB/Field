--[[ 
This file is part of the Field project
]]


TilesetsSolo = {}
TilesetsSolo.__index =  TilesetsSolo

function TilesetsSolo.new(tile,layer,map)
    local self = {}
    setmetatable(self, TilesetsSolo)
    self.layer=layer
    self.tiles ={}
    self:getTiles(tile,map)
    self.map=map
    return self
end

function TilesetsSolo:getTiles(tiles,map)
	for i,v in pairs(tiles) do
		local tile ={}
		tile.id = v.firstgid
		tile.img = love.graphics.newImage("maps/"..map..".fieldmap/"..v.image)
		table.insert(self.tiles,tile)
	end
end


function TilesetsSolo:update(dt)
end


function TilesetsSolo:draw(pos)
	for i=0,self.layer.height-1,1 do
		for j=1,self.layer.width,1 do
			if self.layer.data[i*self.layer.width+j]>0 then
				
				love.graphics.draw(self.tiles[self.layer.data[i*self.layer.width+j]].img, (j-1)*64-pos.x, (i)*64+pos.y)
			end
		end
	end
end
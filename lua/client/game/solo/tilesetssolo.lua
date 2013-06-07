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
		tile.quad= love.graphics.newQuad(0, 0, v.tilewidth, v.tileheight, v.tilewidth*2, v.tileheight)
		tile.width=v.tilewidth
		tile.height=v.tileheight

		table.insert(self.tiles,tile)
		gameStateManager.loader.newImage(self.tiles[tile.id] ,"img", map.."-fieldmap/"..v.image)
	end
end


function TilesetsSolo:update(dt)
end


function TilesetsSolo:draw(pos)
	for i=0,self.layer.height-1,1 do
		for j=1,self.layer.width,1 do
			if self.layer.data[i*self.layer.width+j]>0 then
				tmp=self.tiles[self.layer.data[i*self.layer.width+j]]
				love.graphics.drawq(tmp.img,tmp.quad, (j-1)*64-pos.x, (i)*64+pos.y)
			end
		end
	end
end
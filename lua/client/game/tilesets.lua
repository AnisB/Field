--[[ 
This file is part of the Field project
]]


Tilesets = {}
Tilesets.__index =  Tilesets

Tilesets.sprites={}

function Tilesets.new(tile,layer,map)
    local self = {}
    setmetatable(self, Tilesets)
    self.layer=layer
    self.tiles ={}
    self.map=map
    self:getTiles(tile,map)
    return self
end

function Tilesets:getTiles(tiles)
	for i,v in pairs(tiles) do
		local tile ={}
		tile.id = v.firstgid
		if Tilesets.sprites [self.map.."-fieldmap/"..v.image] == nil then
			Tilesets.sprites [self.map.."-fieldmap/"..v.image] = love.graphics.newImage(self.map.."-fieldmap/"..v.image)
		end
		tile.img = Tilesets.sprites [self.map.."-fieldmap/"..v.image]
		tile.quad= love.graphics.newQuad(0, 0, v.tilewidth, v.tileheight, v.tilewidth*2, v.tileheight)
		tile.width=v.tilewidth
		tile.height=v.tileheight

		table.insert(self.tiles,tile)
	end
end


function Tilesets:update(dt)
end


function Tilesets:draw(pos)
	for i=0,self.layer.height-1,1 do
		for j=1,self.layer.width,1 do
			if self.layer.data[i*self.layer.width+j]>0 then
				tmp=self.tiles[self.layer.data[i*self.layer.width+j]]
				love.graphics.drawq(tmp.img,tmp.quad, (j-1)*64-pos.x, (i)*64+pos.y)
			end
		end
	end
end
--[[ 
This file is part of the Field project
]]


Tilesets = {}
Tilesets.__index =  Tilesets

function Tilesets.new(tile,layer)
    local self = {}
    setmetatable(self, Tilesets)
        print("lol"..#tile)
    self.layer=layer
    print(layer.name)
    self.tiles ={}
    self:getTiles(tile)
    return self
end

function Tilesets:getTiles(tiles)
	for i,v in pairs(tiles) do
		local tile ={}
		tile.id = v.firstgid
		print("Image "..v.name)
		tile.img = love.graphics.newImage("maps/"..v.image)
		table.insert(self.tiles,tile)
	end
end


function Tilesets:update(dt)
end


function Tilesets:draw(pos)
	for i=0,self.layer.height-1,1 do
		for j=1,self.layer.width-1,1 do
			if self.layer.data[i*20+j]>0 then
				love.graphics.draw(self.tiles[self.layer.data[i*20+j]].img, (j-1)*32-pos.x, (i)*32+pos.y)
			end
		end
	end
end
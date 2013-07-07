--[[ 
This file is part of the Field project
]]


TilesetsSolo = {}
TilesetsSolo.__index =  TilesetsSolo

TilesetsSolo.sprites = { }


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

		if v.properties["anim"] == "true" then
			tile.anim = true
			table.insert(self.tiles,tile)
			local k = string.sub(v.image, 0,-5)
			tile.img = BasicAnim.newExternal(map.."-fieldmap/"..k,true,0.3,tonumber(v.properties["frames"]))

		else
			tile.anim = false
			if (TilesetsSolo.sprites[map.."-fieldmap/"..v.image] ==nil) then
				gameStateManager.loader.newImage(TilesetsSolo.sprites ,map.."-fieldmap/"..v.image, map.."-fieldmap/"..v.image)
			else
			end
			tile.img = map.."-fieldmap/"..v.image
			table.insert(self.tiles,tile)
		end

	end
end

function TilesetsSolo:init()
	for i,v in pairs(self.tiles) do
		if not v.anim then
			print(v.img)
			v.img = TilesetsSolo.sprites[v.img]
		end
	end
end

function TilesetsSolo:update(dt)
	for i,v in pairs(self.tiles) do
		if v.anim then
			v.img:update(dt)
		end
	end
end

function TilesetsSolo:draw(pos)
	print("Merde")
	for i=0,self.layer.height-1,1 do
		for j=1,self.layer.width,1 do
			if self.layer.data[i*self.layer.width+j]>0 then
				tmp=self.tiles[self.layer.data[i*self.layer.width+j]]
				if tmp.anim then
					love.graphics.drawq(tmp.img:getSprite(),tmp.quad, (j-1)*64-pos.x, (i)*64+pos.y)

				else
					print(tmp.img)
					print(tmp.quad)
					love.graphics.drawq(tmp.img,tmp.quad, (j-1)*64-pos.x, (i)*64+pos.y)
				end
			end
		end
	end
end
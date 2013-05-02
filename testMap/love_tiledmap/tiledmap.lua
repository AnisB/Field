-- loader for "tiled" map editor maps (.tmx,xml-based) http://www.mapeditor.org/
-- supports multiple layers
-- NOTE : function ReplaceMapTileClass (tx,ty,oldTileType,newTileType,fun_callback) end
-- NOTE : function TransmuteMap (from_to_table) end -- from_to_table[old]=new
-- NOTE : function GetMousePosOnMap () return gMouseX+gCamX-gScreenW/2,gMouseY+gCamY-gScreenH/2 end

kTileSize = 32
kMapTileTypeEmpty = 0
local floor = math.floor
local ceil = math.ceil

function TiledMap_Load (filepath,tilesize,spritepath_removeold,spritepath_prefix)
	spritepath_removeold = spritepath_removeold or "../"
	spritepath_prefix = spritepath_prefix or ""
	kTileSize = tilesize or 32
	gTileGfx = {}
	
	local tiletype,layers = TiledMap_Parse(filepath)
	print("lol")
	for i,m in pairs(tiletype) do print(i,m) end
	for i,m in pairs(layers) do print(i,m) end
end

function TiledMap_GetMapTile (tx,ty,layerid) -- coords in tiles
	local row = gMapLayers[layerid][ty]
	return row and row[tx] or kMapTileTypeEmpty
end

function TiledMap_DrawNearCam (camx,camy)
end


-- ***** ***** ***** ***** ***** xml parser


-- LoadXML from http://lua-users.org/wiki/LuaXml
function LoadXML(s)
  local function LoadXML_parseargs(s)
    local arg = {}
    string.gsub(s, "(%w+)=([\"'])(.-)%2", function (w, _, a)
  	arg[w] = a
    end)
    return arg
  end
  local stack = {}
  local top = {}
  table.insert(stack, top)
  local ni,c,label,xarg, empty
  local i, j = 1, 1
  while true do
    ni,j,c,label,xarg, empty = string.find(s, "<(%/?)([%w:]+)(.-)(%/?)>", i)
    if not ni then break end
    local text = string.sub(s, i, ni-1)
    if not string.find(text, "^%s*$") then
      table.insert(top, text)
    end
    if empty == "/" then  -- empty element tag
      table.insert(top, {label=label, xarg=LoadXML_parseargs(xarg), empty=1})
    elseif c == "" then   -- start tag
      top = {label=label, xarg=LoadXML_parseargs(xarg)}
      table.insert(stack, top)   -- new level
    else  -- end tag
      local toclose = table.remove(stack)  -- remove top
      top = stack[#stack]
      if #stack < 1 then
        error("nothing to close with "..label)
      end
      if toclose.label ~= label then
        error("trying to close "..toclose.label.." with "..label)
      end
      table.insert(top, toclose)
    end
    i = j+1
  end
  local text = string.sub(s, i)
  if not string.find(text, "^%s*$") then
    table.insert(stack[#stack], text)
  end
  if #stack > 1 then
    error("unclosed "..stack[stack.n].label)
  end
  return stack[1]
end


-- ***** ***** ***** ***** ***** parsing the tilemap xml file

local function getTilesets(node)
	local tiles = {}
	for k, sub in ipairs(node) do
		if (sub.label == "tileset") then
			tiles[tonumber(sub.xarg.firstgid)] = sub[1].xarg.source
		end
	end
	return tiles
end

local function getLayers(node)
	local layers = {}
	for k, sub in ipairs(node) do
		if (sub.label == "layer") then --  and sub.xarg.name == layer_name
			local layer = {}
			table.insert(layers,layer)
			width = tonumber(sub.xarg.width)
			i = 1
			j = 1
			for l, child in ipairs(sub[1]) do
				print(l,child)

				if (j == 1) then
					layer[i] = {}
				end
				layer[i][j] = tonumber(child.xarg.gid)
				j = j + 1
				if j > width then
					j = 1
					i = i + 1
				end
			end
		end
	end
	return layers
end

function TiledMap_Parse(filename)
	local xml = LoadXML(love.filesystem.read(filename))
	local tiles = getTilesets(xml[2])
	local layers = getLayers(xml[2])
	return tiles, layers
end


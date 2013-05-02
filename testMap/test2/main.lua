loader = require("atl.loader")



function love.load()

 -- Path to the tmx files. The file structure must be similar to how they are saved in Tiled
loader.path = "maps/"

 -- Loads the map file and returns it
map = loader.load("field.tmx")



-- Draws the map
map:draw()

-- Limits the drawing range of the map. Important for performance
map:setDrawRange(0,0,love.graphics.getWidth(), love.graphics.getHeight())

-- -- Automatically sets the drawing range to the size of the screen.
 map:autoDrawRange(tx, ty, scale, padding)

-- Accessing individual layers
--print("Mur",map.layers["mur"])
print("Map printing")
for a,k in pairs(map) do print(a,k) end-- A shortcut for accessing specific layers
map("mur")

-- -- Finding a specific tile
-- print(map.layers["mur"]:get(5,5))

-- -- A shortcut for finding a specific tile
-- map("layer name")(5,5)

-- -- Iterating over all tiles in a layer
-- for x, y, tile in map("mur"):iterate() do
--    print( string.format("Tile at (%d,%d) has an id of %d", x, y, tile.id) )
-- end

-- -- Iterating over all objects in a layer
-- for i, obj in pairs( map("object layer").objects ) do
--     print( "Hi, my name is " .. obj.name )
-- end

-- -- Find all objects of a specific type in all layers
-- for _, layer in pairs(map.objectgroups) do
--    if layer.class == "ObjectLayer" then
--         for k, obj in pairs(layer.objects) do
--         	print(obj.name)
--         for a, b in pairs(obj) do 

--         	--print(a,":",b)
--         end
--         	--print("An object")
--         end
--    end
-- end

-- -- draw the tile with the id 4 at (100,100)
-- map.tiles[4]:draw(100,100)

-- -- Access the tile's properties set by Tiled
-- map.tiles[4].properties

-- -- Turns off drawing of non-tiled objects.
-- map.drawObjects = false
end

function love.keyreleased( key )

end

function love.keypressed( key, unicode ) 

end

function love.update( dt )

end

function love.draw()

end

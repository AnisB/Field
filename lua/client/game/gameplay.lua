--[[ 
This file is part of the Field project]]

require("game.themagnet")
require("game.metalman")
require("game.camera")
require("game.maploader")
require("game.sound")
require("const")

Gameplay = {}
Gameplay.__index = Gameplay

function Gameplay.new(mapFile)
    local self = {}
    setmetatable(self, Gameplay)
        --Map
        self.mapLoader = MapLoader.new("maps.field2")
        
        --Characters
        self.metalMan = MetalMan.new()
        self.theMagnet = TheMagnet.new()
		self.keyPacket={}

    self.camera=Camera.new(0,0)


    return self
end

function Gameplay:reset()
    self.shouldEnd=false

        --Map
        self.mapLoader = MapLoader.new("maps.field2")
        
        --Characters
        self.metalMan = MetalMan.new()
        self.theMagnet = TheMagnet.new()
    end

    function Gameplay:handlePacket(packet)
        if  packet.themagnet~=nil then
            self.theMagnet:handlePacket(packet.themagnet)
        end
        if  packet.metalman~=nil then
            self.metalMan:handlePacket(packet.metalman)
        end
        if  packet.camera~=nil then
            self.camera:handlePacket(packet.camera)
        end        
        if  packet.map~=nil then
            self.mapLoader:handlePacket(packet.map)
        end
    end
    function Gameplay:finish()
    end

    function Gameplay:mousePressed(x, y, button)
    end
    
    function Gameplay:mouseReleased(x, y, button)
    end
    
    
    function Gameplay:keyPressed(inputKey, unicode)
		serveur:send({type="input", pck={character="metalMan", key=inputKey, state=true}})
    end

	
    function Gameplay:keyReleased(inputKey, unicode)
		serveur:send({type="input", pck={character="metalMan", key=inputKey, state=false}})
    end
    
    
    function Gameplay:update(dt)
        self.theMagnet:update(dt)
        self.metalMan:update(dt)
        self.mapLoader:update(dt)
    end
    
    
    function Gameplay:draw()
        self.mapLoader:draw(self.camera:getPos())
        self.theMagnet:draw()
        self.metalMan:draw()
        -- self.mapLoader:firstPlanDraw(self.cameraMM:getPos())
        love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)
    end
    

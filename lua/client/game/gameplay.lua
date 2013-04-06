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

    --     packet= {
    --     camera="@camera#1984#1184.6802978516",
    --     map={
    --     metal="@metal#acier#normal#1#256#326@metal#aluminium#normal#1#384#326@metal#static#normal#1#512#326",
    --     destroyable="@destroyable#normal#1#960#327@destroyable#normal#1#960#263@destroyable#normal#1#960#199@destroyable#normal#1#960#135@destroyable#normal#1#960#71@destroyable#normal#1#960#7@destroyable#normal#1#1024#7@destroyable#normal#1#1024#71@destroyable#normal#1#1024#135@destroyable#normal#1#1024#199@destroyable#normal#1#1024#263@destroyable#normal#1#1024#327@destroyable#normal#1#1088#7@destroyable#normal#1#1088#71@destroyable#normal#1#1088#135@destroyable#normal#1#1088#199@destroyable#normal#1#1088#263@destroyable#normal#1#1088#327",
    --     },
    --     metalman="@metalman#standing#3#608#328#1",
    --     themagnet="@themagnet#jumping#2#32#328#1"
    -- }

    --     packet= {
    --     camera="@camera#2782.0810546875#1184.6800537109",
    --     map={
    --     movable="@movable#normal#1#800#326@movable#normal#1#865#326@movable#normal#1#930#326@movable#normal#1#995#326@movable#normal#1#864#261@movable#normal#1#929#261@movable#normal#1#929#196@movable#normal#1#994#261@movable#normal#1#1060#326",
    --     metal="",
    --     destroyable="@destroyable#destroyed#1#143#327@destroyable#normal#1#143#263@destroyable#normal#1#143#199@destroyable#normal#1#143#135@destroyable#normal#1#143#71@destroyable#normal#1#143#7@destroyable#normal#1#207#7@destroyable#normal#1#207#71@destroyable#normal#1#207#135@destroyable#normal#1#207#199@destroyable#normal#1#207#263@destroyable#destroyed#1#207#327@destroyable#normal#1#271#7@destroyable#normal#1#271#71@destroyable#normal#1#271#135@destroyable#normal#1#271#199@destroyable#normal#1#271#263@destroyable#destroyed#1#271#327",
    --     },
    --     metalman="@metalman#metalman/static#standing#4#608#328#1",
    --     themagnet="@themagnet#jumping#1#436#191#1"
    -- }

    --     packet= {
    --     camera="@camera#1121.2181396484#1184.6802978516",
    --     map={
    --     -- movable="@movable#normal#1#800#326@movable#normal#1#865#326@movable#normal#1#930#326@movable#normal#1#995#326@movable#normal#1#864#261@movable#normal#1#929#261@movable#normal#1#929#196@movable#normal#1#994#261@movable#normal#1#1060#326",
    --     metal="@metal#acier#normal#2#690#326@metal#aluminium#normal#2#1246#326",
    --     -- destroyable="@destroyable#destroyed#1#143#327@destroyable#normal#1#143#263@destroyable#normal#1#143#199@destroyable#normal#1#143#135@destroyable#normal#1#143#71@destroyable#normal#1#143#7@destroyable#normal#1#207#7@destroyable#normal#1#207#71@destroyable#normal#1#207#135@destroyable#normal#1#207#199@destroyable#normal#1#207#263@destroyable#destroyed#1#207#327@destroyable#normal#1#271#7@destroyable#normal#1#271#71@destroyable#normal#1#271#135@destroyable#normal#1#271#199@destroyable#normal#1#271#263@destroyable#destroyed#1#271#327",
    --     interruptor="@interruptor#off#1#286#327",
    --     generator="@generator#off#1#670.78186035156#199.31970214844"
    --     },
    --     metalman="@metalman#metalman/acier#standing#6#672#328#-1",
    --     themagnet="@themagnet#field#1#200#328#1#true#Attractive"
    -- }
        packet= {
        camera="@camera#1039.1010742188#1184.6802978516",
        map={
        -- movable="@movable#normal#1#800#326@movable#normal#1#865#326@movable#normal#1#930#326@movable#normal#1#995#326@movable#normal#1#864#261@movable#normal#1#929#261@movable#normal#1#929#196@movable#normal#1#994#261@movable#normal#1#1060#326",
        metal="@metal#1#acier#normal#2#1200#326",
        -- destroyable="@destroyable#destroyed#1#143#327@destroyable#normal#1#143#263@destroyable#normal#1#143#199@destroyable#normal#1#143#135@destroyable#normal#1#143#71@destroyable#normal#1#143#7@destroyable#normal#1#207#7@destroyable#normal#1#207#71@destroyable#normal#1#207#135@destroyable#normal#1#207#199@destroyable#normal#1#207#263@destroyable#destroyed#1#207#327@destroyable#normal#1#271#7@destroyable#normal#1#271#71@destroyable#normal#1#271#135@destroyable#normal#1#271#199@destroyable#normal#1#271#263@destroyable#destroyed#1#271#327",
        interruptor="@interruptor#1#off#1#368#327",
        generator="@generator#1#off#1#752.89892578125#199.31970214844"
        },
        metalman="@metalman#metalman/alu#standing#3#672#328#-1",
        themagnet="@themagnet#standing#5#976#328#1#false#None"
    }

    self.camera=Camera.new(0,0)

    self:handlePacket(packet)

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
    
    
    function Gameplay:keyPressed(key, unicode)

    end



    function Gameplay:keyReleased(key, unicode)

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
    end
    

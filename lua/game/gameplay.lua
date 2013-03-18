--[[ 
This file is part of the Field project]]

require("game.themagnet")
require("game.metalman")
require("game.map")
require("game.camera")
require("game.magnetmanager")
require("game.generator")
require("game.metal")
require("game.maploader")
require("game.interruptor")
require("game.sound")
require("const")

    Gameplay = {}
    Gameplay.__index = Gameplay
    
    function Gameplay.new(mapFile)
        local self = {}
        setmetatable(self, Gameplay)
        Sound.playMusic("themeprincipal")

        -- Physics
        world = love.physics.newWorld( 0, 9*unitWorldSize, true )
        love.physics.setMeter( unitWorldSize) --the height of a meter our worlds will be 64px
        world:setCallbacks(beginContact, endContact, preSolve, postSolve)
        -- Custom physics
        self.magnetmanager = MagnetManager.new()

        --Map
        self.mapLoader = MapLoader.new("maps.map1",self.magnetmanager)

        -- Camera Metal Man
        self.cameraMM =Camera.new(0,0)
        -- Camera The Magnet
        self.cameraTM =Camera.new(0,0)

        
        --Characters
        self.metalMan = MetalMan.new(self.cameraMM,self.mapLoader.metalManPos)
        self.theMagnet = TheMagnet.new(self.cameraTM,self.mapLoader.theMagnetPos)
        self.magnetmanager:addGenerator(self.theMagnet)
        self.magnetmanager:addMetal(self.metalMan)

        -- Temp var
        self.drawWho=1


        return self
    end
    
    
    function Gameplay:mousePressed(x, y, button)
    end
    
    function Gameplay:mouseReleased(x, y, button)
    end
    
    
    function Gameplay:keyPressed(key, unicode)
    if key=="z" then
        self.metalMan:jump()     
    end
    if key=="up" then
        self.theMagnet:jump()
    end 

    if key =="i" then
        self.theMagnet:enableStaticField()
    end

    if key =="o" then
        self.theMagnet:enableAttractiveField()
    end
        if key =="p" then
        self.theMagnet:enableRepulsiveField()
    end

    if key =="k" then
        self.theMagnet:enableRotativeLField()
    end
    if key =="l" then
        self.theMagnet:enableRotativeRField()
    end

    if key =="e" then
        self.mapLoader:handleTry()
    end

    if key =="y" then
        self.drawWho= (self.drawWho+1)%2
    end

    if key =="b" then
        self.metalMan:changeMass()
    end
    if key =="d" then
        self.metalMan:startMove()
    end

    if key =="q" then
        self.metalMan:startMove()
    end


    if key =="left" then
        self.theMagnet:startMove()
    end

    if key =="right" then
        self.theMagnet:startMove()
    end

    if key=="n" then
        self.metalMan:switchType()
        self.magnetmanager:changeMetalType(self.metalMan,self.metalMan.oldMetal,self.metalMan.metalType)
    end

    end



    function Gameplay:keyReleased(key, unicode)
    if key =="i" then
        self.theMagnet:disableStaticField()
    end

    if key =="o" or key =="p" or key =="k"or key =="l"then
        self.theMagnet:disableField()
    end
    if key =="d" then
        self.metalMan:stopMove()
    end

    if key =="q" then
        self.metalMan:stopMove()
    end

    if key =="left" then
        self.theMagnet:stopMove()
    end

    if key =="right" then
        self.theMagnet:stopMove()
    end

    end
    
    
    function Gameplay:update(dt)

        -- Physics managers
        world:update(dt) 
        self.magnetmanager:update(dt)   

        -- Other stuff
        self.theMagnet:update(dt)
        self.metalMan:update(dt)
        self.mapLoader:update(dt)
    end
    
    function Gameplay:draw()
        if self.drawWho==1 then
            self.mapLoader:draw(self.cameraMM:getPos())
            self.theMagnet:secondDraw(self.cameraMM:getPos().x-windowW/2,windowH/2-self.cameraMM:getPos().y)
            self.metalMan:draw() 
        else
            self.mapLoader:draw(self.cameraTM:getPos())
            self.metalMan:secondDraw(self.cameraTM:getPos().x-windowW/2,windowH/2-self.cameraTM:getPos().y)
            self.theMagnet:draw() 
        end
    end
    
    
    function beginContact(a, b, coll)
        local x,y = coll:getNormal()
    b:getUserData():collideWith(a:getUserData(), coll)
    a:getUserData():collideWith(b:getUserData(), coll)

    end

    persisting = 0
    
function endContact(a, b, coll)
        local x,y = coll:getNormal()
    b:getUserData():unCollideWith(a:getUserData(), coll)
    a:getUserData():unCollideWith(b:getUserData(), coll)
    collectgarbage()
end

function preSolve(a, b, coll)
    local o1 = a:getUserData()
    local o2 = b:getUserData()

    if o1.preSolve then
    	o1:preSolve(o2, coll)
    end

    if o2.preSolve then
    	o2:preSolve(o1, coll)
    end
end

function Gameplay:postSolve(a, b, coll)
-- we won't do anything with this function
end

--[[ 
This file is part of the Field project]]

require("game.themagnet")
require("game.metalman")
require("game.map")
require("game.camera")
require("game.magnetmanager")
require("game.generateur")
require("game.magneticcube")
require("const")

    Gameplay = {}
    Gameplay.__index = Gameplay
    
    function Gameplay.new(mapFile)
        local self = {}
        setmetatable(self, Gameplay)
        world = love.physics.newWorld( 0, 9*unitWorldSize, true )
        love.physics.setMeter( unitWorldSize) --the height of a meter our worlds will be 64px
        world:setCallbacks(beginContact, endContact, preSolve, postSolve)
        self.camera =Camera.new(0,0)
        self.map= Map.new("mapFile.txt",self.camera)
        local pos1 ={ x=2*unitWorldSize,  y=10*unitWorldSize}
        self.metalMan = MetalMan.new(self.camera,pos1)
        self.CAMERASTEP=50
        local pos ={ x=4*unitWorldSize,  y=10*unitWorldSize}
        self.theMagnet = TheMagnet.new(nil,pos)
        self.magnetmanager = MagnetManager.new()
        self.magnetmanager:addGenerator(self.theMagnet)
        self.magnetmanager:addMetal(self.metalMan)
        self.generateur = Generateur.new({x=19*unitWorldSize,  y=15*unitWorldSize},true)
        self.magnetmanager:addGenerator(self.generateur)
        self.cube1=MagneticCube.new({x=15*unitWorldSize,  y=10*unitWorldSize}, false,MetalMTypes.Alu)
        self.cube2=MagneticCube.new({x=12*unitWorldSize,  y=15*unitWorldSize}, false,MetalMTypes.Acier)
        self.magnetmanager:addMetal(self.cube1)
        self.magnetmanager:addMetal(self.cube2)
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
        self.theMagnet:enableRepulsiveField()
    end
        if key =="p" then
        self.theMagnet:enableAttractiveField()
    end

    if key =="k" then
        self.theMagnet:enableRotativeLField()
    end
    if key =="l" then
        self.theMagnet:enableRotativeRField()
    end


    if key =="y" then
        self.generateur:enableRotativeLField()
    end

    if key =="b" then
        self.metalMan:changeMass()
    end


    if key=="n" then
        self.metalMan:switchType()
        print("Types old:"..self.metalMan.oldMetal.." "..self.metalMan.metalType)
        self.magnetmanager:changeMetalType(self.metalMan,self.metalMan.oldMetal,self.metalMan.metalType)
    end

    end



    function Gameplay:keyReleased(key, unicode)
    if key =="i" then
        self.theMagnet:disableStaticField()
    end

        if key =="y" then
        self.generateur:disableField()
    end

    if key =="o" or key =="p" or key =="k"or key =="l"then
        self.theMagnet:disableField()
    end


    end
    
    
    function Gameplay:update(dt)
        world:update(dt) 
        self.theMagnet:update(dt)
        self.metalMan:update(dt,self.camera)
         self.magnetmanager:update(dt)   
         self.generateur:update(dt)  
         self.cube1:update(dt)   
         self.cube2:update(dt)   
    end
    
    function Gameplay:draw()
        self.theMagnet:draw(self.camera:getPos().x-windowW/2,windowH/2-self.camera:getPos().y)
        self.metalMan:draw()
        self.camera:draw()
        self.map:draw(self.camera:getPos())
        self.generateur:draw(self.camera:getPos().x-windowW/2,windowH/2-self.camera:getPos().y)
        self.cube1:draw(self.camera:getPos().x-windowW/2,windowH/2-self.camera:getPos().y)   
        self.cube2:draw(self.camera:getPos().x-windowW/2,windowH/2-self.camera:getPos().y) 
    end
    
    
    function beginContact(a, b, coll)
        local x,y = coll:getNormal()
    b:getUserData():collideWith(a:getUserData(), coll)
    a:getUserData():collideWith(b:getUserData(), coll)

    end

    persisting = 0
    
function Gameplay:endContact(a, b, coll)
    persisting = 0    -- reset since they're no longer touching
    -- print ("\n"..tostring(a:getUserData()).." uncolliding with "..tostring(b:getUserData()))
end

function Gameplay:preSolve(a, b, coll)
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

--[[ 
This file is part of the Field project]]

-- Includes Persos
require("game.solo.themagnetsolo")
require("game.solo.metalmansolo")

-- Include Camera
require("game.solo.camerasolo")

-- Include physics
require("game.solo.magnetmanagersolo")

-- Inlclude objet managing
require("game.solo.maploadersolo")
require("game.sound")

-- Include Shaders
require("game.shader.bloomshadereffect")
require("game.shader.lightshader")
require("game.shader.backlightshader")

-- Inlcude Other
require("game.simplebackground")
require("game.ui.loadingscreen")
require("const")


CinematicSolo = {}
CinematicSolo.__index = CinematicSolo


function CinematicSolo.new(mapFile,continuous,player)
    local self = {}
    setmetatable(self, CinematicSolo)

    -- Vars
    self.continuous=continuous


    -- Physics
    love.physics.setMeter( unitWorldSize) --the height of a meter our worlds will be 64px
    world = love.physics.newWorld( 0, 18*unitWorldSize, false )
    world:setCallbacks(beginContact, endContact, preSolve, postSolve)

    -- Magnetics
    self.magnetmanager = MagnetManagerSolo.new()    


    --Map loading
    self.mapFile=mapFile
    self.mapLoader = MapLoaderSolo.new(mapFile,self.magnetmanager)


    -- Paralax Loading
    self.mapy= self.mapLoader.map.height*self.mapLoader.map.tileheight
    self.background1=Background.new(ParalaxImg.."1.png",1,self.mapy)
    self.background2=Background.new(ParalaxImg.."2.png",0.75,self.mapy)
    self.background3=Background.new(ParalaxImg.."3.png",0.5,self.mapy)
    self.background4=Background.new(ParalaxImg.."4.png",0.25,self.mapy)
    self.background5=SimpleBackground.new(ParalaxImg.."5.png",0.0,self.mapy)


    -- Player loading
    self.player= player
    if self.player=="metalman" then
        self.cameraMM =CameraSolo.new(0,0)
        self.metalMan = MetalManSolo.new(self.cameraMM,self.mapLoader.metalManPos,self.mapLoader.metalManPowers)
        self.magnetmanager:addMetal(self.metalMan)
    elseif self.player=="themagnet" then
        self.cameraTM =CameraSolo.new(0,0)
        self.theMagnet = TheMagnetSolo.new(self.cameraTM,self.mapLoader.theMagnetPos,self.mapLoader.theMagnetPowers)
        self.magnetmanager:addGenerator(self.theMagnet)
    end


    -- State Variables
    self.cinematicFinished=false

    -- Slow timer

    -- Shaders
        -- Bloom Shader
        self.bloom=CreateBloomEffect(1280,800)
        -- Light Shader
        self.lightback = BackLightShader.new()

        self.lightback:setParameter{
        light_pos = {windowW/2,windowH/2,30}
    }

        -- Light Shader
        self.light = LightShader.new()

        self.light:setParameter{
        light_pos = {windowW/2,windowH/2,30}
    }

    -- Init de Loading
    self.loadingScreen=LoadingScreen.new()

    -- Starting the multithreading loading
    local returnF = CinematicSolo.loadFinished
    self.loading=gameStateManager.loader.start(returnF, print)

    return self
end


    -- Fonction qui init l'état gameplay solo quand l'état est fini
    function CinematicSolo:loadFinished()
        local gp = gameStateManager.state["CinematicSolo"]
        gp:init()
    end


-- Initialisation de début de partie
    function CinematicSolo:init()
        -- Principalement les anims
        -- Init mapLoader
        self.mapLoader:init()

        -- Init character
        if self.player=="metalman" then
            self.metalMan:init()
        elseif self.player=="themagnet" then
            self.theMagnet:init()
        end
        self.loading=false
    end

    
    function CinematicSolo:finish()
        self.cinematicFinished=true
    end

    function CinematicSolo:slow()
        self.isSlowing=true
        self.slowTimer=0
    end



    function CinematicSolo:destroy()
        world:setCallbacks(nil, function() collectgarbage() end)
        world:destroy()
        world=nil
        world = love.physics.newWorld( 0, 18*unitWorldSize, false )
        world:setCallbacks(beginContact, endContact, preSolve, postSolve)
    end  

    function CinematicSolo:reset()
    end

    function CinematicSolo:failed()
        self.shouldEnd=true
    end    

    function CinematicSolo:setPaused(state)
        self.gameIsPaused=state
    end


    function CinematicSolo:mousePressed(x, y, button)
    end
    
    function CinematicSolo:mouseReleased(x, y, button)
    end
    

    function CinematicSolo:keyPressed(key, unicode)
        if not self.loading then
            if key=="return" then
                self.cinematicFinished=true
            end
            -- Pause
            if key =="u" then
                self:setPaused( not self.gameIsPaused)
            end   
        end
    end


    function CinematicSolo:keyReleased(key, unicode)
        if not self.loading then

        end
    end
    
    
    function CinematicSolo:update(dttheo)
        if  self.loading then
            gameStateManager.loader.update(dttheo)
            self.loadingScreen:update(dttheo)
        else

        if self.isSlowing then
            self.slowTimer =self.slowTimer +dttheo
            if self.slowTimer>=1 then
                self.slowTimer=1
                self.isSlowing=false
            end
        end
        dt=dttheo*self.slowTimer
        if  not self.gameIsPaused then
            if(self.cinematicFinished) then
			   -- inputManager:clearInputs()
               gameStateManager.state['LevelEndingSolo']=LevelEndingSolo.new(self.mapLoader.levelends[1].next,self.continuous)
               gameStateManager:changeState('LevelEndingSolo')
               return
           end

            world:update(dt) 
            self.magnetmanager:update(dt)   

          -- Other stuff
          if self.player=="metalman" then
            self.cameraMM:update(dt)
            self.metalMan:update(dt)
            elseif self.player=="themagnet" then
                self.cameraTM:update(dt)
                self.theMagnet:update(dt)
            end
            self.mapLoader:update(dt)

        end
    end
    end
    
    function CinematicSolo:draw()
        if  self.loading then
            self.loadingScreen:draw()
        else

        if self.gameIsPaused then
            love.graphics.setColor(100,100,100,255)
        end
        if self.player=="metalman" then

            self.metalMan:preDraw()

            self.background5:draw(self.cameraMM:getPos()) 
            self.metalMan:postDraw()

            self.bloom:predraw()
            self.lightback:predraw()

            self.background4:draw(self.cameraMM:getPos())
            self.background3:draw(self.cameraMM:getPos())
            self.background2:draw(self.cameraMM:getPos())
            self.background1:draw(self.cameraMM:getPos())
            self.lightback:postdraw()
            
            self.light:predraw()

            self.mapLoader:draw(self.cameraMM:getPos())

            self.metalMan:draw()
            self.mapLoader:firstPlanDraw(self.cameraMM:getPos())

            self.light:postdraw()
            self.bloom:postdraw() 
    
        elseif self.player=="themagnet" then

            self.background5:draw(self.cameraTM:getPos()) 
            self.background4:draw(self.cameraTM:getPos())
            self.bloom:predraw()

            self.lightback:predraw()

            self.background3:draw(self.cameraTM:getPos())
            self.background2:draw(self.cameraTM:getPos())
            self.background1:draw(self.cameraTM:getPos())

            self.mapLoader:draw(self.cameraTM:getPos())
            self.lightback:postdraw()

            self.light:predraw()
            self.theMagnet:draw() 
            
            self.mapLoader:firstPlanDraw(self.cameraTM:getPos())
            self.light:postdraw()
            self.bloom:postdraw() 
        end
    end

    love.graphics.setColor(255,255,255,255)
    end
    
    
    function beginContact(a, b, coll)
        local x,y = coll:getNormal()
        b:getUserData():collideWith(a:getUserData(), coll)
        a:getUserData():collideWith(b:getUserData(), coll)

    end
    
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

function CinematicSolo:postSolve(a, b, coll)
-- we won't do anything with this function
end

function CinematicSolo:shakeOnX(dx,speed,duration)
    if self.player=="metalman" then
        self.cameraMM:shakeOnX(dx,speed,duration)
    elseif self.player=="themagnet" then
        self.cameraTM:shakeOnX(dx,speed,duration)
    end
end

function CinematicSolo:shakeOnY(dy,speed,duration)
    if self.player=="metalman" then
        self.cameraMM:shakeOnY(dy,speed,duration)
    elseif self.player=="themagnet" then
        self.cameraTM:shakeOnY(dy,speed,duration)
    end
end
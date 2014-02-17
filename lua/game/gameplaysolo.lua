--[[ 
This file is part of the Field project]]

-- Includes Persos
require(CharacterDirectory.."themagnet")
require(CharacterDirectory.."metalman")

-- Include Camera
require("render.camera")

-- Include physics
require("game.solo.magnetmanagersolo")

-- Inlclude objet managing
require("game.solo.maploadersolo")
require("game.sound")

-- Include Shaders
require("shader.bloomshadereffect")
require("shader.lightshader")
require("shader.backlightshader")

-- Inlcude Other
require("game.simplebackground")
require("render.paralax")
require("ui.loadingscreen")
require("ui.pausemenu")


require("const")


GameplaySolo = {}
GameplaySolo.__index = GameplaySolo

Effects = {Arc = 1 , Acid = 2}
Direction = {Right = 1 , Left = 2}
GameplayEvents = {Die = 1 , Slow =2, Paralax = 3}


function GameplaySolo.new(mapFile,continuous,player)
    local self = {}
    setmetatable(self, GameplaySolo)

    -- Vars
    self.continuous=continuous

    -- Creation de la physique
    love.physics.setMeter(unitWorldSize) --the height of a meter our worlds will be 64px
    world = love.physics.newWorld( 0, 18*unitWorldSize, false )
    world:setCallbacks(beginContact, endContact, preSolve, postSolve)

    -- Creation du magnétisme
    self.magnetmanager = MagnetManagerSolo.new()    

    -- Indicateur du type de monde
    self.world = require(mapFile.."-fieldmap/info").world

    --Map loading
    self.mapFile=mapFile
    self.mapLoader = MapLoaderSolo.new(mapFile,self.magnetmanager)

    -- Paralax Loading
    self.paralax=Paralax.new(ParalaxImg..self.world, self.mapLoader.map.height*self.mapLoader.map.tileheight)

    self.acidShader = AfterEffect.new(ShaderDirectory.."blending.glsl")
    self.arcShader = AfterEffect.new(ShaderDirectory.."blending.glsl")
    self.acidShader:inject("filter", "img/death/"..self.world.."/acid.png")
    self.arcShader:inject("filter", "img/death/"..self.world.."/arc.png")

    -- Player loading
    self.player= player
    self.camera = Camera.new(0,0)

    if self.player=="metalman" then
        self.personnage = MetalMan.new(self.camera,self.mapLoader.metalManPos,self.mapLoader.metalManPowers)
        self.magnetmanager:addMetal(self.personnage)
    elseif self.player=="themagnet" then
        self.personnage = TheMagnet.new(self.camera,self.mapLoader.theMagnetPos,self.mapLoader.theMagnetPowers)
        self.magnetmanager:addGenerator(self.personnage)
    end

    -- State Variables
    self.shouldEnd=false
    self.levelFinished=false
    self.gameIsPaused=false

    -- Slow timer
    self.slowTimer=1
    self.isSlowing=false

    -- Shaders
    -- Bloom Shader
    self.bloom=CreateBloomEffect(windowW,windowH)
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

    -- Pause menu loading
    self.pauseMenu=PauseMenu.new(200,100,900,550)



    -- -- Init de Loading
    -- self.loadingScreen=LoadingScreen.new()

    -- -- Starting the multithreading loading
    -- local returnF = GameplaySolo.loadFinished
    -- self.loading=s_gameStateManager.loader.start(returnF, print)
    -- if not self.loading then
    --     self.loading = true
    --     self:init()
    -- end
    return self
end


    -- Fonction qui init l'état gameplay solo quand l'état est fini
    function GameplaySolo.loadFinished()
        local gp = s_gameStateManager.state["GameplaySolo"]
        gp:init()
    end


-- Initialisation de début de partie
    function GameplaySolo:init()
        -- Principalement les anims
        -- Init mapLoader
        self.mapLoader:init()

        -- Init character
        self.personnage:init()
        self.loading=true
    end

    
    function GameplaySolo:finish()
        self.levelFinished=true
    end

    function GameplaySolo:slow()
        self.isSlowing=true
        self.slowTimer=0.2
    end

    function GameplaySolo:dieEffect(effect)
        self.effect = effect
        if(self.effect == Effects.Acid) then
            self.acidShader:activate()
        elseif (self.effect == Effects.Arc) then
            self.arcShader:activate()
        end
    end

    function GameplaySolo:destroy()
        self.shouldEnd=false
        world:setCallbacks(nil, function() collectgarbage() end)
        world:destroy()
        world=nil
        world = love.physics.newWorld( 0, 18*unitWorldSize, false )
        self.mapLoader:destroy()
        self.paralax:destroy()
        self.mapLoaderSolo = nil
        collectgarbage()
    end  

    function GameplaySolo:reset()
        world:setCallbacks(nil, function() collectgarbage() end)
        world:destroy()
        world=nil
        world = love.physics.newWorld( 0, 18*unitWorldSize, false )
        world:setCallbacks(beginContact, endContact, preSolve, postSolve)
        -- Custom physics
        self.magnetmanager= nil
        self.magnetmanager = MagnetManagerSolo.new()

        self.mapLoader = MapLoaderSolo.new(self.mapFile, self.magnetmanager)

        -- La camera
        self.camera =Camera.new(0,0)

        if self.player=="metalman" then
            self.personnage = MetalMan.new(self.camera,self.mapLoader.metalManPos)
            self.magnetmanager:addMetal(self.personnage)
        elseif self.player=="themagnet" then
            self.personnage = TheMagnet.new(self.camera,self.mapLoader.theMagnetPos)
            self.magnetmanager:addGenerator(self.personnage)
        end
        self.gameIsPaused=false
        self.shouldEnd=false 

    end

    function GameplaySolo:failed()
        self.shouldEnd=true
    end    

    function GameplaySolo:keyPressed(key, unicode)
        -- if not self.loading then
            if not self.gameIsPaused then

                -- Inputs for players
                    if key == InputType.ACTION1 then
                        self.personnage:jump()     
                    end
                    if key == InputType.ACTION4 then
                        self.mapLoader:handleTry(self.player)
                    end
                    
                    if key == InputType.RIGHT then
                        self.personnage:startMove(Direction.Right)
                    end

                    if key ==InputType.LEFT then
                        self.personnage:startMove(Direction.Left)
                    end  

                if self.player=="metalman" then
                    if not self.personnage.isStatic then
                        if key == InputType.ACTION2 then
                            self.personnage:changeMass()
                        end
                    end
                    if key == InputType.ACTION3 then
                        self.personnage:switchType()
                        self.magnetmanager:changeMetalType(self.personnage,self.personnage.oldMetal,self.personnage.metalType)
                    end     
                elseif self.player=="themagnet" then
                    if key ==InputType.ACTION2 then
                        self.personnage:enableStaticField()
                    end
                    if key ==InputType.ACTION3 then
                        self.personnage:enableAttractiveField()
                    end
                    if key ==InputType.ACTION4 then
                        self.personnage:enableRepulsiveField()
                    end

                    if key ==InputType.ACTION5 then
                        self.personnage:enableRotativeLField()
                    end
                    if key ==InputType.ACTION6 then
                        self.personnage:enableRotativeRField()
                    end          
                end
            else
                self.pauseMenu:keyPressed(key, unicode)
            end
            -- Cheat Code
            -- if key=="c" then
            --     self.levelFinished=true
            -- end


            -- Pause
            if key == InputType.MENU then
                self.pauseMenu:sendPauseOrder()
            end   
        -- end
    end

    function GameplaySolo:keyReleased(key, unicode)
            if not self.gameIsPaused then
                if key == InputType.LEFT or key == InputType.RIGHT then
                    self.personnage:stopMove()
                end

                if key == InputType.LEFT or key == InputType.RIGHT then
                        self.personnage:stopMove()
                end
                if self.player=="themagnet" then
                    if key ==InputType.ACTION2 then
                        self.personnage:disableStaticField()
                    end
                    if key ==InputType.ACTION3 or key ==InputType.ACTION4 or key ==InputType.ACTION5 or key ==InputType.ACTION6 then
                        self.personnage:disableField()
                    end
                end
            end
    end
    
    function GameplaySolo:HandleEvents()
        for i,v in pairs(s_gameManager.eventList) do
            print(v.sort)
            if (v.sort == GameplayEvents.Die) then
                self:dieEffect(v.type)
            elseif (v.sort == GameplayEvents.Slow) then
                self:slow()
            elseif (v.sort == GameplayEvents.Paralax) then
                self.paralax:setEnable(v.val)
            end
            s_gameManager.eventList[i] = nil
        end
    end
    function GameplaySolo:update(dttheo)

        -- Gestion des evenements de la frame précédente
        self:HandleEvents()
        -- Mise a jour des shaders
        self.acidShader:update(dttheo)
        self.arcShader:update(dttheo)

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
            if(self.levelFinished) then
               s_gameStateManager.state['LevelEndingSolo']=LevelEndingSolo.new(self.mapLoader.levelends[1].next,self.continuous,self.player)
               s_gameStateManager:changeState('LevelEndingSolo')
               return
           end

            if(self.shouldEnd) then
                s_gameStateManager.state['LevelFailedSolo']=LevelFailedSolo.new()
                s_gameStateManager:changeState('LevelFailedSolo')
                return        
            end        
            world:update(dt) 
            self.magnetmanager:update(dt)   

          -- Other stuff
            self.camera:update(dt)
            self.personnage:update(dt)
            self.mapLoader:update(dt)

        end
    end
    end
    
    function GameplaySolo:draw()
        if  self.loading then
            self.loadingScreen:draw()
        else

            self.bloom:enableCanvas()

            self.lightback:predraw()
            self.paralax:draw(self.camera:getPos())
            self.lightback:postdraw()

            self.light:predraw()
            self.mapLoader:draw(self.camera:getPos())
            self.personnage:draw() 
            self.mapLoader:firstPlanDraw(self.camera:getPos())
            self.light:postdraw()

            self.bloom:disableCanvas() 
            self.bloom:firstPass()

            -- if self.isSlowing then
            self.acidShader:enableCanvas()
            self.bloom:finalPass() 
            self.acidShader:disableCanvas()

            self.arcShader:enableCanvas()
            self.acidShader:pass() 
            self.arcShader:disableCanvas()


            self.personnage:preDraw() 
            self.arcShader:pass()
            self.personnage:postDraw() 
    end

        if self.gameIsPaused then
            self.pauseMenu:draw(x,y)
        end
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


function GameplaySolo:postSolve(a, b, coll)
    -- we won't do anything with this function
end

function GameplaySolo:shakeOnX(dx,speed,duration, amplitude)
        self.camera:shakeOnX(dx,speed,duration, amplitude)
end

function GameplaySolo:shakeOnY(dy,speed,duration, amplitude)
        self.camera:shakeOnY(dy,speed,duration, amplitude)
end
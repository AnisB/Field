--[[ 
This file is part of the Field project]]

require("game.solo.themagnetsolo")
require("game.solo.metalmansolo")
require("game.solo.camerasolo")
require("game.solo.magnetmanagersolo")
require("game.solo.generatorsolo")
require("game.solo.metalsolo")
require("game.solo.maploadersolo")
require("game.solo.interruptorsolo")
require("game.sound")
require("game.solo.levelendingsolo")
require("game.solo.levelfailedsolo")
require("const")

GameplaySolo = {}
GameplaySolo.__index = GameplaySolo

function GameplaySolo.new(mapFile,continuous,player)
    local self = {}
    setmetatable(self, GameplaySolo)

    self.continuous=continuous
    -- Physics
        love.physics.setMeter( unitWorldSize) --the height of a meter our worlds will be 64px
        world = love.physics.newWorld( 0, 18*unitWorldSize, false )
        print(world:getGravity())
        world:setCallbacks(beginContact, endContact, preSolve, postSolve)

    -- Custom physics
    self.magnetmanager = MagnetManagerSolo.new()    


    --Map
    self.mapFile=mapFile
    self.mapLoader = MapLoaderSolo.new(mapFile,self.magnetmanager)

    self.mapx=self.mapLoader.map.width*self.mapLoader.map.tilewidth
    self.mapy= self.mapLoader.map.height*self.mapLoader.map.tileheight
    self.background1=Background.new(ParalaxImg.."1.png",1,self.mapy)
    self.background2=Background.new(ParalaxImg.."2.png",0.75,self.mapy)
    self.background3=Background.new(ParalaxImg.."3.png",0.5,self.mapy)
    self.background4=Background.new(ParalaxImg.."4.png",0.0,self.mapy)
    self.background5=Background.new(ParalaxImg.."5.png",0.0,self.mapy)

    self.player= player

    if self.player=="metalman" then
        self.cameraMM =CameraSolo.new(0,0)
        self.metalMan = MetalManSolo.new(self.cameraMM,self.mapLoader.metalManPos)
        self.magnetmanager:addMetal(self.metalMan)
    elseif self.player=="themagnet" then
        self.cameraTM =CameraSolo.new(0,0)
        self.theMagnet = TheMagnetSolo.new(self.cameraTM,self.mapLoader.theMagnetPos)
        self.magnetmanager:addGenerator(self.theMagnet)
    end
    -- self.inputManager= InputManager.new()
    self.shouldEnd=false
    self.levelFinished=false
    
    self.gameIsPaused=false
    return self
end

function GameplaySolo:finish()
    self.levelFinished=true
end


    function GameplaySolo:destroy()
        self.shouldEnd=false
        world:setCallbacks(nil, function() collectgarbage() end)
        world:destroy()
        world=nil
        world = love.physics.newWorld( 0, 18*unitWorldSize, false )
        world:setCallbacks(beginContact, endContact, preSolve, postSolve)
    end  

    function GameplaySolo:reset()
        self.shouldEnd=false
        world:setCallbacks(nil, function() collectgarbage() end)
        world:destroy()
        world=nil
        world = love.physics.newWorld( 0, 18*unitWorldSize, false )
        world:setCallbacks(beginContact, endContact, preSolve, postSolve)
        -- Custom physics
        self.magnetmanager= nil
        self.magnetmanager = MagnetManagerSolo.new()

        self.mapLoader = MapLoaderSolo.new(self.mapFile, self.magnetmanager)

        -- Camera Metal Man
        self.cameraMM =Camera.new(0,0)
        -- Camera The Magnet
        self.cameraTM =Camera.new(0,0)

        
    if self.player=="metalman" then
        self.cameraMM =CameraSolo.new(0,0)
        self.metalMan = MetalManSolo.new(self.cameraMM,self.mapLoader.metalManPos)
        self.magnetmanager:addMetal(self.metalMan)
    elseif self.player=="themagnet" then
        self.cameraTM =CameraSolo.new(0,0)
        self.theMagnet = TheMagnetSolo.new(self.cameraTM,self.mapLoader.theMagnetPos)
        self.magnetmanager:addGenerator(self.theMagnet)
    end

end

    function GameplaySolo:failed()
        self.shouldEnd=true
    end    

    function GameplaySolo:setPaused(state)
        self.gameIsPaused=state
    end


    function GameplaySolo:mousePressed(x, y, button)
    end
    
    function GameplaySolo:mouseReleased(x, y, button)
    end
    
    
    function GameplaySolo:keyPressed(key, unicode)

        if not self.gameIsPaused then
            if self.player=="metalman" then
                if key=="z" then
                    self.metalMan:jump()     
                end
                if key =="e" then
                    self.mapLoader:handleTry('MetalMan')
                end
                if not self.metalMan.isStatic then
                    if key =="b" then
                        self.metalMan:changeMass()
                    end
                end
                if key =="d" then
                    self.metalMan:startMove()
                end

                if key =="q" then
                    self.metalMan:startMove()
                end  

                if key=="n" then
                    self.metalMan:switchType()
                    self.magnetmanager:changeMetalType(self.metalMan,self.metalMan.oldMetal,self.metalMan.metalType)
                end     
            elseif self.player=="themagnet" then
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
                if key =="f" then
                    self.mapLoader:handleTry('TheMagnet')
                end

                if key =="left" then
                    self.theMagnet:startMove()
                end

                if key =="right" then
                    self.theMagnet:startMove()
                end            
            end
        end

        if key=="c" then
            self.levelFinished=true
        end

            if key =="u" then
                self:setPaused( not self.gameIsPaused)
            end   
    end


    function GameplaySolo:keyReleased(key, unicode)

        if not self.gameIsPaused then
            if self.player=="metalman" then
                if key =="d" then
                    self.metalMan:stopMove()
                end
                if key =="q" then
                    self.metalMan:stopMove()
                end

                elseif self.player=="themagnet" then
                    if key =="i" then
                        self.theMagnet:disableStaticField()
                    end

                    if key =="o" or key =="p" or key =="k"or key =="l"then
                        self.theMagnet:disableField()
                    end

                    if key =="left" then
                        self.theMagnet:stopMove()
                    end

                    if key =="right" then
                        self.theMagnet:stopMove()
                    end
                end
            end
        end
    
    
    function GameplaySolo:update(dt)

        if  not self.gameIsPaused then
            if(self.levelFinished) then
			   -- inputManager:clearInputs()
               gameStateManager.state['LevelEndingSolo']=LevelEndingSolo.new(self.mapLoader.levelends[1].next,self.continuous)
               gameStateManager:changeState('LevelEndingSolo')
               return
           end

           if(self.shouldEnd) then
              -- inputManager:clearInputs()
              gameStateManager.state['LevelFailedSolo']=LevelFailedSolo.new()
              gameStateManager:changeState('LevelFailedSolo')
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
    
    function GameplaySolo:draw()


        if  self.gameIsPaused then
            love.graphics.setColor(150,150,150,255)
        else
            love.graphics.setColor(255,255,255,255)
        end
        if self.player=="metalman" then
            self.metalMan:preDraw()
            self.background5:draw(self.cameraMM:getPos()) 
            self.background4:draw(self.cameraMM:getPos())
            self.metalMan:postDraw()
            self.background3:draw(self.cameraMM:getPos())
            self.background2:draw(self.cameraMM:getPos())
            self.background1:draw(self.cameraMM:getPos())
            self.mapLoader:draw(self.cameraMM:getPos())
            self.metalMan:draw()
            self.mapLoader:firstPlanDraw(self.cameraMM:getPos())
        elseif self.player=="themagnet" then
            self.background5:draw(self.cameraTM:getPos()) 
            self.background4:draw(self.cameraTM:getPos())
            self.background3:draw(self.cameraTM:getPos())
            self.background2:draw(self.cameraTM:getPos())
            self.background1:draw(self.cameraTM:getPos())
            self.mapLoader:draw(self.cameraTM:getPos())
            self.mapLoader:draw(self.cameraTM:getPos())
            self.theMagnet:draw() 
            self.mapLoader:firstPlanDraw(self.cameraTM:getPos())
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

function GameplaySolo:postSolve(a, b, coll)
-- we won't do anything with this function
end

function GameplaySolo:shakeOnX(dx,speed,duration)
    if self.player=="metalman" then
        self.cameraMM:shakeOnX(dx,speed,duration)
    elseif self.player=="themagnet" then
        self.cameraTM:shakeOnX(dx,speed,duration)
    end
end

function GameplaySolo:shakeOnY(dy,speed,duration)
    if self.player=="metalman" then
        self.cameraMM:shakeOnY(dy,speed,duration)
    elseif self.player=="themagnet" then
        self.cameraTM:shakeOnY(dy,speed,duration)
    end
end
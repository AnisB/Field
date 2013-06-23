--[[ 
This file is part of the Field project]]

require("game.sound")

-- Include Shaders
require("game.shader.bloomshadereffect")

require("game.cinematic.scenarioloader")
require("game.shader.lightshader")
require("game.shader.backlightshader")

-- Inlcude Other
require("game.simplebackground")
require("game.ui.loadingscreen")
require("game.ui.pausemenu")
require("const")


Cinematic = {}
Cinematic.__index = Cinematic




function Cinematic.new(scenario)
    local self = {}
    setmetatable(self, Cinematic)

    --Map loading
    self.scenarioLoaded = ScenarioLoader.new(scenario)
    self.camera = CameraSolo.new(0,0)

    self.duration = self.scenarioLoaded.Duration
    
    self.cinematicFinished=false

    self.time = 0

    self.actions = self.scenarioLoaded.actions

    return self
end


-- Initialisation de début d'anim
    function Cinematic:init()

    end

    
    function Cinematic:finish()
        self.cinematicFinished=true
    end


    function Cinematic:destroy()
    end  

    function Cinematic:reset()
     
    end


    function Cinematic:mousePressed(x, y, button)
    end
    
    function Cinematic:mouseReleased(x, y, button)
    end
    

    function Cinematic:keyPressed(key, unicode)
    end


    function Cinematic:keyReleased(key, unicode)

    end

    
    function Cinematic:update(dt)
        self.time = self.time + dt
        self.scenarioLoaded:update(dt)
        for i,p in pairs(self.actions) do
            if p:shouldBeDone(self.time) then
                p:execute()
                table.remove(self.actions, i)
            else
                return
            end
        end
    end
    
    function Cinematic:draw()
        self.scenarioLoaded:draw()
    end
    

function Cinematic:shakeOnX(dx,speed,duration)
        self.camera:shakeOnX(dx,speed,duration)
end

function Cinematic:shakeOnY(dy,speed,duration)
    self.camera:shakeOnY(dy,speed,duration)
end
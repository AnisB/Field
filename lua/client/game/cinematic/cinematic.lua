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
require("game.ui.pausemenu")
require("const")


CinematicSolo = {}
CinematicSolo.__index = CinematicSolo




function CinematicSolo.new(scenario)
    local self = {}
    setmetatable(self, CinematicSolo)

    --Map loading
    self.mapFile=mapFile

    self.scenarioLoader = ScenarioLoader.new(mapFile)

    self.camera =CameraSolo.new(0,0)
    
    self.cinematicFinished=false

    return self
end


-- Initialisation de début d'anim
    function CinematicSolo:init()

    end

    
    function CinematicSolo:finish()
        self.cinematicFinished=true
    end


    function CinematicSolo:destroy()
    end  

    function CinematicSolo:reset()
     
    end


    function CinematicSolo:mousePressed(x, y, button)
    end
    
    function CinematicSolo:mouseReleased(x, y, button)
    end
    

    function CinematicSolo:keyPressed(key, unicode)
    end


    function CinematicSolo:keyReleased(key, unicode)

    end

    
    function CinematicSolo:update(dt)
        self.scenarioLoader:update(dt)
    end
    
    function CinematicSolo:draw()
       
    end
    

function CinematicSolo:shakeOnX(dx,speed,duration)
        self.camera:shakeOnX(dx,speed,duration)
end

function CinematicSolo:shakeOnY(dy,speed,duration)
    self.camera:shakeOnY(dy,speed,duration)
end
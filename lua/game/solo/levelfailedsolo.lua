--[[ 
This file is part of the Field project]]


LevelFailedSolo = {}
LevelFailedSolo.__index = LevelFailedSolo
function LevelFailedSolo.new()
	local self = {}
	setmetatable(self, LevelFailedSolo)

    -- self.inputManager = MenuInputManager.new(self)
    self.back=s_resourceManager:LoadImage("backgrounds/failed/back.png")
	local retry=Button.new(800,300,200,50, "backgrounds/failed/retry.png","retry")
	local quit=Button.new(800,400,200,50,   "backgrounds/failed/quit.png","quit")

     self.layout = UILayout.new()

    self.layout:addSelectable(retry)
    self.layout:addSelectable(quit)

    self.layout:Init()
	return self
end


function LevelFailedSolo:keyPressed(key, player)
    self.layout:inputPressed(key,player)
     if key == InputType.START then
        local name = self.layout:getSelectedName()
        if(name =="retry") then
            local mapFile = s_gameStateManager.state['GameplaySolo'].mapFile
            local continuous = s_gameStateManager.state['GameplaySolo'].continuous
            local player = s_gameStateManager.state['GameplaySolo'].player
            s_gameStateManager.state['GameplaySolo']:destroy()
            s_gameStateManager.state['GameplaySolo'] = GameplaySolo.new(mapFile,continuous,player)
            s_gameStateManager:changeState('GameplaySolo')    
        elseif name == "quit"  then
            s_gameStateManager:changeState('ChoixNiveauSolo')
        end
    end
end

function LevelFailedSolo:keyReleased(key, unicode)
end


function LevelFailedSolo:update(dt)
    self.layout:update()
end

function LevelFailedSolo:draw(filter)
    love.graphics.setColor(255,255,255,255*filter)
    love.graphics.draw(self.back,0,0)
	self.layout:draw(filter)
end


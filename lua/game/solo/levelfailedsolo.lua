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
 --      self.selection = {
 --        self.retry,
 --        self.quit
 --    }
 --    self.selected = 1
 --    self.retry:setSelected(true)
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


function LevelFailedSolo:sendPressedKey(key, unicode) 

	--  if key == "down" then
 --        self:incrementSelection()
 --    elseif key == "up" then
 --        self:decrementSelection()
	-- elseif key=="return" then

 --        if self.retry.selected then
 --        	local mapFile =gameStateManager.state['GameplaySolo'].mapFile
 --        	local continuous =gameStateManager.state['GameplaySolo'].continuous
 --        	local player =gameStateManager.state['GameplaySolo'].player
 --        	gameStateManager.state['GameplaySolo']:destroy()
 --        	gameStateManager.state['GameplaySolo'] = GameplaySolo.new(mapFile,continuous,player)
 --        	gameStateManager:changeState('GameplaySolo')	
 --        elseif self.quit.selected then
 --            gameStateManager:changeState('ChoixNiveauSolo')
 --        end
 --    end
         
end


function LevelFailedSolo:update(dt)
    self.layout:update()
end

function LevelFailedSolo:draw(filter)
    love.graphics.draw(self.back,0,0)
	self.layout:draw(filter)
  -- self.retry:draw(filter)
  -- self.quit:draw(filter)
end


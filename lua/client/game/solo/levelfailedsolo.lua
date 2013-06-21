--[[ 
This file is part of the Field project]]


LevelFailedSolo = {}
LevelFailedSolo.__index = LevelFailedSolo
function LevelFailedSolo.new()
	local self = {}
	setmetatable(self, LevelFailedSolo)


  self.back=love.graphics.newImage("backgrounds/failed/back.png")
	self.retry=Button.new(800,300,200,50, "backgrounds/failed/retry.png")
	self.quit=Button.new(800,400,200,50,   "backgrounds/failed/quit.png")


      self.selection = {
        self.retry,
        self.quit
    }
    self.selected = 1
    self.retry:setSelected(true)
	return self
end


function LevelFailedSolo:mousePressed(x, y, button)
	if self.retry:isCliked(x,y) then
	   gameStateManager:resetAndChangeState('GameplaySolo')		
	elseif  self.quit:isCliked(x,y) then
	   gameStateManager:changeState('ChoixNiveauSolo')	
	end
end

function LevelFailedSolo:mouseReleased(x, y, button)
end


function LevelFailedSolo:keyPressed(key, unicode)

	 if key == "down" then
        self:incrementSelection()
    elseif key == "up" then
        self:decrementSelection()
	elseif key=="return" then

        if self.retry.selected then
        	local mapFile =gameStateManager.state['GameplaySolo'].mapFile
        	local continuous =gameStateManager.state['GameplaySolo'].continuous
        	local player =gameStateManager.state['GameplaySolo'].player
        	gameStateManager.state['GameplaySolo']:destroy()
        	gameStateManager.state['GameplaySolo'] = GameplaySolo.new(mapFile,continuous,player)
        	gameStateManager:changeState('GameplaySolo')	
        elseif self.quit.selected then
            gameStateManager:changeState('ChoixNiveauSolo')
        end
    end
         
end

function LevelFailedSolo:keyReleased(key, unicode)
end

function LevelFailedSolo:incrementSelection()
    self.selection[self.selected]:setSelected(false)
    if self.selected == #self.selection then
        self.selected = 0
    end
    self.selected = self.selected + 1
    self.selection[self.selected]:setSelected(true)
end

function LevelFailedSolo:decrementSelection()
    self.selection[self.selected]:setSelected(false)
        if self.selected == 1 then
        self.selected = #self.selection + 1
    end
    self.selected = self.selected - 1
    self.selection[self.selected]:setSelected(true)
end



function LevelFailedSolo:update(dt)
end

function LevelFailedSolo:draw()
	love.graphics.draw(self.back,0,0)
  x, y = love.mouse.getPosition()
  self.retry:draw(1)
  self.quit:draw(1)
end


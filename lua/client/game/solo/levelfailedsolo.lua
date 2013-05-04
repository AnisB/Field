--[[ 
This file is part of the Field project]]


LevelFailedSolo = {}
LevelFailedSolo.__index = LevelFailedSolo
function LevelFailedSolo.new()
	local self = {}
	setmetatable(self, LevelFailedSolo)
	self.next=next
	self.continuous=continuous
	self.back=love.graphics.newImage("backgrounds/failed/back.png")
	self.retry=Button.new(800,300,200,50,ButtonType.Large,"backgrounds/failed/retry.png")
	self.quit=Button.new(800,400,200,50,ButtonType.Small,"backgrounds/failed/quit.png")
	return self
end


function LevelFailedSolo:mousePressed(x, y, button)
	if self.retry:isCliked(x,y) then
	
	elseif  self.retry:isCliked(x,y) then
	
	end
end

function LevelFailedSolo:mouseReleased(x, y, button)
end


function LevelFailedSolo:keyPressed(key, unicode)
	if key=="return" then
	   gameStateManager.state['GameplaySolo']:reset()
	   gameStateManager:changeState('GameplaySolo')		
   -- else
   --     gameStateManager.state['Gameplay']:destroy()        
   --     gameStateManager:changeState('choixTypeJeu')     
   end            
end

function LevelFailedSolo:keyReleased(key, unicode)
end


function LevelFailedSolo:update(dt)
end

function LevelFailedSolo:draw()
	love.graphics.draw(self.back,0,0)
	x, y = love.mouse.getPosition()
	self.retry:draw(x,y,1)
	self.quit:draw(x,y,1)
end


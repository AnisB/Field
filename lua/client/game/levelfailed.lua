--[[ 
This file is part of the Field project]]


LevelFailed = {}
LevelFailed.__index = LevelFailed
function LevelFailed.new()
	local self = {}
	setmetatable(self, LevelFailed)
	self.next=next
	self.continuous=continuous
  self.back=love.graphics.newImage("backgrounds/failed/back.png")
  self.retry=Button.new(800,300,200,50,ButtonType.Large,"backgrounds/failed/retry.png")
  self.quit=Button.new(800,400,200,50,ButtonType.Small,"backgrounds/failed/quit.png")
	return self
end


function LevelFailed:mousePressed(x, y, button)
  if self.retry:isCliked(x,y) then
	  self:keyPressed("return", 13)
  end
end
  
function LevelFailed:mouseReleased(x, y, button)
end


function LevelFailed:keyPressed(akey, unicode)
  serveur:send({type="input", pck={character=monde.moi.perso, key=akey, state=true}})            
	if akey=="return" then
	   gameStateManager.state['Gameplay']:reset()
	   gameStateManager:changeState('Gameplay')		
   else
	   -- gameStateManager.state['Gameplay']:destroy()        
	   -- gameStateManager:changeState('choixTypeJeu')     
   end            
end

function LevelFailed:keyReleased(key, unicode)
end


function LevelFailed:update(dt)
	
end

function LevelFailed:draw()
  love.graphics.draw(self.back,0,0)
  x, y = love.mouse.getPosition()
  self.retry:draw(x,y,1)
  self.quit:draw(x,y,1)

end

function LevelFailed:onMessage(x, y, button)
end


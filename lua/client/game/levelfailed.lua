--[[ 
This file is part of the Field project]]


LevelFailed = {}
LevelFailed.__index = LevelFailed
function LevelFailed.new()
	local self = {}
	setmetatable(self, LevelFailed)
  self.back=love.graphics.newImage("backgrounds/failed/back.png")
  self.retry=Button.new(800,300,200,50, "backgrounds/failed/retry.png")
  self.quit=Button.new(800,400,200,50,   "backgrounds/failed/quit.png")
	return self
end





function LevelFailed:mousePressed(x, y, button)
    if self.retry:isCliked(x,y) then
        self:goGameplayOrder()       
    elseif self.quit:isCliked(x,y) then
        self:backChoixNiveauOrder()        
    end
end

function LevelFailed:onMessage(msg)
    if msg.type=="syncro" and msg.pck.next=="Gameplay"then
        self:goGameplayApply()     
    elseif msg.type=="syncro" and msg.pck.next=="ChoixNiveau" then
        self:backChoixNiveauApply()   
    elseif msg.type=="reset" then
        -- We got a problem
        --gameStateManager:forceDisconnect()
    else
        -- Ce message n'est pas censé atterir ici
    end 
end

function LevelFailed:mouseReleased(x, y, button)
end


function LevelFailed:keyPressed(akey, unicode)
	if akey=="return" then
        self:goGameplayOrder()       
    end		
end

function LevelFailed:goGameplayOrder()
    serveur:send({type="syncro", pck={perso=monde.moi.perso, next="Gameplay", current="LevelFailed"}})    
    gameStateManager.state['Gameplay']:reset()
    gameStateManager:changeState('Gameplay')
end

function LevelFailed:backChoixNiveauOrder()
    serveur:send({type="syncro", pck={perso=monde.moi.perso, next="ChoixNiveau", current="LevelFailed"}})    
    gameStateManager:changeState('ChoixNiveau')        
end

function LevelFailed:goGameplayApply()
	gameStateManager.state['Gameplay']:reset()
	gameStateManager:changeState('Gameplay')
end

function LevelFailed:backChoixNiveauApply()
    gameStateManager:changeState('ChoixNiveau')        
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



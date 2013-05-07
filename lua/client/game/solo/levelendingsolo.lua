--[[ 
This file is part of the Field project]]


LevelEndingSolo = {}
LevelEndingSolo.__index = LevelEndingSolo
function LevelEndingSolo.new(next,continuous)
    local self = {}
    setmetatable(self, LevelEndingSolo)
    self.next=next
    self.continuous=continuous
    self.back=love.graphics.newImage("backgrounds/ending/back.png")
    self.continue=Button.newDec(300,300,300,50,ButtonType.VLarge,"backgrounds/ending/continue.png",30,5)
    self.returnB=Button.new(800,300,250,50,ButtonType.Large,"backgrounds/ending/return.png")
    return self
end


function LevelEndingSolo:mousePressed(x, y, button)
    if self.continue:isCliked(x,y) then
        if self.continuous then
            local player=gameStateManager.state['GameplaySolo'].player
            gameStateManager.state['GameplaySolo']:destroy()
            gameStateManager.state['GameplaySolo']=GameplaySolo.new(self.next,true,player)
            gameStateManager:changeState('GameplaySolo')        
        else
            gameStateManager:changeState('ChoixNiveauSolo')
        end     
    end
end

function LevelEndingSolo:mouseReleased(x, y, button)
end


function LevelEndingSolo:keyPressed(key, unicode)
	if key=="return" then
        if self.continuous then
            local player=gameStateManager.state['GameplaySolo'].player
            gameStateManager.state['GameplaySolo']:destroy()
            gameStateManager.state['GameplaySolo']=GameplaySolo.new(self.next,true,player)
            gameStateManager:changeState('GameplaySolo')        
        else
            gameStateManager:changeState('ChoixNiveauSolo')
        end	
	end
end

function LevelEndingSolo:keyReleased(key, unicode)
end


function LevelEndingSolo:update(dt)
	
end

function LevelEndingSolo:draw()
    local hover = false
    x, y = love.mouse.getPosition()

    -- background :
    love.graphics.draw(self.back, 0, 0)


    self.continue:draw(x,y,1)
    self.returnB:draw(x,y,1)

end


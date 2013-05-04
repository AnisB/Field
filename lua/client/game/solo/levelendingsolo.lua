--[[ 
This file is part of the Field project]]


LevelEndingSolo = {}
LevelEndingSolo.__index = LevelEndingSolo
function LevelEndingSolo.new(next,continuous)
    local self = {}
    setmetatable(self, LevelEndingSolo)
    self.next=next
    self.continuous=continuous
    print(self.continuous)
    return self
end


function LevelEndingSolo:mousePressed(x, y, button)
end

function LevelEndingSolo:mouseReleased(x, y, button)
end


function LevelEndingSolo:keyPressed(key, unicode)
	if key=="return" then
		if self.continuous then
			gameStateManager.state['GameplaySolo']:destroy()
            gameStateManager.state['GameplaySolo']=GameplaySolo.new("maps/"..self.next,true)
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
    love.graphics.draw(gameStateManager.state['ConnectToServer'].bg, 0, 0)

    -- rectangles :
    if x > 90 and x < 90+266 and y > 205 and y < 205+35 then
        love.graphics.setColor(150, 150, 150, 255)
        hover = true
    else
        love.graphics.setColor(50, 50, 50, 255)
    end
    love.graphics.rectangle("fill", 90, 205, 266, 35)

    -- text :
    love.graphics.setColor(20, 240, 135, 255)
    love.graphics.print("success !", 150, 100)    
    love.graphics.setColor(255, 255, 255, 255)

    if self.continuous then
        love.graphics.print("niveau suivant", 100, 200)
    else
        love.graphics.print("retour au menu", 100, 200)
    end

end


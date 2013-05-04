--[[ 
This file is part of the Field project]]


LevelEnding = {}
LevelEnding.__index = LevelEnding
function LevelEnding.new(next,continuous)
    local self = {}
    setmetatable(self, LevelEnding)
    self.next=next
    self.continuous=continuous
    print(self.continuous)
    return self
end


function LevelEnding:mousePressed(x, y, button)
    if x > 90 and x < 90+266 and y > 205 and y < 205+35 then
        serveur:send({type="input", pck={character=monde.moi.perso, key="return", state=true}})    
        gameStateManager.state['Gameplay']=Gameplay.new("maps."..self.next,true)
        gameStateManager:changeState('Gameplay')
    end
end

function LevelEnding:onMessage(x, y, button)
end

function LevelEnding:mouseReleased(x, y, button)
end


function LevelEnding:keyPressed(akey, unicode)
    print("levelending",monde.moi.perso, akey)
    serveur:send({type="input", pck={character=monde.moi.perso, key=akey, state=true}})    
	if akey=="return" then
        gameStateManager.state['Gameplay']=Gameplay.new("maps."..self.next,true)
        gameStateManager:changeState('Gameplay')		
    else
        gameStateManager:changeState('ChoixTypeJeu')
    end		
end

function LevelEnding:keyReleased(key, unicode)
end

function LevelEnding:joystickPressed(joystick, button)
end

function LevelEnding:joystickReleased(joystick, button)
end

function LevelEnding:update(dt)
	
end

function LevelEnding:draw()
    local hover = false
    x, y = love.mouse.getPosition()

    -- background :
    -- love.graphics.draw(gameStateManager.state['ConnectToServer'].bg, 0, 0)

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


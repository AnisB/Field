--[[ 
This file is part of the Field project]]


    LevelFailed = {}
    LevelFailed.__index = LevelFailed
    function LevelFailed.new()
        local self = {}
        setmetatable(self, LevelFailed)
        self.next=next
        self.continuous=continuous
        print(self.continuous)
        return self
    end


    function LevelFailed:mousePressed(x, y, button)
      if x > 90 and x < 90+282 and y > 205 and y < 205+35 then
        serveur:send({type="input", pck={character=monde.moi.perso, key="return", state=true}})            

           gameStateManager.state['Gameplay']:reset()
           gameStateManager:changeState('Gameplay') 
         end
    end

    function LevelFailed:mouseReleased(x, y, button)
    end


    function LevelFailed:keyPressed(akey, unicode)
      print("levelending",monde.moi.perso, akey)
      serveur:send({type="input", pck={character=monde.moi.perso, key=akey, state=true}})            
        if unicode==13 then
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
local hover = false
    x, y = love.mouse.getPosition()

    -- background :
    love.graphics.draw(gameStateManager.state['ConnectToServer'].bg, 0, 0)

    -- rectangles :
    if x > 90 and x < 90+282 and y > 205 and y < 205+35 then
        love.graphics.setColor(150, 150, 150, 255)
        hover = true
    else
        love.graphics.setColor(50, 50, 50, 255)
    end
    love.graphics.rectangle("fill", 90, 205, 282, 35)

    -- text :
    love.graphics.setColor(240, 10, 20, 255)
    love.graphics.print("Failed !", 160, 100)    
    love.graphics.setColor(255, 255, 255, 255)

  if self.continuous then
    love.graphics.print("recommencer", 100, 200)
  else
    love.graphics.print("recommencer", 100, 200)
  end

    -- cursor :
    if hover then
        love.mouse.setVisible(false)
        love.graphics.draw(gameStateManager.state['ConnectToServer'].handcursor, x-17, y-17)
    else
        love.mouse.setVisible(true)
    end
end

function LevelFailed:onMessage(x, y, button)
end


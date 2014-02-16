--[[ 
This file is part of the Field project]]


LevelEndingSolo = {}
LevelEndingSolo.__index = LevelEndingSolo


speedPerso=300

function LevelEndingSolo.new(next,continuous,perso)
    local self = {}
    setmetatable(self, LevelEndingSolo)

    self.next=next
    self.continuous=continuous
    self.back=s_resourceManager:LoadImage("backgrounds/ending/back.png")

    local continue=Button.new(300,300,300,50,"backgrounds/ending/continue.png","continue")
    local ret=Button.new(800,300,250,50, "backgrounds/ending/return.png","ret")
    continue:decaler(30,5)

    self.layout = UILayout.new()

    self.layout:addSelectable(continue)
    self.layout:addSelectable(ret)

    self.layout:Init()

    if player=="metalman" then
        self.perso = BasicAnim.new(perso.."/alu/running",true, 0.1, 9)
    else
        self.perso = BasicAnim.new(perso.."/running",true, 0.1, 9)
    end

    self.pos=-50
    self.diffuse  = love.graphics.newQuad(0, 0, 64, 64, 128, 64)

    return self
end


function LevelEndingSolo:mousePressed(x, y, button)
end

function LevelEndingSolo:mouseReleased(x, y, button)
end


function LevelEndingSolo:keyPressed(key, unicode)
    self.layout:inputPressedSecond(key,player)
    if key == InputType.START then
        local name = self.layout:getSelectedName()
        if name=="continue" then
            if self.continuous then
                local player=s_gameStateManager.state['GameplaySolo'].player
                s_gameStateManager.state['GameplaySolo']:destroy()
                s_gameStateManager.state['GameplaySolo']= nil
                s_gameStateManager.state['GameplaySolo']=GameplaySolo.new("maps/solo/"..player.."/"..self.next,true,player)
                s_gameStateManager:changeState('GameplaySolo')        
            else
                s_gameStateManager:changeState('ChoixNiveauSolo')
            end 
        elseif name=="ret" then
            s_gameStateManager:changeState('ChoixNiveauSolo')
        end
    end
end
function LevelEndingSolo:keyReleased(key, unicode)
end

function LevelEndingSolo:joystickPressed(key, unicode)
end


function LevelEndingSolo:joystickReleased(key, unicode)
end


function LevelEndingSolo:sendPressedKey(key, unicode) 


end

function LevelEndingSolo:update(dt)
    self.layout:update()

	self.perso:update(dt)
    if(self.pos<windowW+200) then
        self.pos=self.pos+dt*speedPerso
    end
end

function LevelEndingSolo:draw(filter)

    -- background :
    love.graphics.draw(self.back, 0, 0)
    self.layout:draw(filter)
    love.graphics.draw(self.perso:getSprite(), self.diffuse, self.pos,530 )

end


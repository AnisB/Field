--[[ 
This file is part of the Field project]]


speedPerso=300


LevelEnding = {}
LevelEnding.__index = LevelEnding
function LevelEnding.new(next,continuous)
    local self = {}
    setmetatable(self, LevelEnding)
    self.next=next
    self.continuous=continuous
    self.back=love.graphics.newImage("backgrounds/ending/back.png")
    self.continue=Button.newDec(300,300,300,50,ButtonType.VLarge,"backgrounds/ending/continue.png",30,5)
    self.returnB=Button.new(800,300,250,50,ButtonType.Large,"backgrounds/ending/return.png")
    self.perso1 = AnimMM.new("metalman/alu")
    self.perso2 = AnimTM.new("themagnet")
    self.perso1:load("running",true)
    self.perso2:load("running",true)
    self.diffuse  = love.graphics.newQuad(0, 0, 64, 64, 128, 64)
    self.pos1=-50
    self.pos2=-100
    return self
end


function LevelEnding:mousePressed(x, y, button)
    if self.continue:isCliked(x,y) then
        serveur:send({type="input", pck={character=monde.moi.perso, key="return", state=true}})    
        gameStateManager.state['Gameplay']=Gameplay.new("maps/"..self.next,true)
        gameStateManager:changeState('Gameplay')
    end
end

function LevelEnding:onMessage(x, y, button)
end

function LevelEnding:mouseReleased(x, y, button)
end


function LevelEnding:keyPressed(akey, unicode)
    -- print("levelending",monde.moi.perso, akey)
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
    self.perso1:update(dt)
    self.perso2:update(dt)
    if(self.pos1<windowW+200) then
        self.pos1=self.pos1+dt*speedPerso
    end 

    if(self.pos2<windowW+200) then
        self.pos2=self.pos2+dt*speedPerso
    end
end

function LevelEnding:draw()
    x, y = love.mouse.getPosition()

    -- background :
    love.graphics.draw(self.back, 0, 0)


    self.continue:draw(x,y,1)
    self.returnB:draw(x,y,1)
    love.graphics.drawq(self.perso1:getSprite(), self.diffuse, self.pos1,530 )
    love.graphics.drawq(self.perso2:getSprite(), self.diffuse, self.pos2,530 )


end


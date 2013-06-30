--[[ 
This file is part of the Field project]]


speedPerso=300


LevelEnding = {}
LevelEnding.__index = LevelEnding
function LevelEnding.new(next,continuous)
    local self = {}
    setmetatable(self, LevelEnding)

    self.inputManager = MenuInputManager.new(self)
    self.next=next
    self.continuous=continuous
    self.back=love.graphics.newImage("backgrounds/ending/back.png")
    self.continue=Button.new(300,300,300,50,"backgrounds/ending/continue.png")
    self.returnB=Button.new(800,300,250,50, "backgrounds/ending/return.png")


    self.selection = {
        self.continue,
        self.returnB
    }
    self.selected = 1
    self.continue:setSelected(true)

    self.perso1 = AnimMM.new("metalman/alu")
    self.perso2 = AnimTM.new("themagnet")
    self.perso1:load("running",true)
    self.perso2:load("running",true)
    self.diffuse  = love.graphics.newQuad(0, 0, 64, 64, 128, 64)
    self.pos1=-50
    self.pos2=-100




    return self
end


function LevelEnding:incrementSelection()
    self.selection[self.selected]:setSelected(false)
    if self.selected == #self.selection then
        self.selected = 0
    end
    self.selected = self.selected + 1
    self.selection[self.selected]:setSelected(true)
end

function LevelEnding:decrementSelection()
    self.selection[self.selected]:setSelected(false)
        if self.selected == 1 then
        self.selected = #self.selection + 1
    end
    self.selected = self.selected - 1
    self.selection[self.selected]:setSelected(true)
end


function LevelEnding:mousePressed(x, y, button)
end

function LevelEnding:onMessage(msg)
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

function LevelEnding:mouseReleased(x, y, button)
end


function LevelEnding:keyPressed(key, unicode)
    self.inputManager:keyPressed(key,unicode)
end
function LevelEnding:keyReleased(key, unicode)
    self.inputManager:keyReleased(key,unicode)
end

function LevelEnding:joystickPressed(key, unicode)
    self.inputManager:joystickPressed(key,unicode)
end


function LevelEnding:joystickReleased(key, unicode)
    self.inputManager:joystickReleased(key,unicode)
end


function LevelEnding:sendPressedKey(key, unicode) 
    if key == "right" then
        self:incrementSelection()
    elseif key == "left" then
        self:decrementSelection()
    elseif key=="return" then

        if self.continue.selected then
            if self.continuous then
                self:goGameplayOrder()      
            else
                self:backChoixNiveauOrder()
            end 
        elseif self.returnB.selected then
                self:backChoixNiveauOrder()
        end
    end
end

function LevelEnding:goGameplayOrder()
    serveur:send({type="syncro", pck={perso=monde.moi.perso, next="Gameplay", current="LevelEnding"}})    
    gameStateManager.state['Gameplay']=Gameplay.new("maps/multi/"..self.next,true)
    gameStateManager:changeState('Gameplay')
end

function LevelEnding:backChoixNiveauOrder()
    serveur:send({type="syncro", pck={perso=monde.moi.perso, next="ChoixNiveau", current="LevelEnding"}})    
    gameStateManager:changeState('ChoixNiveau')        
end

function LevelEnding:goGameplayApply()
    gameStateManager.state['Gameplay']=Gameplay.new("maps/multi/"..self.next,true)
    gameStateManager:changeState('Gameplay')
end

function LevelEnding:backChoixNiveauApply()
    gameStateManager:changeState('ChoixNiveau')        
end


function LevelEnding:update(dt)
    self.inputManager:update()
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


    self.continue:draw(1)
    self.returnB:draw(1)
    love.graphics.drawq(self.perso1:getSprite(), self.diffuse, self.pos1,530 )
    love.graphics.drawq(self.perso2:getSprite(), self.diffuse, self.pos2,530 )


end


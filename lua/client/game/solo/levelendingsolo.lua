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
    self.back=love.graphics.newImage("backgrounds/ending/back.png")

    self.continue=Button.newDec(300,300,300,50,"backgrounds/ending/continue.png",30,5)
    self.returnB=Button.new(800,300,250,50, "backgrounds/ending/return.png")

    local player=gameStateManager.state['GameplaySolo'].player
    if player=="metalman" then
    self.perso = AnimMM.new("metalman/alu")
    else
        self.perso = AnimTM.new("themagnet")
    end
    self.perso:load("running",true)
    self.pos=-50
    self.diffuse  = love.graphics.newQuad(0, 0, 64, 64, 128, 64)

    self.selection = {
        self.continue,
        self.returnB
    }
    self.selected = 1
    self.continue:setSelected(true)

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

    if key == "left" then
        self:incrementSelection()
    elseif key == "right" then
        self:decrementSelection()
	elseif key=="return" then

        if self.continue.selected then
            if self.continuous then
                local player=gameStateManager.state['GameplaySolo'].player
                gameStateManager.state['GameplaySolo']:destroy()
                gameStateManager.state['GameplaySolo']=GameplaySolo.new(self.next,true,player)
                gameStateManager:changeState('GameplaySolo')        
            else
                gameStateManager:changeState('ChoixNiveauSolo')
            end 
        elseif self.returnB.selected then
            gameStateManager:changeState('ChoixNiveauSolo')
        end
    end

end

function LevelEndingSolo:keyReleased(key, unicode)
end





function LevelEndingSolo:incrementSelection()
    self.selection[self.selected]:setSelected(false)
    if self.selected == #self.selection then
        self.selected = 0
    end
    self.selected = self.selected + 1
    self.selection[self.selected]:setSelected(true)
end

function LevelEndingSolo:decrementSelection()
    self.selection[self.selected]:setSelected(false)
        if self.selected == 1 then
        self.selected = #self.selection + 1
    end
    self.selected = self.selected - 1
    self.selection[self.selected]:setSelected(true)
end



function LevelEndingSolo:update(dt)
	self.perso:update(dt)
    if(self.pos<windowW+200) then
        self.pos=self.pos+dt*speedPerso
    end
end

function LevelEndingSolo:draw()
    x, y = love.mouse.getPosition()

    -- background :
    love.graphics.draw(self.back, 0, 0)

    self.continue:draw(1)
    self.returnB:draw(1)
    love.graphics.drawq(self.perso:getSprite(), self.diffuse, self.pos,530 )

end


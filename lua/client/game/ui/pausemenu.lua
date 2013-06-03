--[[ 
This file is part of the Field project
]]


PauseMenu = {}
PauseMenu.__index =  PauseMenu

function PauseMenu.new(x,y,w,l)
    local self = {}
    setmetatable(self, PauseMenu)

    self.back = love.graphics.newImage("img/pause.png")

    self.resume=Button.new(500,225,200,50, "backgrounds/ingame/resume.png")
    self.restart=Button.new(500,300,250,50, "backgrounds/ingame/restart.png")
    self.audio=Button.new(525,375,250,50, "backgrounds/ingame/audio.png")
    self.quit=Button.new(550,450,250,50, "backgrounds/ingame/quit.png")


    self.selection = {
        self.resume,
        self.restart,
        self.audio,
        self.quit
    }

    self.selected = 1
    self.resume:setSelected(true)

    return self
end

function PauseMenu:setEnable(isEnable)
	self.isActive=isEnable
end

function PauseMenu:update(dt)
end

function PauseMenu:keyPressed(key, unicode) 
    if key == 'down' or key =='tab' then
            self:incrementSelection()
        elseif key =='up' then
            self:decrementSelection()
    
        elseif key == "return" then

            if self.resume.selected then
                gameStateManager.state['GameplaySolo'].gameIsPaused=false
            end


            if self.restart.selected then
                gameStateManager.state['GameplaySolo'].gameIsPaused=false
                gameStateManager.state['GameplaySolo']:reset()
            end


            if self.audio.selected then
            end


            if self.quit.selected then
                gameStateManager.state['GameplaySolo'].gameIsPaused=false
                gameStateManager.state['GameplaySolo']:destroy()
                gameStateManager:changeState('ChoixNiveauSolo')
            end

        end
end



function PauseMenu:incrementSelection()
    self.selection[self.selected]:setSelected(false)
    if self.selected == #self.selection then
        self.selected = 0
    end
    self.selected = self.selected + 1
    self.selection[self.selected]:setSelected(true)
end

function PauseMenu:decrementSelection()
    self.selection[self.selected]:setSelected(false)
        if self.selected == 1 then
        self.selected = #self.selection + 1
    end
    self.selected = self.selected - 1
    self.selection[self.selected]:setSelected(true)
end

function PauseMenu:draw(x,y)
        if  self.isActive then
            love.graphics.draw(self.back,250,50)
            self.resume:draw(1)
            self.restart:draw(1)
            self.audio:draw(1)
            self.quit:draw(1)
        end
end
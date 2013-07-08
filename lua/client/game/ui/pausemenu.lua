--[[ 
This file is part of the Field project
]]

require("game.ui.optionspausemenu")

PauseMenu = {}
PauseMenu.__index =  PauseMenu

function PauseMenu.new(x,y,w,l)
    local self = {}
    setmetatable(self, PauseMenu)

    self.back = love.graphics.newImage("img/pause.png")

    self.resume=Button.new(500,225,200,50, "backgrounds/ingame/resume.png")
    self.restart=Button.new(500,300,250,50, "backgrounds/ingame/restart.png")
    self.options=Button.new(500,375,250,50, "backgrounds/ingame/options.png")
    self.quit=Button.new(550,450,250,50, "backgrounds/ingame/quit.png")


    self.selection = {
        self.resume,
        self.restart,
        self.options,
        self.quit
    }

    self.selected = 1
    self.resume:setSelected(true)

    self.optionsFlag = false
    self.optionsMenu = OptionsPauseMenu.new(self)

    return self
end

function PauseMenu:setEnable(isEnable)
	self.isActive=isEnable
end

function PauseMenu:update(dt)
end

function PauseMenu:keyPressed(key, unicode)

    if not self.optionsFlag then
        if key == 'down' or key =='tab' then
            self:incrementSelection()
        elseif key =='up' then
            self:decrementSelection()
    
        elseif key == "return"then

            if self.resume.selected then
                gameStateManager.state['GameplaySolo'].gameIsPaused=false
                self.isActive=false
            end


            if self.restart.selected then
            local mapFile =gameStateManager.state['GameplaySolo'].mapFile
            local continuous =gameStateManager.state['GameplaySolo'].continuous
            local player =gameStateManager.state['GameplaySolo'].player
            gameStateManager.state['GameplaySolo']:destroy()
            gameStateManager:resetLoader()
            gameStateManager.state['GameplaySolo'] =nil
            gameStateManager.state['GameplaySolo'] = GameplaySolo.new(mapFile,continuous,player)
            gameStateManager:changeState('GameplaySolo')    
            end


            if self.options.selected then
                self.optionsFlag=true
            end


            if self.quit.selected then
                gameStateManager.state['GameplaySolo'].gameIsPaused=false
                gameStateManager.state['GameplaySolo']:destroy()
                gameStateManager:changeState('ChoixNiveauSolo')
                self.isActive=false
            end

        end
    else
        self.optionsMenu:keyPressed(key,unicode)
    end
end



function PauseMenu:sendPauseOrder()
   if self.isActive then
    if not self.optionsFlag then
        gameStateManager.state['GameplaySolo'].gameIsPaused=false    
        self.isActive = false
    else
            self.optionsFlag = false

    end
   else
    gameStateManager.state['GameplaySolo'].gameIsPaused=true    
    self.isActive = true
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
            if self.optionsFlag then
                self.optionsMenu:draw()
                return
            end
            love.graphics.draw(self.back,250,50)
            self.resume:draw(1)
            self.restart:draw(1)
            self.options:draw(1)
            self.quit:draw(1)
        end
end
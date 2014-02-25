--[[ 
This file is part of the Field project
]]

require("ui.optionspausemenu")

PauseMenu = {}
PauseMenu.__index =  PauseMenu

function PauseMenu.new(x,y,w,l)
    local self = {}
    setmetatable(self, PauseMenu)

    self.back = s_resourceManager:LoadImage("img/pause.png")

    local resume=Button.new(500,225,200,50, "backgrounds/ingame/resume.png", "resume")
    local restart=Button.new(500,300,250,50, "backgrounds/ingame/restart.png", "restart")
    local options=Button.new(500,375,250,50, "backgrounds/ingame/options.png", "options")
    local quit=Button.new(550,450,250,50, "backgrounds/ingame/quit.png", "quit")

    self.layout = UILayout.new()

    self.layout:addSelectable(resume)
    self.layout:addSelectable(restart)
    self.layout:addSelectable(options)
    self.layout:addSelectable(quit)

    self.layout:Init()

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
        self.layout:inputPressed(key)
        local name = self.layout:getSelectedName()
        if key == InputType.START then

            if name == "resume" then
                PushEvent("Gameplay", {sort=GameplayEvents.Pause, val=false})
                self.isActive=false
            end


            if name == "restart" then
                PushEvent("Gameplay", {sort=GameplayEvents.Reset}) 
            end


            if name == "options" then
                self.optionsFlag=true
            end


            if name == "quit" then
                PushEvent("Gameplay", {sort=GameplayEvents.Quit})
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
        PushEvent("Gameplay", {sort=GameplayEvents.Pause, val=false})
        self.isActive = false
    else
            self.optionsFlag = false

    end
   else
    PushEvent("Gameplay", {sort=GameplayEvents.Pause, val=true})    
    self.isActive = true
   end
end

function PauseMenu:draw(filter)
        if  self.isActive then
            if self.optionsFlag then
                self.optionsMenu:draw()
                return
            end
            love.graphics.draw(self.back,250,50)
            self.layout:draw(filter)
        end
end
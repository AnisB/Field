--[[ 
This file is part of the Field project
]]


require("ui.scroller")
require("ui.checkbox")

OptionsPauseMenu = {}
OptionsPauseMenu.__index =  OptionsPauseMenu

function OptionsPauseMenu.new( father )
    local self = {}
    setmetatable(self, OptionsPauseMenu)

    self.back = love.graphics.newImage("img/pause.png")

    self.musicVolume=Scroller.new(310,225,"backgrounds/ingame/volume.png", MUSIC_VOL,20)
    self.paralax=CheckBox.new(340,300,"backgrounds/ingame/paralax.png",true,125)
    self.returnB=Button.new(500,450,250,50, "backgrounds/ingame/return.png")


    self.selection = {
        self.musicVolume,
        self.paralax,
        self.returnB
    }

    self.father = father

    self.selected = 1
    self.musicVolume:setSelected(true)

    return self
end

function OptionsPauseMenu:setEnable(isEnable)
	self.isActive=isEnable
end

function OptionsPauseMenu:update(dt)
end

function OptionsPauseMenu:keyPressed(key, unicode) 
    if key == 'down' or key =='tab' then
            self:incrementSelection()

        elseif key =='up' then
            self:decrementSelection()
    
        elseif key == "right" and self.musicVolume.selected then
            if (self.musicVolume.scrollPosition <0.9) then
                self.musicVolume.scrollPosition = self.musicVolume.scrollPosition +0.1  
                musicM:setVolume(self.musicVolume.scrollPosition)
            end
        elseif key == "left" and self.musicVolume.selected then
            if (self.musicVolume.scrollPosition >= 0.1)then
                self.musicVolume.scrollPosition = self.musicVolume.scrollPosition -0.1  
                musicM:setVolume(self.musicVolume.scrollPosition)
            end
        elseif key == "return" or key == 3 then

            if self.paralax.selected then
                self.paralax.state = not self.paralax.state
                gameStateManager.state['GameplaySolo'].paralax = self.paralax.state
            end

            if self.returnB.selected then
                self.father.optionsFlag = false
            end

        end
end



function OptionsPauseMenu:incrementSelection()
    self.selection[self.selected]:setSelected(false)
    if self.selected == #self.selection then
        self.selected = 0
    end
    self.selected = self.selected + 1
    self.selection[self.selected]:setSelected(true)
end

function OptionsPauseMenu:decrementSelection()
    self.selection[self.selected]:setSelected(false)
        if self.selected == 1 then
        self.selected = #self.selection + 1
    end
    self.selected = self.selected - 1
    self.selection[self.selected]:setSelected(true)
end

function OptionsPauseMenu:draw()
    love.graphics.draw(self.back,250,50)
    self.musicVolume:draw(1)
    self.paralax:draw(1)
    self.returnB:draw(1)
end
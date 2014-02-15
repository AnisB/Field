--[[ 
This file is part of the Field project
]]

require("ui.label")
require("ui.specialbutton")

ConfirmationPopUp = {}
ConfirmationPopUp.__index =  ConfirmationPopUp

function ConfirmationPopUp.new()
    local self = {}
    setmetatable(self, ConfirmationPopUp)
    self.confirm = Label.new(450,220)
    self.confirm = Label.new(450,220)
    self.yes = SpecialButton.new(530,450,100,50,"Yes","yes")
    self.no = SpecialButton.new(660,450,100,50,"No","no")
    self.labels={}
    self.selection = {
        self.yes,
        self.no
    }
    self.selected = 1
    self.yes:setSelected(true)
    return self
end

function ConfirmationPopUp:incrementSelection()
    self.selection[self.selected]:setSelected(false)
    if self.selected == #self.selection then
        self.selected = 0
    end
    self.selected = self.selected + 1
    self.selection[self.selected]:setSelected(true)
end

function ConfirmationPopUp:getSelectedName()
    print("dudedude")
    return self.selection[self.selected].name
end

function ConfirmationPopUp:decrementSelection()
    self.selection[self.selected]:setSelected(false)
        if self.selected == 1 then
        self.selected = #self.selection + 1
    end
    self.selected = self.selected - 1
    self.selection[self.selected]:setSelected(true)
end

function ConfirmationPopUp:setEnable(isEnable)
	self.isActive=isEnable
end

function ConfirmationPopUp:update(dt)
end


function ConfirmationPopUp:inputPressed(key, unicode) 
        if(key == InputType.RIGHT) then
            self:incrementSelection()
        elseif (key == InputType.LEFT) then 
            self:decrementSelection()
        end
end


function ConfirmationPopUp:draw()
        if  self.isActive then
            love.graphics.setColor(50, 50, 50, 120)
            love.graphics.rectangle("fill", 400, 200, 500, 350)
            love.graphics.setColor(255, 255, 255, 255)
            love.graphics.print("Are you sure about",450,220)
            love.graphics.print("quitting?",560,260)
            self.yes:draw(0,0,1)
            self.no:draw(0,0,1)
        end
end
--[[ 
This file is part of the Field project]]

require("ui.button")


UILayout = {}
UILayout.__index = UILayout


function UILayout.new()
    local self = {}
    setmetatable(self, UILayout)
    self.filter=1

    local selection = {
    }
    local drwbls = {}
    self.drawables  = drwbls
    self.selection = selection
    self.selected = 1
    self.isPopUp = false
    return self
end

function UILayout:Init()
	self.selected = 1
	self.selection[self.selected]:setSelected(true)
end


function UILayout:addDrawable(parDrawable)
	table.insert(self.drawables, parDrawable)
end

function UILayout:addSelectable(parSelectable)
	table.insert(self.drawables, parSelectable)
	table.insert(self.selection, parSelectable)
end

function UILayout:setPopUp(parPopUp)
	self.popUp = parPopUp
end

function UILayout:getSelectedName()
	if(not self.isPopUp) then
		return self.selection[self.selected].name
	else
		return self.popUp:getSelectedName()
	end
end

function UILayout:enablePopUp(parFlag)
	self.isPopUp = parFlag
	self.popUp:setEnable(parFlag)
end

function UILayout:setFocused(name, focus)
	for i,v in pairs(self.selection) do
		if v.name == name then
			v:setFocused(focus)
			return
		end
	end
end
function UILayout:inputPressed(key, player)
	if(not self.isPopUp) then
		if(key == InputType.DOWN) then
			self:incrementSelection()
		elseif (key == InputType.UP) then 
			self:decrementSelection()
		end
	else
		self.popUp:inputPressed(key,player)
	end
end

function UILayout:inputPressedSecond(key, player)
	if(not self.isPopUp) then
		if(key == InputType.RIGHT) then
			self:incrementSelection()
		elseif (key == InputType.LEFT) then 
			self:decrementSelection()
		end
	else
		self.popUp:inputPressed(key,player)
	end
end

function UILayout:inputReleased(key, unicode)
end


function UILayout:incrementSelection()
	self.selection[self.selected]:setSelected(false)
	if self.selected == #self.selection then
		self.selected = 0
	end
	self.selected = self.selected + 1
	self.selection[self.selected]:setSelected(true)
end

function UILayout:decrementSelection()
	self.selection[self.selected]:setSelected(false)
		if self.selected == 1 then
		self.selected = #self.selection + 1
	end
	self.selected = self.selected - 1
	self.selection[self.selected]:setSelected(true)
end

function UILayout:update(dt) 
	for i,v in pairs(self.drawables) do
		v:update(dt)
	end
end


function UILayout:draw(filter)
	if(not self.isPopUp) then
		for i,v in pairs(self.drawables) do
			v:draw(filter)
		end
	else
		for i,v in pairs(self.drawables) do
			v:draw(filter/2)
		end

 		self.popUp:draw()

	end
end

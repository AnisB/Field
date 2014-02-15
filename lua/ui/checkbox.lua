--[[ 
This file is part of the Field project
]]


CheckBox = {}
CheckBox.__index =  CheckBox

CheckBox.HighLight = love.graphics.newImage(ImgDirectory..'selection.png')
CheckBox.box = love.graphics.newImage("img/uielements/box.png")
CheckBox.cross = love.graphics.newImage("img/uielements/cross.png")


function CheckBox.new(x,y,img,initialValue, dec)
    local self = {}
    setmetatable(self, CheckBox)

    self.position={x=x,y=y}
    self.dimension={w=w,l=l}
    self.img=love.graphics.newImage(img)
    self.dec = dec
    self.selected=false
    self.enabled=true
    self.select = CheckBox.HighLight
    self.state =  initialValue
    return self
end


function CheckBox:update(dt)

end


function CheckBox:setEnable(val)
	self.enabled=val
end

function CheckBox:setSelected(val)
	self.selected=val
end

function CheckBox:setChecked(val)
	self.state=val
end

function CheckBox:basicDraw(filter)
	love.graphics.setColor(255,255,255,255*filter)
	love.graphics.draw(CheckBox.box, self.position.x+255 +self.dec, self.position.y)
	if self.state then
		love.graphics.draw(CheckBox.cross, self.position.x+255 +self.dec, self.position.y)
	end
	love.graphics.draw(self.img, self.position.x+25, self.position.y+20)
	love.graphics.setColor(255,255,255,255)
end



function CheckBox:selectedDraw(filter)
	love.graphics.setColor(255,255,255,255*filter)
	love.graphics.draw(self.select, self.position.x-20, self.position.y+20)
	love.graphics.draw(CheckBox.box, self.position.x+255 +self.dec, self.position.y)
	if self.state then
		love.graphics.draw(CheckBox.cross, self.position.x+255 +self.dec, self.position.y)
	end
	love.graphics.draw(self.img, self.position.x+25, self.position.y+20)
	love.graphics.setColor(255,255,255,255)
end




function CheckBox:disabledDraw(filter)
	love.graphics.setColor(100,100,100,255*filter)
	-- Not implemented yet
	love.graphics.setColor(255,255,255,255)
end


function CheckBox:disabledSelectedDraw(filter)
	love.graphics.setColor(100,100,100,255*filter)
	-- Not implemented yet
	love.graphics.setColor(255,255,255,255)
end

function CheckBox:draw(x,y,filter)
	if not self.enabled then
		if self.selected then
			self:disabledSelectedDraw(x,y,filter)
		else
			self:disabledDraw(x,y,filter)
		end
	elseif self.selected then
		self:selectedDraw(x,y,filter)
	else
		self:basicDraw(x,y,filter)
	end
end
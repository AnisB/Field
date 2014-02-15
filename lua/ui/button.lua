--[[ 
This file is part of the Field project
]]


Button = {}
Button.__index =  Button

Button.HighLight = s_resourceManager:LoadImage(ImgDirectory..'selection.png')


function Button.newDec(x,y,w,l,img,decx,decy)
    local self = {}
    setmetatable(self, Button)
    self.position={x=x,y=y}
    self.dimension={w=w,l=l}
    self.img=s_resourceManager:LoadImage(img)
    self.dec={x=decx,y=decy}
    self.selected=false
    self.enabled=true
    self.select = Button.HighLight
    return self
end

function Button.new(x,y,w,l,img,name)
    local self = {}
    setmetatable(self, Button)
    self.position={x=x,y=y}
    self.dimension={w=w,l=l}
    self.img=love.graphics.newImage(img)
    self.dec={x=0,y=0}
    self.selected=false
    self.enabled=true
    self.select = Button.HighLight
    self.name = name
    return self
end

function Button:decaler(decx,decy)
    self.dec.x = decx
    self.dec.y = decy
end


function Button:isCliked(x,y)

	return( x > self.position.x and x < self.position.x+self.dimension.w and y > self.position.y and y < self.position.y+self.dimension.l )
end

function Button:update(dt)

end


function Button:setEnable(val)
	self.enabled=val
end

function Button:setSelected(val)
	self.selected=val
end


function Button:basicDraw(filter)
	love.graphics.setColor(255*filter,255*filter,255*filter,255*filter)
	love.graphics.draw(self.img, self.position.x+25, self.position.y+20)
	love.graphics.setColor(255,255,255,255)
end



function Button:selectedDraw(filter)
	love.graphics.setColor(255*filter,255*filter,255*filter,255*filter)
	love.graphics.draw(self.select, self.position.x-20, self.position.y+20)
	love.graphics.draw(self.img, self.position.x+25, self.position.y+20)
	love.graphics.setColor(255,255,255,255)
end




function Button:disabledDraw(filter)
	love.graphics.setColor(100,100,100,255*filter)
	love.graphics.draw(self.img, self.position.x+25, self.position.y+20)
	love.graphics.setColor(255,255,255,255)
end


function Button:disabledSelectedDraw(filter)
	love.graphics.setColor(100,100,100,255*filter)
	love.graphics.draw(self.select, self.position.x-20, self.position.y+20)
	love.graphics.draw(self.img, self.position.x+25, self.position.y+20)
	love.graphics.setColor(255,255,255,255)
end

function Button:draw(filter)
	if not self.enabled then
		if self.selected then
			self:disabledSelectedDraw(filter)
		else
			self:disabledDraw(filter)
		end
	elseif self.selected then
		self:selectedDraw(filter)
	else
		self:basicDraw(filter)
	end
end
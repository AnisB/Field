--[[ 
This file is part of the Field project
]]


SpecialButton = {}
SpecialButton.__index =  SpecialButton




function SpecialButton.new(x,y,w,l,text,name)
    local self = {}
    setmetatable(self, SpecialButton)
    self.position={x=x,y=y}
    self.dimension={w=w,l=l}
    self.type=type
    self.text=text
    self.selected = false
    self.enabled = true
    self.name = name
    return self
end

function SpecialButton:update(dt)

end

function SpecialButton:isCliked(x,y)

	return( x > self.position.x and x < self.position.x+self.dimension.w and y > self.position.y and y < self.position.y+self.dimension.l )
end

function SpecialButton:update(dt)

end


function SpecialButton:setEnable(val)
	self.enabled=val
end

function SpecialButton:setSelected(val)
	self.selected=val
end


function SpecialButton:basicDraw(filter)
	love.graphics.setColor(150,150,150,255*filter)
	love.graphics.rectangle("fill", self.position.x, self.position.y, self.dimension.w, self.dimension.l)
	love.graphics.setColor(255, 255,255, 255*filter)
	love.graphics.print(self.text,self.position.x+10, self.position.y+10)
end



function SpecialButton:selectedDraw(filter)
	love.graphics.setColor(150,150,150,255*filter)
	love.graphics.rectangle("fill", self.position.x, self.position.y, self.dimension.w, self.dimension.l)
	love.graphics.setColor(255, 100,100, 255*filter)
	love.graphics.print(self.text,self.position.x+10, self.position.y+10)
end




function SpecialButton:disabledDraw(x,y,filter)
	love.graphics.setColor(150,150,150,150*filter)
	love.graphics.rectangle("fill", self.position.x, self.position.y, self.dimension.w, self.dimension.l)
	love.graphics.setColor(150, 150,150, 255*filter)
	love.graphics.print(self.text,self.position.x+10, self.position.y+10)
end


function SpecialButton:draw(x,y,filter)
	if not self.enabled then
		self:disabledDraw(filter)
	elseif self.selected then
		self:selectedDraw(filter)
	else
		self:basicDraw(filter)
	end
end
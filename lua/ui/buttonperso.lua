--[[ 
This file is part of the Field project
]]


ButtonPerso = {}
ButtonPerso.__index =  ButtonPerso

ButtonPerso.HighLight = love.graphics.newImage(ImgDirectory..'selection.png')


function ButtonPerso.new(x,y,img, name)
    local self = {}
    setmetatable(self, ButtonPerso)
    self.position={x=x,y=y}
    self.dimension={w=300,l=300}
    self.img=love.graphics.newImage(img)
    self.dec={x=0,y=300}
    self.selected=false
    self.enabled=true
    self.focused=false
    self.focusedsecond=false
    self.select = ButtonPerso.HighLight
    self.name = name
    return self
end

function ButtonPerso:isCliked(x,y)

	return( x > self.position.x and x < self.position.x+self.dimension.w and y > self.position.y and y < self.position.y+self.dimension.l )
end

function ButtonPerso:update(dt)

end


function ButtonPerso:setEnable(val)
	self.enabled=val
end

function ButtonPerso:setSelected(val)
	self.selected=val
end

function ButtonPerso:setFocused(val)
	self.focused=val
end
function ButtonPerso:setFocusedSecond(val)
	self.focusedsecond=val
end

function ButtonPerso:basicDraw(filter)
	if(self.focused) then
		love.graphics.setColor(255,100,100,255*filter)
	elseif self.focusedsecond then
		love.graphics.setColor(100,100,255,255*filter)
	else
		love.graphics.setColor(255,255,255,255*filter)
	end
	love.graphics.draw(self.img, self.position.x+25+self.dec.x, self.position.y+20+self.dec.y)
	love.graphics.setColor(255,255,255,255)
end



function ButtonPerso:selectedDraw(filter)
	love.graphics.setColor(255,255,255,255)
	love.graphics.draw(self.select, self.position.x+160, self.position.y+280)
	if(self.focused) then
		love.graphics.setColor(255,100,100,255*filter)
	elseif self.focusedsecond then
		love.graphics.setColor(100,100,255,255*filter)
	else
		love.graphics.setColor(255,255,255,255*filter)
	end
	love.graphics.draw(self.img, self.position.x+25+self.dec.x, self.position.y+20+self.dec.y)
	love.graphics.setColor(255,255,255,255)
end




function ButtonPerso:disabledDraw(filter)
	love.graphics.setColor(100,100,100,255*filter)
	love.graphics.draw(self.img, self.position.x+25+self.dec.x, self.position.y+20+self.dec.y)
	love.graphics.setColor(255,255,255,255)
end


function ButtonPerso:disabledSelectedDraw(filter)
	love.graphics.setColor(100,100,100,255*filter)
	love.graphics.draw(self.select, self.position.x-20, self.position.y+20)
	love.graphics.draw(self.img, self.position.x+25+self.dec.x, self.position.y+20+self.dec.y)
	love.graphics.setColor(255,255,255,255)
end

function ButtonPerso:draw(x,y,filter)
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
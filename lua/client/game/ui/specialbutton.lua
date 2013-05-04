--[[ 
This file is part of the Field project
]]


SpecialButton = {}
SpecialButton.__index =  SpecialButton





SpecialButtonType={Small="s",Large="l",Perso="l"}

function SpecialButton.new(x,y,w,l,type,text)
    local self = {}
    setmetatable(self, SpecialButton)
    self.position={x=x,y=y}
    self.dimension={w=w,l=l}
    self.type=type
    self.text=text

    return self
end

function SpecialButton:isCliked(x,y)

	if x > self.position.x and x < self.position.x+self.dimension.w and y > self.position.y and y < self.position.y+self.dimension.l then
		return true
	end 
	return false
end

function SpecialButton:update(dt)

end


function SpecialButton:draw(x,y,filter)
	love.graphics.setCaption(255,255,255,255*filter)
	if x > self.position.x and x < self.position.x+self.dimension.w and y > self.position.y and y < self.position.y+self.dimension.l then
		love.graphics.draw(self.type, self.position.x, self.position.y)
	end
	if self.type==SpecialButtonType.Large then
		love.graphics.draw(self.img, self.position.x+30, self.position.y+25)
	elseif self.type==SpecialButtonType.Small then
		love.graphics.draw(self.img, self.position.x+30, self.position.y+20)
	elseif self.type==SpecialButtonType.Perso then
		love.graphics.draw(self.img, self.position.x+30, self.position.y+20)
	end

end
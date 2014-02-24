--[[ 
This file is part of the Field project
]]


Scroller = {}
Scroller.__index =  Scroller

Scroller.HighLight = s_resourceManager:LoadImage(ImgDirectory..'selection.png')
Scroller.base = s_resourceManager:LoadImage("img/uielements/scroller.png")
Scroller.mover = s_resourceManager:LoadImage("img/uielements/level.png")


function Scroller.new(x,y,img,initialPos, dex)
    local self = {}
    setmetatable(self, Scroller)

    self.position={x=x,y=y}
    self.dimension={w=w,l=l}
    self.img=s_resourceManager:LoadImage(img)
    self.dec = dex
    self.selected=false
    self.enabled=true
    self.select = Scroller.HighLight
    self.scrollPosition =  initialPos
    return self
end

function Scroller:update(dt)

end


function Scroller:setEnable(val)
	self.enabled=val
end

function Scroller:setSelected(val)
	self.selected=val
end


function Scroller:basicDraw(filter)
	love.graphics.setColor(255,255,255,255*filter)
	love.graphics.draw(Scroller.base, self.position.x+255, self.position.y+30)
	-- love.graphics.draw(Scroller.mover, self.position.x+255 + self.scrollPosition*240  , self.position.y+30)
	love.graphics.draw(self.img, self.position.x+25, self.position.y+20)
	love.graphics.setColor(255,255,255,255)
end



function Scroller:selectedDraw(filter)
	love.graphics.setColor(255,255,255,255*filter)
	love.graphics.draw(self.select, self.position.x-20, self.position.y+20)
	love.graphics.draw(Scroller.base, self.position.x+255, self.position.y+30)
	-- love.graphics.draw(Scroller.mover, self.position.x+255 + self.scrollPosition*240 , self.position.y+30)
	love.graphics.draw(self.img, self.position.x+25, self.position.y+20)
	love.graphics.setColor(255,255,255,255)
end




function Scroller:disabledDraw(filter)
	love.graphics.setColor(100,100,100,255*filter)
	-- Not implemented yet
	love.graphics.setColor(255,255,255,255)
end


function Scroller:disabledSelectedDraw(filter)
	love.graphics.setColor(100,100,100,255*filter)
	-- Not implemented yet
	love.graphics.setColor(255,255,255,255)
end

function Scroller:draw(x,y,filter)
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
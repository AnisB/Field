--[[ 
This file is part of the Field project
]]


Button = {}
Button.__index =  Button



ButtonType={Small=love.graphics.newImage(ButtonImg.."small.png"),Large=love.graphics.newImage(ButtonImg.."large.png"),Perso=love.graphics.newImage(ButtonImg.."perso.png"),Arrow=love.graphics.newImage(ButtonImg.."arrow.png"),VLarge=love.graphics.newImage(ButtonImg.."verylarge.png")}

function Button.newDec(x,y,w,l,type,img,decx,decy)
    local self = {}
    setmetatable(self, Button)
    self.position={x=x,y=y}
    self.dimension={w=w,l=l}
    self.type=type
    self.img=love.graphics.newImage(img)
    self.dec={x=decx,y=decy}
    self.selected=false
    self.enabled=true
    return self
end

function Button.new(x,y,w,l,type,img)
    local self = {}
    setmetatable(self, Button)
    self.position={x=x,y=y}
    self.dimension={w=w,l=l}
    self.type=type
    self.img=love.graphics.newImage(img)
    self.dec={x=0,y=0}
    self.selected=false
    self.enabled=true
    return self
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


function Button:basicDraw(x,y,filter)
	love.graphics.setColor(255,255,255,255*filter)
	if x > self.position.x and x < self.position.x+self.dimension.w and y > self.position.y and y < self.position.y+self.dimension.l then
		love.graphics.draw(self.type, self.position.x, self.position.y)
	end
	if self.type==ButtonType.Large then
		love.graphics.draw(self.img, self.position.x+25+self.dec.x, self.position.y+20+self.dec.y)
	elseif self.type==ButtonType.Small then
		love.graphics.draw(self.img, self.position.x+15+self.dec.x, self.position.y+15+self.dec.y)
	elseif self.type==ButtonType.Perso then
		love.graphics.draw(self.img, self.position.x+15+self.dec.x, self.position.y+20+self.dec.y)
	else
		love.graphics.draw(self.img, self.position.x+self.dec.x, self.position.y+self.dec.y)
	end
	love.graphics.setColor(255,255,255,255)
end



function Button:selectedDraw(x,y,filter)

	love.graphics.setColor(255,255,255,255*filter)
	if x > self.position.x and x < self.position.x+self.dimension.w and y > self.position.y and y < self.position.y+self.dimension.l then
		love.graphics.draw(self.type, self.position.x, self.position.y)
	end
	love.graphics.setColor(200,100,100,255*filter)
	if self.type==ButtonType.Large then
		love.graphics.draw(self.img, self.position.x+25+self.dec.x, self.position.y+20+self.dec.y)
	elseif self.type==ButtonType.Small then
		love.graphics.draw(self.img, self.position.x+15+self.dec.x, self.position.y+15+self.dec.y)
	elseif self.type==ButtonType.Perso then
		love.graphics.draw(self.img, self.position.x+15+self.dec.x, self.position.y+20+self.dec.y)
	else
		love.graphics.draw(self.img, self.position.x+self.dec.x, self.position.y+self.dec.y)
	end
	love.graphics.setColor(255,255,255,255)
end




function Button:disabledDraw(x,y,filter)
	love.graphics.setColor(100,100,100,255*filter)
	love.graphics.draw(self.type, self.position.x, self.position.y)
	if self.type==ButtonType.Large then
		love.graphics.draw(self.img, self.position.x+25+self.dec.x, self.position.y+20+self.dec.y)
	elseif self.type==ButtonType.Small then
		love.graphics.draw(self.img, self.position.x+15+self.dec.x, self.position.y+15+self.dec.y)
	elseif self.type==ButtonType.Perso then
		love.graphics.draw(self.img, self.position.x+15+self.dec.x, self.position.y+20+self.dec.y)
	else
		love.graphics.draw(self.img, self.position.x+self.dec.x, self.position.y+self.dec.y)
	end
	love.graphics.setColor(255,255,255,255)
end


function Button:draw(x,y,filter)
	if not self.enabled then
		self:disabledDraw(x,y,filter)
	elseif self.selected then
		self:selectedDraw(x,y,filter)
	else
		self:basicDraw(x,y,filter)
	end
end
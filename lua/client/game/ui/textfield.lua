--[[ 
This file is part of the Field project
]]


TextField = {}
TextField.__index =  TextField

TextField.Types={Text="txt", IP="ip", Pass="pass"}
function TextField.new(x,y,w,l,text,type)
    local self = {}
    setmetatable(self, TextField)


    self.position={x=x,y=y}
    self.dimension={w=w,l=l}
    self.selected=false
    self.enabled=true
    self.text = text
    self.className = "TextField"
    self.type = type
    return self
end

function TextField:update(dt)

end

	function TextField:keyPressed(key, unicode)
		if self.type == TextField.Types.IP then
			if key == "backspace" then
				self.text = string.sub(self.text, 0, -2)
			elseif key == "tab" then
				self.focused="pseudo"
			else
			    local car
			    if key == "a" or key == "1" then car = "1"
			    elseif key == "z" or key == "2" then car = "2"
			    elseif key == "e" or key == "3" then car = "3"
			    elseif key == "r" or key == "4" then car = "4"
			    elseif key == "t" or key == "5" then car = "5"
			    elseif key == "y" or key == "6" then car = "6"
			    elseif key == "u" or key == "7" then car = "7"
			    elseif key == "i" or key == "8" then car = "8"
			    elseif key == "o" or key == "9" then car = "9"
			    elseif key == "p" or key == "0" then car = "0"
			    elseif key == "." or key == ";" then car = "."
			    else
			    	return 
			    end
			    self.text = self.text .. car
			end
		else if TextField.Types.Text then
			if key=="backspace" then
				self.text = string.sub(self.text, 0, -2)
			elseif key == "lshift" or  key == "rshift" or  key == "rctrl"  or  key == "lctrl" or key == "left" or key == "right"  then
			else
				self.text = self.text .. key
			end
		end
	end
end
function TextField:setEnable(val)
	self.enabled=val
end

function TextField:setSelected(val)
	self.selected=val
end


function TextField:setText(text)
	self.text = text
end

function TextField:basicDraw(filter)
	love.graphics.setColor(255,255,255,255*filter)
	love.graphics.setColor(50, 50, 50, 255)
	love.graphics.rectangle("fill", self.position.x, self.position.y, self.dimension.w , self.dimension.l)
	love.graphics.setColor(255,255,255,255)	
	love.graphics.print(self.text, self.position.x + 10, self.position.y )
end



function TextField:selectedDraw(filter)
	love.graphics.setColor(255,255,255,255*filter)
	love.graphics.setColor(150, 150, 150, 255)
	love.graphics.rectangle("fill", self.position.x, self.position.y, self.dimension.w , self.dimension.l)
	love.graphics.setColor(255,255,255,255)	
	love.graphics.print(self.text, self.position.x + 10, self.position.y )
end




function TextField:disabledDraw(filter)
	love.graphics.setColor(100,100,100,255*filter)
	love.graphics.draw(self.img, self.position.x+25+self.dec.x, self.position.y+20+self.dec.y)
	love.graphics.setColor(255,255,255,255)
end


function TextField:disabledSelectedDraw(filter)
	love.graphics.setColor(100,100,100,255*filter)
	love.graphics.draw(self.select, self.position.x-20, self.position.y+20)
	love.graphics.draw(self.img, self.position.x+25+self.dec.x, self.position.y+20+self.dec.y)
	love.graphics.setColor(255,255,255,255)
end

function TextField:draw(filter)
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
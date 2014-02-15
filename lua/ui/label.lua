--[[ 
This file is part of the Field project
]]


Label = {}
Label.__index =  Label


function Label.new(x,y,text)
    local self = {}
    setmetatable(self, Label)
    self.position={x=x,y=y}
    self.text=text
    return self
end

function Label:update(dt)

end

function Label:setText(newT)
	self.text=newT
end


function Label:Draw(x,y,filter)
	love.graphics.printf(self.text,x,y)
end
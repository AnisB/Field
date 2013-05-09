--[[ 
This file is part of the Field project
]]


PopUp = {}
PopUp.__index =  PopUp

function PopUp.new(x,y,w,l)
    local self = {}
    setmetatable(self, PopUp)
    self.position={x=x,y=y}
    self.dimension={w=w,l=l}
    self.buttons={}
    self.labels={}

    return self
end


function PopUp:addButton(newButton,id)
	assert(newButton~=nil)
	self.buttons[id]=newButton
	self.isActive=false
end

function PopUp:handleMousePress(x,y)
	for id,button in pairs(self.buttons) do
		if button:isCliked(x,y) then
			return id
		end
	end
end

function PopUp:addLabel(newLabel)
	assert(newLabel~=nil)
	table.insert(self.labels,newLabel)
end


function PopUp:setEnable(isEnable)
	self.isActive=isEnable
end

function PopUp:update(dt)
end


function PopUp:draw(x,y)
        if  self.isActive then
        	love.graphics.setColor(0,0,0,150)
            love.graphics.rectangle("fill", 0, 0, windowW, windowH)
        	love.graphics.setColor(100,100,100,200)
            love.graphics.rectangle("fill", self.position.x, self.position.y, self.dimension.w, self.dimension.l)
            for i,b in self.buttons do
            	b.draw(x,y)
            end
            for i,l in self.labels do
            	l.draw(x,y)
            end
        end
end
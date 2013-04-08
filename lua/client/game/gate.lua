

require("game.field")



Gate = {}
Gate.__index = Gate


function Gate.new(pos,w,h,open)
	local self = {}
	setmetatable(self, Gate)
	self.position={x=pos.x,y=pos.y}
    -- Type
    self.type='Gate' 
    self.w=w
    self.h=h
    if open=="true" then
    	self.open=true
	else
		self.open=false
	end
	self.drawed=true
    return self
end

-- function Gate:syncronize(pos,anim,id)
function Gate:syncronize(pos,open)
	-- if (self.anim.currentAnim.name~=anim) then
	-- 	self.anim:syncronize(anim,id)
	-- end        
	self.position.x=pos.x
	self.position.y=pos.y
    if open=="true" then
    	self.open=true
	else
		self.open=false
	end
	self.drawed=true	
end


function Gate:getPosition(  )
	return self.position
end

function Gate:update(seconds)
end

function Gate:draw()
	love.graphics.setColor(255,100,100,255)
	if self.open==false then
		love.graphics.rectangle( "fill", self.position.x,self.position.y, self.w, self.h )
	end
	love.graphics.setColor(255,255,255,255)
end
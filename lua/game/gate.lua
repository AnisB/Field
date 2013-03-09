

require("game.field")



Gate = {}
Gate.__index = Gate


function Gate.new(pos,w,h,ID)
	local self = {}
	setmetatable(self, Gate)
	self.id=ID
	self.position={x=pos.x,y=pos.y}
    -- Type
    self.type='Gate' 
    self.w=w
    self.h=h
    decalage={w/2,h/2}
    self.pc = Physics.newRectangle(self.position.x,self.position.y,w,h,true,decalage)
    self.pc.fixture:setUserData(self)    
	self.open= false
	return self
end

	function Gate:isAppliable(pos)
		local ax =pos.x-self.position.x
		local ay =pos.y-self.position.y
		if math.abs(math.sqrt(ax*ax+ay*ay))<=self.fieldRadius then
			return true
		else
			return false
		end
	end
	
	function Gate:getPosition()
		return self.position
	end
	

	
	function Gate:collideWith( object, collision )
	end
	
	function Gate:unCollideWith( object, collision )

	end

	function Gate:openG( )
	self.open= true
	self.pc.fixture:setFilterData(1,1,-1)
	Sound.playSound("door")

	end

	function Gate:closeG( )
	self.open= false
	self.pc.fixture:setFilterData(1,1,0)
	Sound.playSound("door")

	end


function Gate:getPosition(  )
	return self.position
end

function Gate:update(seconds)
	x,y =self.pc.body:getPosition()
	self.position.x=x
	self.position.y=y
end

function Gate:draw(x,y)
	love.graphics.setColor(255,100,100,255)
	if self.open==false then
    love.graphics.rectangle( "fill", self.position.x-x,self.position.y+y, self.w, self.h )
	end
end
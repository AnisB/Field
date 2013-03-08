



Acid = {}
Acid.__index = Acid


function Acid.new(pos,w,h)
	local self = {}
	setmetatable(self, Acid)
	self.position={x=pos.x,y=pos.y}
	self.w=w
	self.h=h
	local decalage={w/2,h/2}
	self.pc = Physics.newAcid(self.position.x,self.position.y,w,h,decalage)
	self.pc.fixture:setUserData(self)
	self.type='Acid'
	return self
end



function Acid:getPosition()
	return self.position
end


function Acid:preSolve(b,coll)
end



function Acid:collideWith( object, collision )
	if object.type=='MetalMan' or object.type =='TheMagnet' then
		print("He is dead now")
	end
end

function Acid:unCollideWith( object, collision )

end

function Acid:update(seconds)
	x,y =self.pc.body:getPosition()
	self.position.x=x
	self.position.y=y
end

function Acid:draw(x,y)
	love.graphics.setColor(100,255,100,255)
       love.graphics.rectangle( "fill", self.position.x-x,self.position.y+y, self.w,self.h)
end




Arc = {}
Arc.__index = Arc


ArcType={DebutH='DebutH',MillieuH='MillieuH',FinH='FinH',DebutV='DebutV',MillieuV='MillieuV',FinV='FinV'}
function Arc.new(pos,w,h,typeArc)
	local self = {}
	setmetatable(self, Arc)
	self.position={x=pos.x,y=pos.y}
	self.w=w
	self.h=h
	local decalage={w/2,h/2}
	self.pc = Physics.newZone(self.position.x,self.position.y,w,h,decalage)
	self.pc.fixture:setUserData(self)
	self.type='Arc'
	self.arcType=typeArc
	return self
end



function Arc:getPosition()
	return self.position
end


function Arc:preSolve(b,coll)
end



function Arc:collideWith( object, collision )
	if object.type=='MetalMan' or object.type =='TheMagnet' then
		print("He is dead now")
	end
end

function Arc:unCollideWith( object, collision )

end

function Arc:update(seconds)
	x,y =self.pc.body:getPosition()
	self.position.x=x
	self.position.y=y
end

function Arc:draw(x,y)
	love.graphics.setColor(100,100,255,255)
       love.graphics.rectangle( "fill", self.position.x-x,self.position.y+y, self.w,self.h)
end
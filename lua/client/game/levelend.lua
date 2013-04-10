



LevelEnd = {}
LevelEnd.__index = LevelEnd


function LevelEnd.new(pos,w,h,next)
	local self = {}
	setmetatable(self, LevelEnd)
	self.position={x=pos.x,y=pos.y}
	self.w=w
	self.h=h
	local decalage={w/2,h/2}
	self.pc = Physics.newZone(self.position.x,self.position.y,w,h,decalage)
	self.pc.fixture:setUserData(self)
	self.type='LevelEnd'
	self.counter=0
	self.next=next
	return self
end



function LevelEnd:getPosition()
	return self.position
end





function LevelEnd:preSolve(b,coll)
end



function LevelEnd:collideWith( object, collision )
	if object.type=='MetalMan' or object.type =='TheMagnet' then
		self.counter=self.counter+1;
	end
	if(self.counter==2) then
		print ("level finished")
		print(self.next)
	end
end

function LevelEnd:unCollideWith( object, collision )
	if object.type=='MetalMan' or object.type =='TheMagnet' then
		self.counter=self.counter-1;
	end
end

function LevelEnd:update(seconds)
	x,y =self.pc.body:getPosition()
	self.position.x=x
	self.position.y=y
end

function LevelEnd:draw(x,y)
	love.graphics.setColor(100,100,255,255)
       love.graphics.rectangle( "fill", self.position.x-x,self.position.y+y, self.w,self.h)
end
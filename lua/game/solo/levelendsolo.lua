



LevelEndSolo = {}
LevelEndSolo.__index = LevelEndSolo

TimerLevelEndSolo =1


function LevelEndSolo.new(pos,w,h,next)
	local self = {}
	setmetatable(self, LevelEndSolo)
	self.position={x=pos.x,y=pos.y}
	self.w=w
	self.h=h
	local decalage={w/2,h/2}
	self.pc = Physics.newZone(self.position.x,self.position.y,w,h,decalage)
	self.pc.fixture:setUserData(self)
	self.type='LevelEndSolo'
	self.counter=0
	self.next=next
	self.isTouched=false
	self.timer=0	
	return self
end



function LevelEndSolo:getPosition()
	return self.position
end


function LevelEndSolo:preSolve(b,coll)
end



function LevelEndSolo:collideWith( object, collision )
	if object.type=='MetalManSolo' or object.type =='TheMagnet' then
		self.isTouched=true
	end
end

function LevelEndSolo:unCollideWith( object, collision )
end

function LevelEndSolo:update(seconds)
	if self.isTouched then
		self.timer=self.timer+seconds
	end
	x,y =self.pc.body:getPosition()
	self.position.x=x
	self.position.y=y
	if(self.timer>=TimerLevelEndSolo) then
		self.isTouched=false
		s_gameStateManager:finish()
	end	
end

function LevelEndSolo:draw(x,y)
	love.graphics.setColor(100,100,255,255)
       love.graphics.rectangle( "fill", self.position.x-x,self.position.y+y, self.w,self.h)
end
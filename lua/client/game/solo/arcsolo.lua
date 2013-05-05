

require("game.solo.animarcsolo")

ArcSolo = {}
ArcSolo.__index = ArcSolo

TimerArcSolo =1

ArcSoloType={DebutH='DebutH',MillieuH='MillieuH',FinH='FinH',DebutV='DebutV',MillieuV='MillieuV',FinV='FinV'}
function ArcSolo.new(pos,w,h,typeArcSolo,netid)
	local self = {}
	setmetatable(self, ArcSolo)

	self.netid=netid
	self.position={x=pos.x,y=pos.y}
	self.w=w
	self.h=h
	local decalage={w/2,h/2}
	self.pc = Physics.newZone(self.position.x,self.position.y,w,h,decalage)
	self.pc.fixture:setUserData(self)
	self.type='ArcSolo'
	self.arcSoloType=typeArcSolo
	if( self.arcSoloType==ArcSoloType.MillieuV or self.arcSoloType==ArcSoloType.MillieuH ) then
		self.anim = AnimArcSolo.new('arc/arcmid')
	else
		self.anim = AnimArcSolo.new('arc/arcside')
	end
	self:loadAnimation("on",true)
	self.isTouched=false
	self.timer=0
	return self
end

function ArcSolo:loadAnimation(anim, force)
	self.anim:load(anim, force)
end


function ArcSolo:getPosition()
	return self.position
end


function ArcSolo:preSolve(b,coll)
end



function ArcSolo:collideWith( object, collision )
	if object.type=='MetalManSolo' or object.type =='TheMagnetSolo' then
		self.isTouched=true
		object:die()
		gameStateManager.state["GameplaySolo"]:slow(1)
		-- gameStateManager.state["GameplaySolo"]:shakeOnX(4,500,0.4)
		-- gameStateManager.state["GameplaySolo"]:shakeOnY(4,500,0.4)
	end
end

function ArcSolo:unCollideWith( object, collision )

end

function ArcSolo:update(seconds)
	if self.isTouched then
		self.timer=self.timer+seconds
	end
	self.anim:update(seconds)
	x,y =self.pc.body:getPosition()
	self.position.x=x
	self.position.y=y
	if(self.timer>=TimerArcSolo) then
		self.isTouched=false
		gameStateManager:failed()
	end
end

function ArcSolo:draw(x,y)
	love.graphics.setColor(255,255,255,255)

	if( self.arcSoloType==ArcSoloType.MillieuH or self.arcSoloType==ArcSoloType.DebutH) then
		love.graphics.draw(self.anim:getSprite(), self.position.x-x, self.position.y+y)
	elseif (  self.arcSoloType==ArcSoloType.MillieuV or self.arcSoloType==ArcSoloType.DebutV) then
		love.graphics.draw(self.anim:getSprite(), self.position.x-x +unitWorldSize, self.position.y+y,math.pi/2)
	elseif (  self.arcSoloType==ArcSoloType.FinV) then
		love.graphics.draw(self.anim:getSprite(), self.position.x-x , self.position.y+y+unitWorldSize,-math.pi/2)
	elseif (  self.arcSoloType==ArcSoloType.FinH) then
		love.graphics.draw(self.anim:getSprite(), self.position.x-x+unitWorldSize , self.position.y+y,0,-1,1)
	end
end

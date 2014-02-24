

require("game.solo.animarcsolo")

ArcSolo = {}
ArcSolo.__index = ArcSolo

TimerArcSolo =1

ArcSoloType={DebutH='DebutH',MillieuH='MillieuH',FinH='FinH',DebutV='DebutV',MillieuV='MillieuV',FinV='FinV'}
function ArcSolo.new(pos,w,h,typeArcSolo,id,enable, mapInfo)
	local self = {}
	setmetatable(self, ArcSolo)

	self.id=tonumber(id)
	self.position={x=pos.x,y=pos.y}
	if( typeArcSolo==ArcSoloType.MillieuH or typeArcSolo==ArcSoloType.DebutH or typeArcSolo==ArcSoloType.FinH) then
		self.w=64
		self.h=16
		local decalage={self.w/2,self.h/2}
		self.pc = Physics.newZone(self.position.x,self.position.y+24,self.w,self.h,decalage)
	else
		self.w=16
		self.h=64
		local decalage={self.w/2,self.h/2}
		self.pc = Physics.newZone(self.position.x + 24,self.position.y,self.w,self.h,decalage)
	end
	self.pc.fixture:setUserData(self)
	self.type='ArcSolo'
	self.arcSoloType=typeArcSolo
	if( self.arcSoloType==ArcSoloType.MillieuV or self.arcSoloType==ArcSoloType.MillieuH ) then
		self.anim = AnimArcSolo.new('arc/'..mapInfo.world..'/arcmid')
	else
		self.anim = AnimArcSolo.new('arc/'..mapInfo.world..'/arcside')
	end
	-- self:loadAnimation("on",true)
	self.isTouched=false
	self.timer=0
	self.diffuse  = love.graphics.newQuad(0, 0, 64, 64, 128, 64)
	if enable == "true" then
		self.enabled = true
	else
		self.enabled = false
	end

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

function ArcSolo:init()
    if self.enabled then
    	self.anim:load("on",true)
    else
    	self.anim:load("off",true)
	end
end



function ArcSolo:collideWith( object, collision )
	if self.enabled then
		if object.type=='MetalMan' or object.type =='TheMagnet' then
			self.isTouched=true
			object:die("Arc")
			PushEvent({type=Effects.Arc, sort=GameplayEvents.Die})
			PushEvent({sort=GameplayEvents.Slow})
			PushEvent({sort=GameplayEvents.Shake, xVal = {4,500,4.0,2.0}, yVal = {4,500,4.0,2.0}})

		end
	end
end

function ArcSolo:unCollideWith( object, collision )

end

function ArcSolo:flush()

end
function ArcSolo:activateA( )
	self.enabled = true
	self.anim:load("on",true)
	end

function ArcSolo:disableA( )
	self.enabled = false
	self.anim:load("off",true)
	end
function ArcSolo:update(seconds)
	if self.isTouched then
		self.timer=self.timer+seconds
	end
	self.anim:update(seconds)
	if(self.timer>=TimerArcSolo) then
		self.isTouched=false
		PushEvent({sort=GameplayEvents.Fail})
	end
end

function ArcSolo:draw(x,y)
	love.graphics.setColor(255,255,255,255)

	if( self.arcSoloType==ArcSoloType.MillieuH or self.arcSoloType==ArcSoloType.DebutH) then
		love.graphics.draw(self.anim:getSprite(),self.diffuse, self.position.x-x, self.position.y+y)
	elseif (  self.arcSoloType==ArcSoloType.MillieuV or self.arcSoloType==ArcSoloType.DebutV) then
		love.graphics.draw(self.anim:getSprite(),self.diffuse, self.position.x-x +unitWorldSize, self.position.y+y,math.pi/2)
	elseif (  self.arcSoloType==ArcSoloType.FinV) then
		love.graphics.draw(self.anim:getSprite(), self.diffuse,self.position.x-x , self.position.y+y+unitWorldSize,-math.pi/2)
	elseif (  self.arcSoloType==ArcSoloType.FinH) then
		love.graphics.draw(self.anim:getSprite(), self.diffuse,self.position.x-x+unitWorldSize , self.position.y+y,0,-1,1)
	end
end

function ArcSolo:send(x,y)
		return ("@arc".."#"..self.netid.."#"..self.arcType.."#"..self.anim:getImgInfo()[1].."#"..self.anim:getImgInfo()[2].."#"..math.floor(self.position.x-x).."#"..math.floor(self.position.y+y))
end


require("game.solo.animacidsolo")
require("game.solo.animsplashsolo")


AcidSolo = {}
AcidSolo.__index = AcidSolo
AcidSolo.Types ={hg='hg',hm='hm',hd='hd',mg='mg',mm='mm',md='md',bg='bg',bm='bm',bd='bd'}


TimerAcidSolo =1


function AcidSolo.new(pos,w,h,type,netid)
	local self = {}
	setmetatable(self, AcidSolo)

	self.netid=netid
	self.position={x=pos.x,y=pos.y}
	if type==AcidSolo.Types.hg  or type==AcidSolo.Types.hm or type==AcidSolo.Types.hd then
		self.dec=20
		self.splash=AnimSplashSolo.new('splash')
	else
		self.dec=0
	end
	self.w=w
	self.h=h-self.dec
	local decalage={self.w/2,self.h/2}
	self.pc = Physics.newZone(self.position.x,self.position.y+self.dec,self.w,self.h,decalage)
	self.pc.fixture:setUserData(self)
	self.type='AcidSolo'
	self.acidSoloType=type
	self.anim = AnimAcidSolo.new('acid/'..type)
	self:loadAnimation("normal",true)
	self.isTouched=false
	self.timer=0
	self.splashpos={x=0,y=0}	
	return self
end


function AcidSolo:loadAnimation(anim, force)
	self.anim:load(anim, force)
end


function AcidSolo:getPosition()
	return self.position
end


function AcidSolo:preSolve(b,coll)
end



function AcidSolo:collideWith( object, collision )
	if object.type=='MetalManSolo' or object.type =='TheMagnetSolo' then
		self.isTouched=true
		if self.acidSoloType==AcidSolo.Types.hg  or self.acidSoloType==AcidSolo.Types.hm or self.acidSoloType==AcidSolo.Types.hd then
			self.splash:load("kill",true)
			pos=object:getPosition()
			self.splashpos={x=pos.x,y=pos.y}
		end
		object:die("acid")
	end
end

function AcidSolo:unCollideWith( object, collision )

end

function AcidSolo:update(seconds)
	if self.isTouched then
		self.timer=self.timer+seconds
	end

	if self.acidSoloType==AcidSolo.Types.hg  or self.acidSoloType==AcidSolo.Types.hm or self.acidSoloType==AcidSolo.Types.hd then
		self.splash:update(seconds)
	end
	self.anim:update(seconds)
	x,y =self.pc.body:getPosition()
	self.position.x=x
	self.position.y=y-self.dec
	if(self.timer>=TimerAcidSolo) then
		self.isTouched=false
		gameStateManager:failed()
	end	
end

function AcidSolo:draw(x,y)
	love.graphics.setColor(255,255,255,255)
	if self.acidSoloType==AcidSolo.Types.hg  or self.acidSoloType==AcidSolo.Types.hm or self.acidSoloType==AcidSolo.Types.hd then
		love.graphics.draw(self.splash:getSprite(), self.splashpos.x-x-32, self.splashpos.y+y-64+self.dec)
	end
	love.graphics.draw(self.anim:getSprite(), self.position.x-x, self.position.y+y)

end
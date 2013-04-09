require("game.animacid")
require("game.animsplash")


Acid = {}
Acid.__index = Acid
Acid.Types ={hg='hg',hm='hm',hd='hd',mg='mg',mm='mm',md='md',bg='bg',bm='bm',bd='bd'}

function Acid.new(pos,type,anim,id)
	local self = {}
	setmetatable(self, Acid)
	self.position={x=pos.x,y=pos.y}

	if type==Acid.Types.hg  or type==Acid.Types.hm or type==Acid.Types.hd then
		self.dec=20
		self.splash=AnimSplash.new('splash')		
	else
		self.dec=0
	end
	self.type='Acid'
	self.acidType=type
	self.anim = AnimAcid.new('acid/'..type)
	self.anim:syncronize(anim,id)
	self.splashpos={x=0,y=0}	
	return self
end


function Acid:loadAnimation(anim, force)
	self.anim:load(anim, force)
end


function Acid:getPosition()
	return self.position
end

function Acid:syncronize(pos,anim,id)
	self.position.x=pos.x
	self.position.y=pos.y
	self.drawed=true
	if (self.anim.currentAnim.name~=anim) then
		self.anim:syncronize(anim,id)
	end
end

function Acid:syncronizeSplash(pos,anim,id,pos2,anim2,id2)
	self.position.x=pos.x
	self.position.y=pos.y
	self.drawed=true
	if (self.anim.currentAnim.name~=anim) then
		self.anim:syncronize(anim,id)
	end

	self.splashpos.x=pos2.x
	self.splashpos.y=pos2.y
	if (self.splash.currentAnim.name~=anim2) then
		self.splash:syncronize(anim2,id2)
	end	
end

function Acid:update(seconds)
	self.anim:update(seconds)
	if self.acidType==Acid.Types.hg  or self.acidType==Acid.Types.hm or self.acidType==Acid.Types.hd then
		self.splash:update(seconds)
	end
end

function Acid:draw(x,y)
	if self.acidType==Acid.Types.hg  or self.acidType==Acid.Types.hm or self.acidType==Acid.Types.hd then
		love.graphics.draw(self.splash:getSprite(), self.splashpos.x, self.splashpos.y)
	end	
	love.graphics.draw(self.anim:getSprite(), self.position.x, self.position.y)
end


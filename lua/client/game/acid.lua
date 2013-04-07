require("game.animacid")


Acid = {}
Acid.__index = Acid
Acid.Types ={hg='hg',hm='hm',hd='hd',mg='mg',mm='mm',md='md',bg='bg',bm='bm',bd='bd'}

function Acid.new(pos,type,anim,id)
	local self = {}
	setmetatable(self, Acid)
	self.position={x=pos.x,y=pos.y}

	if type==Acid.Types.hg  or type==Acid.Types.hm or type==Acid.Types.hd then
		self.dec=20
	else
		self.dec=0
	end
	self.type='Acid'
	self.acidType=type
	self.anim = AnimAcid.new('acid/'..type)
	print(anim)
	self.anim:syncronize(anim,id)
	print(anim)
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


function Acid:update(seconds)
	self.anim:update(seconds)
end

function Acid:draw(x,y)
	love.graphics.draw(self.anim:getSprite(), self.position.x, self.position.y)
end


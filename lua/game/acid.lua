
require("game.animacid")


Acid = {}
Acid.__index = Acid
Acid.Types ={hg='hg',hm='hm',hd='hd',mg='mg',mm='mm',md='md',bg='bg',bm='bm',bd='bd'}

function Acid.new(pos,w,h,type)
	local self = {}
	setmetatable(self, Acid)
	self.position={x=pos.x,y=pos.y}
	self.w=w
	self.h=h
	local decalage={w/2,h/2}
	self.pc = Physics.newZone(self.position.x,self.position.y,w,h,decalage)
	self.pc.fixture:setUserData(self)
	self.type='Acid'
	self.acidType=type
	self.anim = AnimAcid.new('acid/'..type)
	self:loadAnimation("normal",true)
	return self
end


function Acid:loadAnimation(anim, force)
	self.anim:load(anim, force)
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
	self.anim:update(seconds)
	x,y =self.pc.body:getPosition()
	self.position.x=x
	self.position.y=y
end

function Acid:draw(x,y)
	love.graphics.setColor(255,255,255,255)
	love.graphics.draw(self.anim:getSprite(), self.position.x-x, self.position.y+y)
end
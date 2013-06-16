

require("game.animinter")


ArcInterruptor = {}
ArcInterruptor.__index = ArcInterruptor


function ArcInterruptor.new(pos,anim,id)
	local self = {}
	setmetatable(self, ArcInterruptor)
	self.position={x=pos.x,y=pos.y}
	self.drawed=true	
	self.type='ArcInterruptor'
	self.anim = AnimInter.new('switch/arc')
	self.anim:syncronize(anim,id)
	self.diffuse  = love.graphics.newQuad(0, 0, 64, 64, 128, 64)

	return self
end


function ArcInterruptor:getPosition()
	return self.position
end

function ArcInterruptor:syncronize(pos,anim,id)
	if (self.anim.currentAnim.name~=anim) then
		self.anim:syncronize(anim,id)   
	end
	self.position.x=pos.x
	self.position.y=pos.y
	self.drawed=true
end

function ArcInterruptor:loadAnimation(anim, force)
		self.anim:load(anim, force)
end

function ArcInterruptor:update(seconds)
	self.anim:update(seconds)

end

function ArcInterruptor:draw()
    	love.graphics.drawq(self.anim:getSprite(), self.diffuse,self.position.x, self.position.y)
end
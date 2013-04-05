

require("game.animinter")


Interruptor = {}
Interruptor.__index = Interruptor


function Interruptor.new(pos,anim,id)
	local self = {}
	setmetatable(self, Interruptor)
	self.position={x=pos.x,y=pos.y}
	
	self.type='Interruptor'
	self.anim = AnimInter.new('inter')
	self.anim:syncronize(anim,id)
	return self
end


function Interruptor:getPosition()
	return self.position
end


function Interruptor:loadAnimation(anim, force)
		self.anim:load(anim, force)
end

function Interruptor:update(seconds)
	self.anim:update(seconds)

end

function Interruptor:draw()
    	love.graphics.draw(self.anim:getSprite(), self.position.x, self.position.y)
end
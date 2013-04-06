

require("game.animinter")


GateInterruptor = {}
GateInterruptor.__index = GateInterruptor


function GateInterruptor.new(pos,anim,id)
	local self = {}
	setmetatable(self, GateInterruptor)
	self.position={x=pos.x,y=pos.y}
	self.drawed=true
	
	self.type='GateInterruptor'
	self.anim = AnimInter.new('inter')
	self.anim:syncronize(anim,id)
	return self
end


function GateInterruptor:getPosition()
	return self.position
end
    function GateInterruptor:syncronize(pos,anim,id)
        self.anim:syncronize(anim,id)   
        self.position.x=pos.x
        self.position.y=pos.y
    end

function GateInterruptor:loadAnimation(anim, force)
		self.anim:load(anim, force)
end

function GateInterruptor:update(seconds)
	self.anim:update(seconds)

end

function GateInterruptor:draw()
    	love.graphics.draw(self.anim:getSprite(), self.position.x, self.position.y)
end
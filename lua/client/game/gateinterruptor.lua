

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
	self.diffuse  = love.graphics.newQuad(0, 0, 64, 64, 128, 64)
	return self
end


function GateInterruptor:getPosition()
	return self.position
end
    function GateInterruptor:syncronize(pos,anim,id)
		if (self.anim.currentAnim.name~=anim) then
			self.anim:syncronize(anim,id)
		end        
        self.position.x=pos.x
        self.position.y=pos.y
        self.drawed=true
    end

function GateInterruptor:loadAnimation(anim, force)
		self.anim:load(anim, force)
end

function GateInterruptor:update(seconds)
	self.anim:update(seconds)

end

function GateInterruptor:draw()
    	love.graphics.drawq(self.anim:getSprite(), self.diffuse,self.position.x, self.position.y)
end
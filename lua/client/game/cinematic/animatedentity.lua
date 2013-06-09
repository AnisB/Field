--[[ 
This file is part of the Field project
]]


AnimatedEntity = {}
AnimatedEntity.__index =  AnimatedEntity

function AnimatedEntity:new(id, position, isVisible, sprite, delay, loop, nbFrames, velocity)
    local self = {}
    setmetatable(self, AnimatedEntity)

    self.id = id
    self.visible = isVisible
    self.position = {x = position.x, y = position.y}
    if velocity ~= nil then
    	self.velocity = {x = velocity.x, y = velocity.y}
    else
    	self.velocity = {x = 0, y = 0}
    end
    self.animation = BasicAnim.new(sprite, loop, delay, nbFrames)
    return self
end

function AnimatedEntity:update(dt)
	self.animation:update(dt)
	self.position.x = self.position.x + self.velocity.x*dt
	self.position.y = self.position.y + self.velocity.y*dt
end


function AnimatedEntity:setPosition(x,y)
	self.position.x = x
	self.position.y = y
end

function AnimatedEntity:setVelocity(x,y)
	self.velocity.x = x
	self.velocity.y = y
end

function AnimatedEntity:setVisibility(val)
	self.visible = val
end

function AnimatedEntity:changeAnim(sprite, loop, delay, nbFrames)
    self.animation = BasicAnim.new(sprite, loop, delay, nbFrames)
end

function AnimatedEntity:draw()
	if self.visible then
		love.graphics.draw(self.animation, self.position.x, self.position.y)
	end
end
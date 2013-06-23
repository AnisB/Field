--[[ 
This file is part of the Field project
]]


AnimatedEntity = {}
AnimatedEntity.__index =  AnimatedEntity

function AnimatedEntity.new(id, position, isVisible, sprite, delay, loop, nbFrames, velocity, normalMapped)
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
    print("NBFRAMES", nbFrames)
    print("LOOP", loop)
    self.animation = BasicAnim.new(sprite, loop, delay, nbFrames)
    self.normalMapped= normalMapped

    if self.normalMapped then
        self.quad = love.graphics.newQuad(0, 0, self.animation:getSprite():getWidth( )/2, self.animation:getSprite():getHeight( ), self.animation:getSprite():getWidth( ), self.animation:getSprite():getHeight( ))
    end
    return self
end

function AnimatedEntity:update(dt)
	self.animation:update(dt)
	self.position.x = self.position.x + self.velocity.x*dt
	self.position.y = self.position.y + self.velocity.y*dt
end


function AnimatedEntity:setPosition(pos)
	self.position.x = pos.x
	self.position.y = pos.y
end

function AnimatedEntity:setVelocity(vel)
	self.velocity.x = vel.x
	self.velocity.y = vel.y
end

function AnimatedEntity:setVisibility(val)
	self.visible = val
end

function AnimatedEntity:setAnimation(animInfo)
    self.animation = BasicAnim.new(animInfo.sprite, animInfo.loop, animInfo.delay, animInfo.nbFrames)

    if self.normalMapped then
        self.quad = love.graphics.newQuad(0, 0, self.animation:getSprite():getWidth( )/2, self.animation:getSprite():getHeight( ), self.animation:getSprite():getWidth( ), self.animation:getSprite():getHeight( ))
    end
end

function AnimatedEntity:draw()
	if self.visible then
        if self.normalMapped then
          love.graphics.drawq(self.animation:getSprite(), self.quad , self.position.x, self.position.y)
        else
          love.graphics.draw(self.animation:getSprite(), self.position.x, self.position.y)
      end
	end
end
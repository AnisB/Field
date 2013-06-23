--[[ 
This file is part of the Field project
]]


MobileSprite = {}
MobileSprite.__index =  MobileSprite

function MobileSprite.new(id, position, isVisible, sprite, velocity, normalMapped)
    local self = {}
    setmetatable(self, MobileSprite)

    self.id = id
    self.visible = isVisible
    self.position = {x = position.x, y = position.y}
    if velocity ~= nil then
    	self.velocity = {x = velocity.x, y = velocity.y}
    else
    	self.velocity = {x = 0, y = 0}
    end
    self.sprite = love.graphics.newImage(sprite)
    self.normalMapped= normalMapped

    if self.normalMapped then
        self.quad = love.graphics.newQuad(0, 0, self.sprite:getWidth( )/2, self.sprite:getHeight( ), self.sprite:getWidth( ), self.sprite:getHeight( ))
    end
    return self
end

function MobileSprite:update(dt)
	self.position.x = self.position.x + self.velocity.x*dt
	self.position.y = self.position.y + self.velocity.y*dt
end


function MobileSprite:setPosition(pos)
	self.position.x = pos.x
	self.position.y = pos.y
end

function MobileSprite:setVelocity(vel)
	self.velocity.x = vel.x
	self.velocity.y = vel.y
end

function MobileSprite:setVisibility(val)
	self.visible = val
end


function MobileSprite:draw()
	if self.visible then
        if self.normalMapped then
          love.graphics.drawq(self.sprite,self.quad , self.position.x, self.position.y)
        else
          love.graphics.draw(self.sprite, self.position.x, self.position.y)
      end
	end
end
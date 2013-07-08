AnimDestroyable = {}
AnimDestroyable.__index = AnimDestroyable

AnimDestroyable.ANIMS = {  -- set of animations available :
	normal = {},
	breaking = {},
	destroyed = {}
}


-- name
AnimDestroyable.ANIMS.normal.name = "normal"
AnimDestroyable.ANIMS.breaking.name = "breaking"
AnimDestroyable.ANIMS.destroyed.name = "destroyed"


-- number of sprites :
AnimDestroyable.ANIMS.normal.number = 1
AnimDestroyable.ANIMS.breaking.number = 3
AnimDestroyable.ANIMS.destroyed.number = 1


AnimDestroyable.ANIMS.normal.DELAY= 0.2
AnimDestroyable.ANIMS.breaking.DELAY= 0.075
AnimDestroyable.ANIMS.destroyed.DELAY= 0.2
-- priority 
AnimDestroyable.ANIMS.normal.priority = 10
AnimDestroyable.ANIMS.breaking.priority = 20
AnimDestroyable.ANIMS.destroyed.priority = 10


-- automatic loopings or automatic switch :
AnimDestroyable.ANIMS.normal.loop = true
AnimDestroyable.ANIMS.breaking.switch = AnimDestroyable.ANIMS.destroyed
AnimDestroyable.ANIMS.destroyed.loop = true



-- PUBLIC : constructor
function AnimDestroyable.new(folder)
	local self = {}
	setmetatable(self, AnimDestroyable)
	self.time = 0.0
	self.sprites = {}
	for key,val in pairs(AnimDestroyable.ANIMS) do
		self.sprites[key] = {}
		for i=1, val.number do
			local path = 'game/anim/'..folder..'/'..key..'/'..i..'.png'
			-- print("loading image =>", path)
			-- self.sprites[key][i] = love.graphics.newImage(path)
		end
	end
	self.currentAnim = AnimDestroyable.ANIMS.normal
	self.currentPos = 1
	-- begin of an animation
	if self.currentAnim.beginCallback then
		self.currentAnim.beginCallback()
	end
	self:updateImg()
	return self
end

-- PUBLIC : getter for the sprite
function AnimDestroyable:getSprite()
	return self.currentImg
end

-- PUBLIC : change animation (you can force it)
function AnimDestroyable:load(anim, force)
	local newAnim = AnimDestroyable.ANIMS[anim]
	if force or newAnimDestroyable.priority > self.currentAnim.priority then
		self.currentAnim = newAnim
		self.currentPos = 1
		-- begin of an animation
		if self.currentAnim.beginCallback then
			self.currentAnim.beginCallback()
		end
		self:updateImg()
	else
		self.currentAnim.after = newAnim
	end
end

-- PUBLIC : update l'anim
function AnimDestroyable:update(seconds)
	self.time = self.time + seconds
	if self.time > self.currentAnim.DELAY then
		self:next()
		self.time = self.time - self.currentAnim.DELAY
	end
end

-- PRIVATE : go to next sprite
function AnimDestroyable:next()
	self.currentPos = self.currentPos + 1
	if self.currentPos > self.currentAnim.number then
		-- end of an animation
		if self.currentAnim.endCallback then
			self.currentAnim.endCallback()
		end
		if self.currentAnim.after ~= nil then
			self.currentAnim = self.currentAnim.after
		elseif self.currentAnim.switch ~= nil then
			self.currentAnim = self.currentAnim.switch
		elseif self.currentAnim.loop then
			-- I don't switch
		else
			print("FUCKING ANIM SWITCHING ERROR")
		end
		self.currentPos = 1
		-- begin of an animation
		if self.currentAnim.beginCallback then
			self.currentAnim.beginCallback()
		end
	end
	self:updateImg()
end

-- PRIVATE
function AnimDestroyable:updateImg()
	self.currentImg = self.sprites[self.currentAnim.name][self.currentPos]
end

-- NETWORK
function AnimDestroyable:getImgInfo()
	return {self.currentAnim.name,self.currentPos}
end
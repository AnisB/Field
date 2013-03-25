AnimArc = {}
AnimArc.__index = AnimArc

AnimArc.ANIMS = {  -- set of animations available :
	off = {},
	on = {}
}


-- name
AnimArc.ANIMS.off.name = "off"
AnimArc.ANIMS.on.name = "on"


-- delays
AnimArc.ANIMS.off.DELAY = 0.075
AnimArc.ANIMS.on.DELAY = 0.075



-- number of sprites :
AnimArc.ANIMS.off.number = 1
AnimArc.ANIMS.on.number = 3




-- priority :
AnimArc.ANIMS.off.priority = 10
AnimArc.ANIMS.on.priority = 20



-- automatic loopings or automatic switch :
AnimArc.ANIMS.off.loop = true
AnimArc.ANIMS.on.loop = true



-- PUBLIC : constructor
function AnimArc.new(folder)
	local self = {}
	setmetatable(self, AnimArc)
	self.time = 0.0
	self.sprites = {}
	for key,val in pairs(AnimArc.ANIMS) do
		self.sprites[key] = {}
		for i=1, val.number do
			local path = 'game/anim/'..folder..'/'..key..'/'..i..'.png'
			-- print("loading image =>", path)
			self.sprites[key][i] = love.graphics.newImage(path)
		end
	end
	self.currentAnim = AnimArc.ANIMS.off
	self.currentPos = 1
	-- begin of an animation
	if self.currentAnim.beginCallback then
		self.currentAnim.beginCallback()
	end
	self:updateImg()
	return self
end

-- PUBLIC : getter for the sprite
function AnimArc:getSprite()
	return self.currentImg
end

-- PUBLIC : change animation (you can force it)
function AnimArc:load(anim, force)
	local newAnim = AnimArc.ANIMS[anim]
	if force or newAnimArc.priority > self.currentAnim.priority then
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
function AnimArc:update(seconds)
	self.time = self.time + seconds
	if self.time > self.currentAnim.DELAY then
		self:next()
		self.time = self.time - self.currentAnim.DELAY
	end
end

-- PRIVATE : go to next sprite
function AnimArc:next()
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
function AnimArc:updateImg()
	self.currentImg = self.sprites[self.currentAnim.name][self.currentPos]
end
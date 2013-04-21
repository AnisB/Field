AnimArcSolo = {}
AnimArcSolo.__index = AnimArcSolo

AnimArcSolo.ANIMS = {  -- set of animations available :
	off = {},
	on = {}
}


-- name
AnimArcSolo.ANIMS.off.name = "off"
AnimArcSolo.ANIMS.on.name = "on"


-- delays
AnimArcSolo.ANIMS.off.DELAY = 0.075
AnimArcSolo.ANIMS.on.DELAY = 0.075



-- number of sprites :
AnimArcSolo.ANIMS.off.number = 1
AnimArcSolo.ANIMS.on.number = 3




-- priority :
AnimArcSolo.ANIMS.off.priority = 10
AnimArcSolo.ANIMS.on.priority = 20



-- automatic loopings or automatic switch :
AnimArcSolo.ANIMS.off.loop = true
AnimArcSolo.ANIMS.on.loop = true



-- PUBLIC : constructor
function AnimArcSolo.new(folder)
	local self = {}
	setmetatable(self, AnimArcSolo)
	self.time = 0.0
	self.sprites = {}
	for key,val in pairs(AnimArcSolo.ANIMS) do
		self.sprites[key] = {}
		for i=1, val.number do
			local path = 'game/anim/'..folder..'/'..key..'/'..i..'.png'
			-- print("loading image =>", path)
			self.sprites[key][i] = love.graphics.newImage(path)
		end
	end
	self.currentAnim = AnimArcSolo.ANIMS.off
	self.currentPos = 1
	-- begin of an animation
	if self.currentAnim.beginCallback then
		self.currentAnim.beginCallback()
	end
	self:updateImg()
	return self
end

-- PUBLIC : getter for the sprite
function AnimArcSolo:getSprite()
	return self.currentImg
end

-- PUBLIC : change animation (you can force it)
function AnimArcSolo:load(anim, force)
	local newAnim = AnimArcSolo.ANIMS[anim]
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
function AnimArcSolo:update(seconds)
	self.time = self.time + seconds
	if self.time > self.currentAnim.DELAY then
		self:next()
		self.time = self.time - self.currentAnim.DELAY
	end
end

-- PRIVATE : go to next sprite
function AnimArcSolo:next()
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
function AnimArcSolo:updateImg()
	self.currentImg = self.sprites[self.currentAnim.name][self.currentPos]
end

-- NETWORK
function AnimArcSolo:getImgInfo()
	return {self.currentAnim.name,self.currentPos}
end
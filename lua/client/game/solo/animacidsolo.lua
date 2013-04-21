AnimAcidSolo = {}
AnimAcidSolo.__index = AnimAcidSolo

AnimAcidSolo.ANIMS = {  -- set of animations available :
	normal = {},
	kill = {}
}


-- name
AnimAcidSolo.ANIMS.normal.name = "normal"
AnimAcidSolo.ANIMS.kill.name = "kill"


-- delays
AnimAcidSolo.ANIMS.normal.DELAY = 0.2
AnimAcidSolo.ANIMS.kill.DELAY = 0.2



-- number of sprites :
AnimAcidSolo.ANIMS.normal.number = 3
AnimAcidSolo.ANIMS.kill.number = 3




-- priority :
AnimAcidSolo.ANIMS.normal.priority = 10
AnimAcidSolo.ANIMS.kill.priority = 20



-- automatic loopings or automatic switch :
AnimAcidSolo.ANIMS.normal.loop = true
AnimAcidSolo.ANIMS.kill.loop = true



-- PUBLIC : constructor
function AnimAcidSolo.new(folder)
	local self = {}
	setmetatable(self, AnimAcidSolo)
	self.time = 0.0
	self.sprites = {}
	for key,val in pairs(AnimAcidSolo.ANIMS) do
		self.sprites[key] = {}
		for i=1, val.number do
			local path = 'game/anim/'..folder..'/'..key..'/'..i..'.png'
			-- print("loading image =>", path)
			self.sprites[key][i] = love.graphics.newImage(path)
		end
	end
	self.currentAnim = AnimAcidSolo.ANIMS.normal
	self.currentPos = 1
	-- begin of an animation
	if self.currentAnim.beginCallback then
		self.currentAnim.beginCallback()
	end
	self:updateImg()
	return self
end

-- PUBLIC : getter for the sprite
function AnimAcidSolo:getSprite()
	return self.currentImg
end

-- PUBLIC : change animation (you can force it)
function AnimAcidSolo:load(anim, force)
	local newAnim = AnimAcidSolo.ANIMS[anim]
	if force or newAnimAcidSolo.priority > self.currentAnim.priority then
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
function AnimAcidSolo:update(seconds)
	self.time = self.time + seconds
	if self.time > self.currentAnim.DELAY then
		self:next()
		self.time = self.time - self.currentAnim.DELAY
	end
end

-- PRIVATE : go to next sprite
function AnimAcidSolo:next()
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
function AnimAcidSolo:updateImg()
	self.currentImg = self.sprites[self.currentAnim.name][self.currentPos]
end

-- NETWORK
function AnimAcidSolo:getImgInfo()
	return {self.currentAnim.name,self.currentPos}
end
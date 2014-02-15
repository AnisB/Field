AnimAcidSolo = {}
AnimAcidSolo.__index = AnimAcidSolo


AnimAcidSolo.ANIMS = {  -- set of animations available :
	normal = {}
}

-- name
AnimAcidSolo.ANIMS.normal.name = "normal"

-- delays
AnimAcidSolo.ANIMS.normal.DELAY = 0.2

-- number of sprites :
AnimAcidSolo.ANIMS.normal.number = 3


-- automatic loopings or automatic switch :
AnimAcidSolo.ANIMS.normal.loop = true

AnimAcidSolo.sprites={}


-- PUBLIC : constructor
function AnimAcidSolo.new(folder)
	local self = {}
	setmetatable(self, AnimAcidSolo)
	self.time = 0.0

	if AnimAcidSolo.sprites[folder]==nil then
		AnimAcidSolo.sprites[folder]={}
		for key,val in pairs(AnimAcidSolo.ANIMS) do
			AnimAcidSolo.sprites[folder][key] = {}
			for i=1, val.number do
				local path = 'anim/'..folder..'/'..key..'/'..i..'.png'
			    -- s_gameStateManager.loader.newImage(AnimAcidSolo.sprites[folder][key],i, path)
			    AnimAcidSolo.sprites[folder][key][i] = s_resourceManager:LoadImage(path)
			end
		end
	end
	self.folder=folder
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
	self.currentImg = AnimAcidSolo.sprites[self.folder][self.currentAnim.name][self.currentPos]
end

-- NETWORK
function AnimAcidSolo:getImgInfo()
	return {self.currentAnim.name,self.currentPos}
end
AnimGeneSolo = {}
AnimGeneSolo.__index = AnimGeneSolo

AnimGeneSolo.ANIMS = {  -- set of animations available :
	off = {},
	on = {},
	launching = {},
	shutdown ={}
}


-- name
AnimGeneSolo.ANIMS.off.name = "off"
AnimGeneSolo.ANIMS.on.name = "on"
AnimGeneSolo.ANIMS.launching.name = "launching"
AnimGeneSolo.ANIMS.shutdown.name = "shutdown"


-- delays
AnimGeneSolo.ANIMS.off.DELAY = 0.075
AnimGeneSolo.ANIMS.on.DELAY = 0.075
AnimGeneSolo.ANIMS.launching.DELAY = 0.075
AnimGeneSolo.ANIMS.shutdown.DELAY = 0.075



-- number of sprites :
AnimGeneSolo.ANIMS.off.number = 1
AnimGeneSolo.ANIMS.on.number = 8
AnimGeneSolo.ANIMS.launching.number = 8
AnimGeneSolo.ANIMS.shutdown.number = 2




-- priority :
AnimGeneSolo.ANIMS.off.priority = 10
AnimGeneSolo.ANIMS.on.priority = 20
AnimGeneSolo.ANIMS.launching.priority = 20
AnimGeneSolo.ANIMS.shutdown.priority = 20



-- automatic loopings or automatic switch :
AnimGeneSolo.ANIMS.off.loop = true
AnimGeneSolo.ANIMS.on.loop = true
AnimGeneSolo.ANIMS.launching.switch = AnimGeneSolo.ANIMS.on
AnimGeneSolo.ANIMS.shutdown.switch = AnimGeneSolo.ANIMS.off



-- PUBLIC : constructor
function AnimGeneSolo.new(folder)
	local self = {}
	setmetatable(self, AnimGeneSolo)
	self.time = 0.0
	self.sprites = {}
	for key,val in pairs(AnimGeneSolo.ANIMS) do
		self.sprites[key] = {}
		for i=1, val.number do
			local path = 'game/anim/'..folder..'/'..key..'/'..i..'.png'
			-- print("loading image =>", path)
			gameStateManager.loader.newImage(self.sprites[key],i, path)
		end
	end
	self.currentAnim = AnimGeneSolo.ANIMS.off
	self.currentPos = 1
	-- begin of an animation
	if self.currentAnim.beginCallback then
		self.currentAnim.beginCallback()
	end
	self:updateImg()
	return self
end

-- PUBLIC : getter for the sprite
function AnimGeneSolo:getSprite()
	return self.currentImg
end

-- PUBLIC : change animation (you can force it)
function AnimGeneSolo:load(anim, force)
	local newAnim = AnimGeneSolo.ANIMS[anim]
	if force or newAnimGeneSolo.priority > self.currentAnim.priority then
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
function AnimGeneSolo:update(seconds)
	self.time = self.time + seconds
	if self.time > self.currentAnim.DELAY then
		self:next()
		self.time = self.time - self.currentAnim.DELAY
	end
end

-- PRIVATE : go to next sprite
function AnimGeneSolo:next()
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
function AnimGeneSolo:updateImg()
	self.currentImg = self.sprites[self.currentAnim.name][self.currentPos]
end

-- NETWORK
function AnimGeneSolo:getImgInfo()
	return {self.currentAnim.name,self.currentPos}
end
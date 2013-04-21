AnimSplashSolo = {}
AnimSplashSolo.__index = AnimSplashSolo

AnimSplashSolo.ANIMS = {  -- set of animations available :
	normal = {},
	kill = {}
}


-- name
AnimSplashSolo.ANIMS.normal.name = "normal"
AnimSplashSolo.ANIMS.kill.name = "kill"


-- delays
AnimSplashSolo.ANIMS.normal.DELAY = 0.1
AnimSplashSolo.ANIMS.kill.DELAY = 0.120



-- number of sprites :
AnimSplashSolo.ANIMS.normal.number = 1
AnimSplashSolo.ANIMS.kill.number = 6




-- priority :
AnimSplashSolo.ANIMS.normal.priority = 10
AnimSplashSolo.ANIMS.kill.priority = 20



-- automatic loopings or automatic switch :
AnimSplashSolo.ANIMS.normal.loop = true
AnimSplashSolo.ANIMS.kill.switch = AnimSplashSolo.ANIMS.normal



-- PUBLIC : constructor
function AnimSplashSolo.new(folder)
	local self = {}
	setmetatable(self, AnimSplashSolo)
	self.time = 0.0
	self.sprites = {}
	for key,val in pairs(AnimSplashSolo.ANIMS) do
		self.sprites[key] = {}
		for i=1, val.number do
			local path = 'game/anim/'..folder..'/'..key..'/'..i..'.png'
			-- print("loading image =>", path)
			self.sprites[key][i] = love.graphics.newImage(path)
		end
	end
	self.currentAnim = AnimSplashSolo.ANIMS.normal
	self.currentPos = 1
	-- begin of an animation
	if self.currentAnim.beginCallback then
		self.currentAnim.beginCallback()
	end
	self:updateImg()
	return self
end

-- PUBLIC : getter for the sprite
function AnimSplashSolo:getSprite()
	return self.currentImg
end

-- PUBLIC : change animation (you can force it)
function AnimSplashSolo:load(anim, force)
	local newAnim = AnimSplashSolo.ANIMS[anim]
	if force or newAnimSplashSolo.priority > self.currentAnim.priority then
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
function AnimSplashSolo:update(seconds)
	self.time = self.time + seconds
	if self.time > self.currentAnim.DELAY then
		self:next()
		self.time = self.time - self.currentAnim.DELAY
	end
end

-- PRIVATE : go to next sprite
function AnimSplashSolo:next()
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
function AnimSplashSolo:updateImg()
	self.currentImg = self.sprites[self.currentAnim.name][self.currentPos]
end

-- NETWORK
function AnimSplashSolo:getImgInfo()
	return {self.currentAnim.name,self.currentPos}
end
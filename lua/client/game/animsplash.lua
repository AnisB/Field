AnimSplash = {}
AnimSplash.__index = AnimSplash

AnimSplash.ANIMS = {  -- set of animations available :
	normal = {},
	kill = {}
}


-- name
AnimSplash.ANIMS.normal.name = "normal"
AnimSplash.ANIMS.kill.name = "kill"


-- delays
AnimSplash.ANIMS.normal.DELAY = 0.1
AnimSplash.ANIMS.kill.DELAY = 0.120



-- number of sprites :
AnimSplash.ANIMS.normal.number = 1
AnimSplash.ANIMS.kill.number = 6




-- priority :
AnimSplash.ANIMS.normal.priority = 10
AnimSplash.ANIMS.kill.priority = 20



-- automatic loopings or automatic switch :
AnimSplash.ANIMS.normal.loop = true
AnimSplash.ANIMS.kill.loop = false



-- PUBLIC : constructor
function AnimSplash.new(folder)
	local self = {}
	setmetatable(self, AnimSplash)
	self.time = 0.0
	self.sprites = {}
	for key,val in pairs(AnimSplash.ANIMS) do
		self.sprites[key] = {}
		for i=1, val.number do
			local path = 'game/anim/'..folder..'/'..key..'/'..i..'.png'
			-- print("loading image =>", path)
			self.sprites[key][i] = love.graphics.newImage(path)
		end
	end
	self.currentAnim = AnimSplash.ANIMS.normal
	self.currentPos = 1
	-- begin of an animation
	if self.currentAnim.beginCallback then
		self.currentAnim.beginCallback()
	end
	self:updateImg()
	return self
end

-- PUBLIC : getter for the sprite
function AnimSplash:getSprite()
	return self.currentImg
end

-- PUBLIC : change animation (you can force it)
function AnimSplash:load(anim, force)
	local newAnim = AnimSplash.ANIMS[anim]
	if force or newAnimSplash.priority > self.currentAnim.priority then
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

function AnimSplash:syncronize(anim, pos)
	local newAnim = AnimSplash.ANIMS[anim]
	self.currentAnim = newAnim
	self.currentPos = pos
	self:updateImg()
	self.currentAnim.after = newAnim		
end

-- PUBLIC : update l'anim
function AnimSplash:update(seconds)
	self.time = self.time + seconds
	if self.time > self.currentAnim.DELAY then
		self:next()
		self.time = self.time - self.currentAnim.DELAY
	end
end

-- PRIVATE : go to next sprite
function AnimSplash:next()
	self.currentPos = self.currentPos + 1
	if self.currentPos > self.currentAnim.number then

		if self.currentAnim.loop==false then
			self.currentPos=self.currentAnim.number
			return
		end
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
function AnimSplash:updateImg()
	self.currentImg = self.sprites[self.currentAnim.name][self.currentPos]
end

-- NETWORK
function AnimSplash:getImgInfo()
	return {self.currentAnim.name,self.currentPos}
end
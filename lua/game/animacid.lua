AnimAcid = {}
AnimAcid.__index = AnimAcid

AnimAcid.ANIMS = {  -- set of animations available :
	normal = {},
	kill = {}
}


-- name
AnimAcid.ANIMS.normal.name = "normal"
AnimAcid.ANIMS.kill.name = "kill"


-- delays
AnimAcid.ANIMS.normal.DELAY = 0.2
AnimAcid.ANIMS.kill.DELAY = 0.2



-- number of sprites :
AnimAcid.ANIMS.normal.number = 3
AnimAcid.ANIMS.kill.number = 3




-- priority :
AnimAcid.ANIMS.normal.priority = 10
AnimAcid.ANIMS.kill.priority = 20



-- automatic loopings or automatic switch :
AnimAcid.ANIMS.normal.loop = true
AnimAcid.ANIMS.kill.loop = true



-- PUBLIC : constructor
function AnimAcid.new(folder)
	local self = {}
	setmetatable(self, AnimAcid)
	self.time = 0.0
	self.sprites = {}
	for key,val in pairs(AnimAcid.ANIMS) do
		self.sprites[key] = {}
		for i=1, val.number do
			local path = 'game/anim/'..folder..'/'..key..'/'..i..'.png'
			-- print("loading image =>", path)
			self.sprites[key][i] = love.graphics.newImage(path)
		end
	end
	self.currentAnim = AnimAcid.ANIMS.normal
	self.currentPos = 1
	-- begin of an animation
	if self.currentAnim.beginCallback then
		self.currentAnim.beginCallback()
	end
	self:updateImg()
	return self
end

-- PUBLIC : getter for the sprite
function AnimAcid:getSprite()
	return self.currentImg
end

-- PUBLIC : change animation (you can force it)
function AnimAcid:load(anim, force)
	local newAnim = AnimAcid.ANIMS[anim]
	if force or newAnimAcid.priority > self.currentAnim.priority then
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
function AnimAcid:update(seconds)
	self.time = self.time + seconds
	if self.time > self.currentAnim.DELAY then
		self:next()
		self.time = self.time - self.currentAnim.DELAY
	end
end

-- PRIVATE : go to next sprite
function AnimAcid:next()
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
function AnimAcid:updateImg()
	self.currentImg = self.sprites[self.currentAnim.name][self.currentPos]
end
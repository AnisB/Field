AnimInter = {}
AnimInter.__index = AnimInter

AnimInter.ANIMS = {  -- set of animations available :
	off = {},
	on = {},
	launching = {},
	shutdown ={}
}


-- name
AnimInter.ANIMS.off.name = "off"
AnimInter.ANIMS.on.name = "on"
AnimInter.ANIMS.launching.name = "launching"
AnimInter.ANIMS.shutdown.name = "shutdown"


-- delays
AnimInter.ANIMS.off.DELAY = 0.075
AnimInter.ANIMS.on.DELAY = 0.075
AnimInter.ANIMS.launching.DELAY = 0.075
AnimInter.ANIMS.shutdown.DELAY = 0.075



-- number of sprites :
AnimInter.ANIMS.off.number = 1
AnimInter.ANIMS.on.number = 2
AnimInter.ANIMS.launching.number = 11
AnimInter.ANIMS.shutdown.number = 2




-- priority :
AnimInter.ANIMS.off.priority = 10
AnimInter.ANIMS.on.priority = 20
AnimInter.ANIMS.launching.priority = 20
AnimInter.ANIMS.shutdown.priority = 20



-- automatic loopings or automatic switch :
AnimInter.ANIMS.off.loop = true
AnimInter.ANIMS.on.loop = true
-- AnimInter.ANIMS.launching.switch = AnimInter.ANIMS.on
-- AnimInter.ANIMS.shutdown.switch = AnimInter.ANIMS.off



-- PUBLIC : constructor
function AnimInter.new(folder)
	local self = {}
	setmetatable(self, AnimInter)
	self.time = 0.0
	self.sprites = {}
	for key,val in pairs(AnimInter.ANIMS) do
		self.sprites[key] = {}
		for i=1, val.number do
			local path = 'game/anim/'..folder..'/'..key..'/'..i..'.png'
			-- print("loading image =>", path)
			self.sprites[key][i] = love.graphics.newImage(path)
		end
	end
	self.currentAnim = AnimInter.ANIMS.off
	self.currentPos = 1
	-- begin of an animation
	if self.currentAnim.beginCallback then
		self.currentAnim.beginCallback()
	end
	self:updateImg()
	return self
end

-- PUBLIC : getter for the sprite
function AnimInter:getSprite()
	return self.currentImg
end

-- PUBLIC : change animation (you can force it)
function AnimInter:load(anim, force)
	local newAnim = AnimInter.ANIMS[anim]
	if force or newAnimInter.priority > self.currentAnim.priority then
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
function AnimInter:update(seconds)
	self.time = self.time + seconds
	if self.time > self.currentAnim.DELAY then
		self:next()
		self.time = self.time - self.currentAnim.DELAY
	end
end

function AnimInter:syncronize(anim, pos)
	local newAnim = AnimInter.ANIMS[anim]
		self.currentAnim = newAnim
		self.currentPos = pos
		self:updateImg()
		self.currentAnim.after = newAnim		
end

-- PRIVATE : go to next sprite
function AnimInter:next()
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
			return
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
function AnimInter:updateImg()
	self.currentImg = self.sprites[self.currentAnim.name][self.currentPos]
end

-- NETWORK
function AnimInter:getImgInfo()
	return {self.currentAnim.name,self.currentPos}
end
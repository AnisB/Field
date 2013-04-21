AnimInterSolo = {}
AnimInterSolo.__index = AnimInterSolo

AnimInterSolo.ANIMS = {  -- set of animations available :
	off = {},
	on = {},
	launching = {},
	shutdown ={}
}


-- name
AnimInterSolo.ANIMS.off.name = "off"
AnimInterSolo.ANIMS.on.name = "on"
AnimInterSolo.ANIMS.launching.name = "launching"
AnimInterSolo.ANIMS.shutdown.name = "shutdown"


-- delays
AnimInterSolo.ANIMS.off.DELAY = 0.075
AnimInterSolo.ANIMS.on.DELAY = 0.075
AnimInterSolo.ANIMS.launching.DELAY = 0.075
AnimInterSolo.ANIMS.shutdown.DELAY = 0.075



-- number of sprites :
AnimInterSolo.ANIMS.off.number = 1
AnimInterSolo.ANIMS.on.number = 2
AnimInterSolo.ANIMS.launching.number = 11
AnimInterSolo.ANIMS.shutdown.number = 2




-- priority :
AnimInterSolo.ANIMS.off.priority = 10
AnimInterSolo.ANIMS.on.priority = 20
AnimInterSolo.ANIMS.launching.priority = 20
AnimInterSolo.ANIMS.shutdown.priority = 20



-- automatic loopings or automatic switch :
AnimInterSolo.ANIMS.off.loop = true
AnimInterSolo.ANIMS.on.loop = true
AnimInterSolo.ANIMS.launching.switch = AnimInterSolo.ANIMS.on
AnimInterSolo.ANIMS.shutdown.switch = AnimInterSolo.ANIMS.off



-- PUBLIC : constructor
function AnimInterSolo.new(folder)
	local self = {}
	setmetatable(self, AnimInterSolo)
	self.time = 0.0
	self.sprites = {}
	for key,val in pairs(AnimInterSolo.ANIMS) do
		self.sprites[key] = {}
		for i=1, val.number do
			local path = 'game/anim/'..folder..'/'..key..'/'..i..'.png'
			-- print("loading image =>", path)
			self.sprites[key][i] = love.graphics.newImage(path)
		end
	end
	self.currentAnim = AnimInterSolo.ANIMS.off
	self.currentPos = 1
	-- begin of an animation
	if self.currentAnim.beginCallback then
		self.currentAnim.beginCallback()
	end
	self:updateImg()
	return self
end

-- PUBLIC : getter for the sprite
function AnimInterSolo:getSprite()
	return self.currentImg
end

-- PUBLIC : change animation (you can force it)
function AnimInterSolo:load(anim, force)
	local newAnim = AnimInterSolo.ANIMS[anim]
	if force or newAnimInterSolo.priority > self.currentAnim.priority then
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
function AnimInterSolo:update(seconds)
	self.time = self.time + seconds
	if self.time > self.currentAnim.DELAY then
		self:next()
		self.time = self.time - self.currentAnim.DELAY
	end
end

-- PRIVATE : go to next sprite
function AnimInterSolo:next()
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
function AnimInterSolo:updateImg()
	self.currentImg = self.sprites[self.currentAnim.name][self.currentPos]
end

-- NETWORK
function AnimInterSolo:getImgInfo()
	return {self.currentAnim.name,self.currentPos}
end
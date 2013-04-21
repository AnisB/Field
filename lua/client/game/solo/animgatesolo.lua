AnimGateSolo = {}
AnimGateSolo.__index = AnimGateSolo

AnimGateSolo.ANIMS = {  -- set of animations available :
	close = {},
	open={},
	opening={},
	closing={}
}


-- name
AnimGateSolo.ANIMS.close.name = "close"
AnimGateSolo.ANIMS.open.name = "open"
AnimGateSolo.ANIMS.opening.name = "opening"
AnimGateSolo.ANIMS.closing.name = "closing"


-- delays
AnimGateSolo.ANIMS.close.DELAY = 0.075
AnimGateSolo.ANIMS.open.DELAY = 0.075
AnimGateSolo.ANIMS.closing.DELAY = 0.01
AnimGateSolo.ANIMS.opening.DELAY = 0.01



-- number of sprites :
AnimGateSolo.ANIMS.close.number = 1
AnimGateSolo.ANIMS.open.number = 1
AnimGateSolo.ANIMS.closing.number = 5
AnimGateSolo.ANIMS.opening.number = 5




-- priority :
AnimGateSolo.ANIMS.close.priority = 10
AnimGateSolo.ANIMS.open.priority = 10
AnimGateSolo.ANIMS.closing.priority = 10
AnimGateSolo.ANIMS.opening.priority = 10



-- automatic loopings or automatic switch :
AnimGateSolo.ANIMS.close.loop = 10
AnimGateSolo.ANIMS.open.loop = 10
AnimGateSolo.ANIMS.closing.switch = AnimGateSolo.ANIMS.close
AnimGateSolo.ANIMS.opening.switch = AnimGateSolo.ANIMS.open



-- PUBLIC : constructor
function AnimGateSolo.new(folder)
	local self = {}
	setmetatable(self, AnimGateSolo)
	self.time = 0.0
	self.sprites = {}
	for key,val in pairs(AnimGateSolo.ANIMS) do
		self.sprites[key] = {}
		for i=1, val.number do
			local path = 'game/anim/'..folder..'/'..key..'/'..i..'.png'
			-- print("loading image =>", path)
			self.sprites[key][i] = love.graphics.newImage(path)
		end
	end
	self.currentAnim = AnimGateSolo.ANIMS.close
	self.currentPos = 1
	-- begin of an animation
	if self.currentAnim.beginCallback then
		self.currentAnim.beginCallback()
	end
	self:updateImg()
	return self
end

-- PUBLIC : getter for the sprite
function AnimGateSolo:getSprite()
	return self.currentImg
end

-- PUBLIC : change animation (you can force it)
function AnimGateSolo:load(anim, force)
	local newAnim = AnimGateSolo.ANIMS[anim]
	if force or newAnimGate.priority > self.currentAnim.priority then
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
function AnimGateSolo:update(seconds)
	self.time = self.time + seconds
	if self.time > self.currentAnim.DELAY then
		self:next()
		self.time = self.time - self.currentAnim.DELAY
	end
end

-- PRIVATE : go to next sprite
function AnimGateSolo:next()
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
function AnimGateSolo:updateImg()
	self.currentImg = self.sprites[self.currentAnim.name][self.currentPos]
end

-- NETWORK
function AnimGateSolo:getImgInfo()
	return {self.currentAnim.name,self.currentPos}
end
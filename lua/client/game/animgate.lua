AnimGate = {}
AnimGate.__index = AnimGate

AnimGate.ANIMS = {  -- set of animations available :
	close = {},
	open={},
	opening={},
	closing={}
}


-- name
AnimGate.ANIMS.close.name = "close"
AnimGate.ANIMS.open.name = "open"
AnimGate.ANIMS.opening.name = "opening"
AnimGate.ANIMS.closing.name = "closing"


-- delays
AnimGate.ANIMS.close.DELAY = 0.075
AnimGate.ANIMS.open.DELAY = 0.075
AnimGate.ANIMS.closing.DELAY = 0.01
AnimGate.ANIMS.opening.DELAY = 0.01



-- number of sprites :
AnimGate.ANIMS.close.number = 1
AnimGate.ANIMS.open.number = 1
AnimGate.ANIMS.closing.number = 5
AnimGate.ANIMS.opening.number = 5




-- priority :
AnimGate.ANIMS.close.priority = 10
AnimGate.ANIMS.open.priority = 10
AnimGate.ANIMS.closing.priority = 10
AnimGate.ANIMS.opening.priority = 10



-- automatic loopings or automatic switch :
AnimGate.ANIMS.close.loop = 10
AnimGate.ANIMS.open.loop = 10
AnimGate.ANIMS.closing.loop=false
AnimGate.ANIMS.opening.loop=false

AnimGate.sprites={}


-- PUBLIC : constructor
function AnimGate.new(folder)
	local self = {}
	setmetatable(self, AnimGate)
	self.time = 0.0
	if AnimGate.sprites[folder]==nil then
		AnimGate.sprites[folder]={}
		for key,val in pairs(AnimGate.ANIMS) do
			AnimGate.sprites[folder][key] = {}
			for i=1, val.number do
				local path = 'game/anim/'..folder..'/'..key..'/'..i..'.png'
			    AnimGate.sprites[folder][key][i] = love.graphics.newImage(path)

			end
		end
	end
	self.folder=folder
	self.currentAnim = AnimGate.ANIMS.close
	self.currentPos = 1
	-- begin of an animation
	if self.currentAnim.beginCallback then
		self.currentAnim.beginCallback()
	end
	self:updateImg()
	return self
end

-- PUBLIC : getter for the sprite
function AnimGate:getSprite()
	return self.currentImg
end

-- PUBLIC : change animation (you can force it)
function AnimGate:load(anim, force)
	local newAnim = AnimGate.ANIMS[anim]
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

-- PUBLIC : change animation (you can force it)
function AnimGate:syncronize(anim, pos)
	local newAnim = AnimGate.ANIMS[anim]
		self.currentAnim = newAnim
		self.currentPos = pos
		self:updateImg()
		--self.currentAnim.after = newAnim		
end

-- PUBLIC : update l'anim
function AnimGate:update(seconds)
	self.time = self.time + seconds
	if self.time > self.currentAnim.DELAY then
		self:next()
		self.time = self.time - self.currentAnim.DELAY
	end
end

-- PRIVATE : go to next sprite
function AnimGate:next()
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
function AnimGate:updateImg()
	self.currentImg = AnimGate.sprites[self.folder][self.currentAnim.name][self.currentPos]
end

-- NETWORK
function AnimGate:getImgInfo()
	return {self.currentAnim.name,self.currentPos}
end
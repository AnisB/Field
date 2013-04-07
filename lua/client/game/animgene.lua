AnimGene = {}
AnimGene.__index = AnimGene

AnimGene.ANIMS = {  -- set of animations available :
	off = {},
	on = {},
	launching = {},
	shutdown ={}
}


-- name
AnimGene.ANIMS.off.name = "off"
AnimGene.ANIMS.on.name = "on"
AnimGene.ANIMS.launching.name = "launching"
AnimGene.ANIMS.shutdown.name = "shutdown"


-- delays
AnimGene.ANIMS.off.DELAY = 0.075
AnimGene.ANIMS.on.DELAY = 0.075
AnimGene.ANIMS.launching.DELAY = 0.125
AnimGene.ANIMS.shutdown.DELAY = 0.075



-- number of sprites :
AnimGene.ANIMS.off.number = 1
AnimGene.ANIMS.on.number = 8
AnimGene.ANIMS.launching.number = 8
AnimGene.ANIMS.shutdown.number = 2




-- priority :
AnimGene.ANIMS.off.priority = 10
AnimGene.ANIMS.on.priority = 20
AnimGene.ANIMS.launching.priority = 20
AnimGene.ANIMS.shutdown.priority = 20



-- automatic loopings or automatic switch :
AnimGene.ANIMS.off.loop = true
AnimGene.ANIMS.on.loop = true
AnimGene.ANIMS.launching.switch = AnimGene.ANIMS.on
AnimGene.ANIMS.shutdown.switch = AnimGene.ANIMS.off



-- PUBLIC : constructor
function AnimGene.new(folder)
	local self = {}
	setmetatable(self, AnimGene)
	self.time = 0.0
	self.sprites = {}
	for key,val in pairs(AnimGene.ANIMS) do
		self.sprites[key] = {}
		for i=1, val.number do
			local path = 'game/anim/'..folder..'/'..key..'/'..i..'.png'
			-- print("loading image =>", path)
			self.sprites[key][i] = love.graphics.newImage(path)
		end
	end
	self.currentAnim = AnimGene.ANIMS.off
	self.currentPos = 1
	-- begin of an animation
	if self.currentAnim.beginCallback then
		self.currentAnim.beginCallback()
	end
	self:updateImg()
	return self
end

-- PUBLIC : getter for the sprite
function AnimGene:getSprite()
	return self.currentImg
end

-- PUBLIC : change animation (you can force it)
function AnimGene:load(anim, force)
	local newAnim = AnimGene.ANIMS[anim]
	if force or newAnimGene.priority > self.currentAnim.priority then
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
function AnimGene:update(seconds)
	self.time = self.time + seconds
	if self.time > self.currentAnim.DELAY then
		self:next()
		self.time = self.time - self.currentAnim.DELAY
	end
end

function AnimGene:syncronize(anim, pos)
	local newAnim = AnimGene.ANIMS[anim]
		self.currentAnim = newAnim
		self.currentPos = pos
		self:updateImg()
		self.currentAnim.after = newAnim		
end
-- PRIVATE : go to next sprite
function AnimGene:next()
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
function AnimGene:updateImg()
	self.currentImg = self.sprites[self.currentAnim.name][self.currentPos]
end

-- NETWORK
function AnimGene:getImgInfo()
	return {self.currentAnim.name,self.currentPos}
end
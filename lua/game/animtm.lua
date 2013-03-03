AnimTM = {}
AnimTM.__index = AnimTM

AnimTM.ANIMS = {  -- set of animations available :
	running = {},
	startjumping = {},
	jumping = {},
	landing = {},
	standing= {},
	stoprunning={},
	field={}
}

AnimTM.DELAY = 0.100  -- toutes les 200ms, on fait AnimTM.next()

-- name
AnimTM.ANIMS.running.name = "running"
AnimTM.ANIMS.startjumping.name = "startjumping"
AnimTM.ANIMS.jumping.name = "jumping"
AnimTM.ANIMS.landing.name = "landing"
AnimTM.ANIMS.standing.name = "standing"
AnimTM.ANIMS.stoprunning.name = "stoprunning"
AnimTM.ANIMS.field.name = "field"


-- number of sprites :
AnimTM.ANIMS.running.number = 9
AnimTM.ANIMS.startjumping.number = 2
AnimTM.ANIMS.jumping.number = 3
AnimTM.ANIMS.landing.number = 4
AnimTM.ANIMS.standing.number = 6
AnimTM.ANIMS.stoprunning.number = 2
AnimTM.ANIMS.field.number = 5


-- priority :
AnimTM.ANIMS.running.priority = 10
AnimTM.ANIMS.startjumping.priority = 20
AnimTM.ANIMS.jumping.priority = 20
AnimTM.ANIMS.landing.priority = 20
AnimTM.ANIMS.standing.priority = 20
AnimTM.ANIMS.stoprunning.priority = 20
AnimTM.ANIMS.field.priority = 20


-- automatic loopings or automatic switch :
AnimTM.ANIMS.running.loop = true
AnimTM.ANIMS.startjumping.switch = AnimTM.ANIMS.jumping
AnimTM.ANIMS.jumping.loop = true
AnimTM.ANIMS.landing.switch = AnimTM.ANIMS.standing
AnimTM.ANIMS.standing.loop = true
AnimTM.ANIMS.stoprunning.switch = AnimTM.ANIMS.standing
AnimTM.ANIMS.field.loop = true


-- next AnimTM available :
AnimTM.ANIMS.running.nexts = {
	AnimTM.ANIMS.running,
	AnimTM.ANIMS.startjumping,
	AnimTM.ANIMS.landing,
	AnimTM.ANIMS.dying,
}
AnimTM.ANIMS.startjumping.nexts = {
	AnimTM.ANIMS.jumping,
	AnimTM.ANIMS.dying
}
AnimTM.ANIMS.jumping.nexts = {
	AnimTM.ANIMS.landing,
	AnimTM.ANIMS.dying
}
AnimTM.ANIMS.landing.nexts = {
	AnimTM.ANIMS.running,
	AnimTM.ANIMS.dying
}


-- PUBLIC : constructor
function AnimTM.new(folder)
	local self = {}
	setmetatable(self, AnimTM)
	self.time = 0.0
	self.sprites = {}
	for key,val in pairs(AnimTM.ANIMS) do
		self.sprites[key] = {}
		for i=1, val.number do
			local path = 'game/anim/'..folder..'/'..key..'/'..i..'.png'
			-- print("loading image =>", path)
			self.sprites[key][i] = love.graphics.newImage(path)
		end
	end
	self.currentAnim = AnimTM.ANIMS.running
	self.currentPos = 1
	-- begin of an animation
	if self.currentAnim.beginCallback then
		self.currentAnim.beginCallback()
	end
	self:updateImg()
	return self
end

-- PUBLIC : getter for the sprite
function AnimTM:getSprite()
	return self.currentImg
end

-- PUBLIC : change animation (you can force it)
function AnimTM:load(anim, force)
	local newAnim = AnimTM.ANIMS[anim]
	if force or newAnim.priority > self.currentAnim.priority then
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

-- PUBLIC : update l'AnimTM
function AnimTM:update(seconds)
	self.time = self.time + seconds
	if self.time > AnimTM.DELAY then
		self:next()
		self.time = self.time - AnimTM.DELAY
	end
end

-- PRIVATE : go to next sprite
function AnimTM:next()
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
			print("FUCKING AnimTM SWITCHING ERROR")
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
function AnimTM:updateImg()
	self.currentImg = self.sprites[self.currentAnim.name][self.currentPos]
end
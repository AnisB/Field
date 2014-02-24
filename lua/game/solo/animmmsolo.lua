AnimMMSolo = {}
AnimMMSolo.__index = AnimMMSolo

AnimMMSolo.ANIMS = {  -- set of animations available :
	running = {},
	startjumping = {},
	jumping = {},
	landing = {},
	standing= {},
	stoprunning={},
	returnanim={},
	load1={},
	load2={},
	mortelec={},
	mort={}
}

AnimMMSolo.DELAY = 0.0750  -- toutes les 200ms, on fait AnimMMSolo.next()

-- name
AnimMMSolo.ANIMS.running.name = "running"
AnimMMSolo.ANIMS.startjumping.name = "startjumping"
AnimMMSolo.ANIMS.jumping.name = "jumping"
AnimMMSolo.ANIMS.landing.name = "landing"
AnimMMSolo.ANIMS.standing.name = "standing"
AnimMMSolo.ANIMS.stoprunning.name = "stoprunning"
AnimMMSolo.ANIMS.returnanim.name = "returnanim"
AnimMMSolo.ANIMS.load1.name = "load1"
AnimMMSolo.ANIMS.load2.name = "load2"
AnimMMSolo.ANIMS.mortelec.name = "mortelec"
AnimMMSolo.ANIMS.mort.name = "mort"


-- delays
AnimMMSolo.ANIMS.running.DELAY = 0.075
AnimMMSolo.ANIMS.startjumping.DELAY = 0.075
AnimMMSolo.ANIMS.jumping.DELAY = 0.300
AnimMMSolo.ANIMS.landing.DELAY = 0.075
AnimMMSolo.ANIMS.standing.DELAY = 0.150
AnimMMSolo.ANIMS.stoprunning.DELAY = 0.075
AnimMMSolo.ANIMS.returnanim.DELAY = 0.2
AnimMMSolo.ANIMS.load1.DELAY = 0.06
AnimMMSolo.ANIMS.load2.DELAY = 0.06
AnimMMSolo.ANIMS.mortelec.DELAY = 0.1
AnimMMSolo.ANIMS.mort.DELAY = 1


-- number of sprites :
AnimMMSolo.ANIMS.running.number = 9
AnimMMSolo.ANIMS.startjumping.number = 3
AnimMMSolo.ANIMS.jumping.number = 2
AnimMMSolo.ANIMS.landing.number = 3
AnimMMSolo.ANIMS.standing.number = 6
AnimMMSolo.ANIMS.stoprunning.number = 1
AnimMMSolo.ANIMS.returnanim.number = 1
AnimMMSolo.ANIMS.load1.number = 10
AnimMMSolo.ANIMS.load2.number = 10
AnimMMSolo.ANIMS.mortelec.number = 8
AnimMMSolo.ANIMS.mort.number = 1



-- priority :
AnimMMSolo.ANIMS.running.priority = 10
AnimMMSolo.ANIMS.startjumping.priority = 20
AnimMMSolo.ANIMS.jumping.priority = 20
AnimMMSolo.ANIMS.landing.priority = 20
AnimMMSolo.ANIMS.standing.priority = 20
AnimMMSolo.ANIMS.stoprunning.priority = 20
AnimMMSolo.ANIMS.returnanim.priority = 20
AnimMMSolo.ANIMS.load1.priority = 20
AnimMMSolo.ANIMS.load2.priority = 20
AnimMMSolo.ANIMS.mortelec.priority = 20
AnimMMSolo.ANIMS.mort.priority = 1


-- automatic loopings or automatic switch :
AnimMMSolo.ANIMS.running.loop = true
AnimMMSolo.ANIMS.startjumping.switch = AnimMMSolo.ANIMS.jumping
AnimMMSolo.ANIMS.jumping.loop = true
AnimMMSolo.ANIMS.landing.switch = AnimMMSolo.ANIMS.standing
AnimMMSolo.ANIMS.standing.loop = true
AnimMMSolo.ANIMS.stoprunning.switch = AnimMMSolo.ANIMS.standing
AnimMMSolo.ANIMS.returnanim.switch = AnimMMSolo.ANIMS.running
AnimMMSolo.ANIMS.load1.switch = AnimMMSolo.ANIMS.standing
AnimMMSolo.ANIMS.load2.switch = AnimMMSolo.ANIMS.standing
AnimMMSolo.ANIMS.mortelec.switch = AnimMMSolo.ANIMS.mort
AnimMMSolo.ANIMS.mort.loop = true


-- next anim available :
AnimMMSolo.ANIMS.running.nexts = {
	AnimMMSolo.ANIMS.running,
	AnimMMSolo.ANIMS.startjumping,
	AnimMMSolo.ANIMS.landing,
	AnimMMSolo.ANIMS.dying,
}
AnimMMSolo.ANIMS.startjumping.nexts = {
	AnimMMSolo.ANIMS.jumping,
	AnimMMSolo.ANIMS.dying
}
AnimMMSolo.ANIMS.jumping.nexts = {
	AnimMMSolo.ANIMS.landing,
	AnimMMSolo.ANIMS.dying
}
AnimMMSolo.ANIMS.landing.nexts = {
	AnimMMSolo.ANIMS.running,
	AnimMMSolo.ANIMS.dying
}


-- PUBLIC : constructor
function AnimMMSolo.new(folder)
	local self = {}
	setmetatable(self, AnimMMSolo)
	self.folder=folder
	self.time = 0.0
	self.sprites = {}
	for key,val in pairs(AnimMMSolo.ANIMS) do
		self.sprites[key] = {}
		for i=1, val.number do
			local path = 'anim/'..folder..'/'..key..'/'..i..'.png'
			-- print("loading image =>", path)
			self.sprites[key][i] = s_resourceManager:LoadImage(path)
		end
	end
	self.currentAnim = AnimMMSolo.ANIMS.running
	self.currentPos = 1
	-- begin of an animation
	if self.currentAnim.beginCallback then
		self.currentAnim.beginCallback()
	end
	self:updateImg()
	return self
end

-- PUBLIC : getter for the sprite
function AnimMMSolo:getSprite()
	return self.currentImg
end

-- PUBLIC : change animation (you can force it)
function AnimMMSolo:load(anim, force)
	local newAnim = AnimMMSolo.ANIMS[anim]
	if force or newAnimMMSolo.priority > self.currentAnim.priority then
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
function AnimMMSolo:update(seconds)
	self.time = self.time + seconds
	if self.time > self.currentAnim.DELAY then
		self:next()
		self.time = self.time - self.currentAnim.DELAY
	end
end

-- PRIVATE : go to next sprite
function AnimMMSolo:next()
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
function AnimMMSolo:updateImg()
	self.currentImg = self.sprites[self.currentAnim.name][self.currentPos]
end

-- NETWORK
function AnimMMSolo:getImgInfo()
	return {self.currentAnim.name,self.currentPos}
end
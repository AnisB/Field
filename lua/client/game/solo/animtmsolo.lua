AnimTMSolo = {}
AnimTMSolo.__index = AnimTMSolo

AnimTMSolo.ANIMS = {  -- set of animations available :
	running = {},
	startjumping = {},
	jumping = {},
	landing = {},
	standing= {},
	stoprunning={},
	field={},
	returnanim={},
	launchfield={},
	mortelec={},
	mort={}
}

AnimTMSolo.DELAY = 0.100  -- toutes les 200ms, on fait AnimTMSolo.next()

-- name
AnimTMSolo.ANIMS.running.name = "running"
AnimTMSolo.ANIMS.startjumping.name = "startjumping"
AnimTMSolo.ANIMS.jumping.name = "jumping"
AnimTMSolo.ANIMS.landing.name = "landing"
AnimTMSolo.ANIMS.standing.name = "standing"
AnimTMSolo.ANIMS.stoprunning.name = "stoprunning"
AnimTMSolo.ANIMS.field.name = "field"
AnimTMSolo.ANIMS.launchfield.name = "launchfield"
AnimTMSolo.ANIMS.returnanim.name = "returnanim"
AnimTMSolo.ANIMS.mortelec.name = "mortelec"
AnimTMSolo.ANIMS.mort.name = "mort"


-- number of sprites :
AnimTMSolo.ANIMS.running.number = 9
AnimTMSolo.ANIMS.startjumping.number = 3
AnimTMSolo.ANIMS.jumping.number = 2
AnimTMSolo.ANIMS.landing.number = 3
AnimTMSolo.ANIMS.standing.number = 6
AnimTMSolo.ANIMS.stoprunning.number = 1
AnimTMSolo.ANIMS.field.number = 2
AnimTMSolo.ANIMS.returnanim.number = 1
AnimTMSolo.ANIMS.launchfield.number = 1
AnimTMSolo.ANIMS.mortelec.number = 8
AnimTMSolo.ANIMS.mort.number = 1


-- delays
AnimTMSolo.ANIMS.running.DELAY = 0.075
AnimTMSolo.ANIMS.startjumping.DELAY = 0.075
AnimTMSolo.ANIMS.jumping.DELAY = 0.300
AnimTMSolo.ANIMS.landing.DELAY = 0.075
AnimTMSolo.ANIMS.standing.DELAY = 0.150
AnimTMSolo.ANIMS.stoprunning.DELAY = 0.075
AnimTMSolo.ANIMS.returnanim.DELAY = 0.2
AnimTMSolo.ANIMS.field.DELAY = 0.3
AnimTMSolo.ANIMS.launchfield.DELAY = 0.2
AnimTMSolo.ANIMS.mortelec.DELAY = 0.1
AnimTMSolo.ANIMS.mort.DELAY = 1

-- priority :
AnimTMSolo.ANIMS.running.priority = 10
AnimTMSolo.ANIMS.startjumping.priority = 20
AnimTMSolo.ANIMS.jumping.priority = 20
AnimTMSolo.ANIMS.landing.priority = 20
AnimTMSolo.ANIMS.standing.priority = 20
AnimTMSolo.ANIMS.stoprunning.priority = 20
AnimTMSolo.ANIMS.field.priority = 20
AnimTMSolo.ANIMS.launchfield.priority = 20
AnimTMSolo.ANIMS.returnanim.priority = 20
AnimTMSolo.ANIMS.mortelec.priority = 20
AnimTMSolo.ANIMS.mort.priority = 20


-- automatic loopings or automatic switch :
AnimTMSolo.ANIMS.running.loop = true
AnimTMSolo.ANIMS.startjumping.switch = AnimTMSolo.ANIMS.jumping
AnimTMSolo.ANIMS.jumping.loop = true
AnimTMSolo.ANIMS.landing.switch = AnimTMSolo.ANIMS.standing
AnimTMSolo.ANIMS.standing.loop = true
AnimTMSolo.ANIMS.stoprunning.switch = AnimTMSolo.ANIMS.standing
AnimTMSolo.ANIMS.field.loop = true
AnimTMSolo.ANIMS.returnanim.switch = AnimTMSolo.ANIMS.running
AnimTMSolo.ANIMS.launchfield.switch = AnimTMSolo.ANIMS.field
AnimTMSolo.ANIMS.mortelec.switch=AnimTMSolo.ANIMS.mort
AnimTMSolo.ANIMS.mort.loop=true


-- next AnimTMSolo available :
AnimTMSolo.ANIMS.running.nexts = {
	AnimTMSolo.ANIMS.running,
	AnimTMSolo.ANIMS.startjumping,
	AnimTMSolo.ANIMS.landing,
	AnimTMSolo.ANIMS.dying,
}
AnimTMSolo.ANIMS.startjumping.nexts = {
	AnimTMSolo.ANIMS.jumping,
	AnimTMSolo.ANIMS.dying
}
AnimTMSolo.ANIMS.jumping.nexts = {
	AnimTMSolo.ANIMS.landing,
	AnimTMSolo.ANIMS.dying
}
AnimTMSolo.ANIMS.landing.nexts = {
	AnimTMSolo.ANIMS.running,
	AnimTMSolo.ANIMS.dying
}


-- PUBLIC : constructor
function AnimTMSolo.new(folder)
	local self = {}
	setmetatable(self, AnimTMSolo)
	self.time = 0.0
	self.sprites = {}
	for key,val in pairs(AnimTMSolo.ANIMS) do
		self.sprites[key] = {}
		for i=1, val.number do
			local path = 'game/anim/'..folder..'/'..key..'/'..i..'.png'
			-- print("loading image =>", path)
			-- gameStateManager.loader.newImage(self.sprites[key],i, path)
			self.sprites[key][i] = love.graphics.newImage(path)
		end
	end
	self.currentAnim = AnimTMSolo.ANIMS.running
	self.currentPos = 1
	-- begin of an animation
	if self.currentAnim.beginCallback then
		self.currentAnim.beginCallback()
	end
	self:updateImg()
	return self
end

-- PUBLIC : getter for the sprite
function AnimTMSolo:getSprite()
	return self.currentImg
end

-- PUBLIC : change animation (you can force it)
function AnimTMSolo:load(anim, force)
	local newAnim = AnimTMSolo.ANIMS[anim]
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

-- PUBLIC : update l'AnimTMSolo
function AnimTMSolo:update(seconds)
	self.time = self.time + seconds
	if self.time > self.currentAnim.DELAY then
		self:next()
		self.time = self.time - self.currentAnim.DELAY
	end
end

-- PRIVATE : go to next sprite
function AnimTMSolo:next()
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
			print("FUCKING AnimTMSolo SWITCHING ERROR")
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
function AnimTMSolo:updateImg()
	self.currentImg = self.sprites[self.currentAnim.name][self.currentPos]
end

-- NETWORK
function AnimTMSolo:getImgInfo()
	return {self.currentAnim.name,self.currentPos}
end
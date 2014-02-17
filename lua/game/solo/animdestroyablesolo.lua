AnimDestroyableSolo = {}
AnimDestroyableSolo.__index = AnimDestroyableSolo

AnimDestroyableSolo.ANIMS = {  -- set of animations available :
	normal = {},
	breaking = {},
	destroyed = {}
}


-- name
AnimDestroyableSolo.ANIMS.normal.name = "normal"
AnimDestroyableSolo.ANIMS.breaking.name = "breaking"
AnimDestroyableSolo.ANIMS.destroyed.name = "destroyed"


-- number of sprites :
AnimDestroyableSolo.ANIMS.normal.number = 1
AnimDestroyableSolo.ANIMS.breaking.number = 3
AnimDestroyableSolo.ANIMS.destroyed.number = 1


AnimDestroyableSolo.ANIMS.normal.DELAY= 0.2
AnimDestroyableSolo.ANIMS.breaking.DELAY= 0.075
AnimDestroyableSolo.ANIMS.destroyed.DELAY= 0.2
-- priority 
AnimDestroyableSolo.ANIMS.normal.priority = 10
AnimDestroyableSolo.ANIMS.breaking.priority = 20
AnimDestroyableSolo.ANIMS.destroyed.priority = 10


-- automatic loopings or automatic switch :
AnimDestroyableSolo.ANIMS.normal.loop = true
AnimDestroyableSolo.ANIMS.breaking.switch = AnimDestroyableSolo.ANIMS.destroyed
AnimDestroyableSolo.ANIMS.destroyed.loop = true

AnimDestroyableSolo.sprites={}

-- PUBLIC : constructor
function AnimDestroyableSolo.new(folder)
	local self = {}
	setmetatable(self, AnimDestroyableSolo)
	self.time = 0.0
	-- self.sprites = {}
	if AnimDestroyableSolo.sprites[folder]==nil then
		AnimDestroyableSolo.sprites[folder]={}
		for key,val in pairs(AnimDestroyableSolo.ANIMS) do
			AnimDestroyableSolo.sprites[folder][key] = {}
			for i=1, val.number do
				local path = 'anim/'..folder..'/'..key..'/'..i..'.png'
			-- print("loading image =>", path)
			--self.sprites[key][i] = 
			    -- gameStateManager.loader.newImage(AnimDestroyableSolo.sprites[folder][key],i, path)
			    AnimDestroyableSolo.sprites[folder][key][i] = s_resourceManager:LoadImage(path)

			end
		end
	end
	self.folder=folder
	self.currentAnim = AnimDestroyableSolo.ANIMS.normal
	self.currentPos = 1
	-- begin of an animation
	if self.currentAnim.beginCallback then
		self.currentAnim.beginCallback()
	end
	self:updateImg()
	return self
end

-- PUBLIC : getter for the sprite
function AnimDestroyableSolo:getSprite()
	return self.currentImg
end

-- PUBLIC : change animation (you can force it)
function AnimDestroyableSolo:load(anim, force)
	local newAnim = AnimDestroyableSolo.ANIMS[anim]
	if force or newAnimDestroyable.priority > self.currentAnim.priority then
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
function AnimDestroyableSolo:update(seconds)
	self.time = self.time + seconds
	if self.time > self.currentAnim.DELAY then
		self:next()
		self.time = self.time - self.currentAnim.DELAY
	end
end

-- PRIVATE : go to next sprite
function AnimDestroyableSolo:next()
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
function AnimDestroyableSolo:updateImg()
	self.currentImg = AnimDestroyableSolo.sprites[self.folder][self.currentAnim.name][self.currentPos]
end

-- NETWORK
function AnimDestroyableSolo:getImgInfo()
	return {self.currentAnim.name,self.currentPos}
end
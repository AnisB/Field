AnimBloc = {}
AnimBloc.__index = AnimBloc

AnimBloc.ANIMS = {  -- set of animations available :
	normal = {}
}


-- name
AnimBloc.ANIMS.normal.name = "normal"
-- number of sprites :
AnimBloc.ANIMS.normal.number = 4


AnimBloc.ANIMS.normal.DELAY= 0.2
-- priority 
AnimBloc.ANIMS.normal.priority = 10


-- automatic loopings or automatic switch :
AnimBloc.ANIMS.normal.loop = true



-- PUBLIC : constructor
function AnimBloc.new(folder)
	local self = {}
	setmetatable(self, AnimBloc)
	self.time = 0.0
	self.sprites = {}
	for key,val in pairs(AnimBloc.ANIMS) do
		self.sprites[key] = {}
		for i=1, val.number do
			local path = 'anim/'..folder..'/'..key..'/'..i..'.png'
			-- print("loading image =>", path)
			self.sprites[key][i] = love.graphics.newImage(path)
		end
	end
	self.currentAnim = AnimBloc.ANIMS.normal
	self.currentPos = 1
	-- begin of an animation
	if self.currentAnim.beginCallback then
		self.currentAnim.beginCallback()
	end
	self:updateImg()
	return self
end

-- PUBLIC : getter for the sprite
function AnimBloc:getSprite()
	return self.currentImg
end


function AnimBloc:syncronize(anim, pos)
	local newAnim = AnimBloc.ANIMS[anim]
		self.currentAnim = newAnim
		self.currentPos = pos
		self:updateImg()
		self.currentAnim.after = newAnim		
end

-- PUBLIC : change animation (you can force it)
function AnimBloc:load(anim, force)
	local newAnim = AnimBloc.ANIMS[anim]
	if force or newAnimBloc.priority > self.currentAnim.priority then
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
function AnimBloc:update(seconds)
	self.time = self.time + seconds
	if self.time > self.currentAnim.DELAY then
		self:next()
		self.time = self.time - self.currentAnim.DELAY
	end
end

-- PRIVATE : go to next sprite
function AnimBloc:next()
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
function AnimBloc:updateImg()
	self.currentImg = self.sprites[self.currentAnim.name][self.currentPos]
end

-- NETWORK
function AnimBloc:getImgInfo()
	return {self.currentAnim.name,self.currentPos}
end
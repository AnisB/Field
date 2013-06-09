BasicAnim = {}
BasicAnim.__index = BasicAnim

BasicAnim.sprites={}

-- PUBLIC : constructor
function BasicAnim.new(folder,looping,delay,number)
	local self = {}
	setmetatable(self, BasicAnim)
	self.time = 0.0
	self.delay= delay
	self.loop = looping
	self.number = number

	if BasicAnim.sprites[folder]==nil then
		BasicAnim.sprites[folder]={}
		for i=1, self.number do
			local path = 'game/anim/'..folder..'/'..i..'.png'
		    BasicAnim.sprites[folder][i] = love.graphics.newImage(path)

		end
	end
	self.folder=folder
	self.currentPos = 1
	self:updateImg()
	return self
end

function BasicAnim.newL(folder,looping,delay,number)
	local self = {}
	setmetatable(self, BasicAnim)
	self.time = 0.0
	self.delay= delay
	self.loop = looping
	self.number = number

	if BasicAnim.sprites[folder]==nil then
		BasicAnim.sprites[folder]={}
		for i=1, self.number do
			local path = 'game/anim/'..folder..'/'..i..'.png'
		    -- BasicAnim.sprites[folder][i] = love.graphics.newImage(path)
		    -- On doit utiliser le loader
		end
	end
	self.folder=folder
	self.currentPos = 1
	self:updateImg()
	return self
end

-- PUBLIC : getter for the sprite
function BasicAnim:getSprite()
	return self.currentImg
end

function BasicAnim:syncronize( pos)
	self.currentPos = pos
	self:updateImg()
end

-- PUBLIC : update l'anim
function BasicAnim:update(seconds)
	self.time = self.time + seconds
	if self.time > self.delay then
		self:next()
		self.time = self.time - self.delay
	end
end

-- PRIVATE : go to next sprite
function BasicAnim:next()
	self.currentPos = self.currentPos + 1
	if self.currentPos > self.number then
		if self.loop then
			self.currentPos = 1
		else
			self.finished=true
		end
	end
	self:updateImg()
end

-- PRIVATE
function BasicAnim:updateImg()
	self.currentImg = BasicAnim.sprites[self.folder][self.currentPos]
end

-- NETWORK
function BasicAnim:getImgInfo()
	return {self.currentAnim.name,self.currentPos}
end
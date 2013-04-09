FieldSound = {}
FieldSound.__index = FieldSound

FieldSound.SOUND_ROOT = "sound/"
FieldSound.SOUND_LOOP = ""--"loop"

FADING_DURATION = 1 --durée des fading in et out
FIELD_SOUND_VOLUME = 1




function FieldSound.new(soundName)

    local self = {}
    setmetatable(self, FieldSound)
	
	local name = ""
	if soundName == "Attractive" then name="att"
	elseif soundName == "RotativeR" then name = "rot"
	elseif soundName == "RotativeL" then name = "rot"
	elseif soundName == "Repulsive" then name = "rep"
	elseif soundName == "Static" then name = "stat"
	end
	local path = FieldSound.SOUND_ROOT..name..'.ogg'
	local pathLoop = FieldSound.SOUND_ROOT..name..FieldSound.SOUND_LOOP..'.ogg'
	self.src = love.audio.newSource(path, "static")
	self.srcLoop = love.audio.newSource(pathLoop, "static")
	self.src:setDistance(200,1000)
	self.srcLoop:setDistance(200,1000)
	self.isFadingIn = false
	self.isFadingOut = false
	self.currentVolume = 0
	self.isDone = false
	self.isStopped = false
    return self
end

function FieldSound:play()
	self.isDone = false
	self.isFadingIn = true
	self.isStopped = false
	self.src:play()
	self.src:setLooping(false)
end

function FieldSound:update(dt)
	if self.isFadingIn then
		self.currentVolume = self.currentVolume + ((dt*FIELD_SOUND_VOLUME)/FADING_DURATION)
		if self.currentVolume >= FIELD_SOUND_VOLUME then
			self.currentVolume = FIELD_SOUND_VOLUME
			self.isFadingIn = false
		end
	elseif self.isFadingOut then
		self.currentVolume = self.currentVolume - ((dt*FIELD_SOUND_VOLUME)/FADING_DURATION)
		if self.currentVolume <= 0 then
			self.srcLoop:setLooping(false)
			self.currentVolume = 0
			self.isFadingOut = false
			self.isDone = true
			self.isStopped = true
		end
	end
	if self.src:isStopped() then
		if self.isStopped~=true then
			if self.srcLoop:isStopped() then
				self.srcLoop:setLooping(true)
				self.srcLoop:play()
			end
		end
	end
	self.src:setVolume(self.currentVolume)
	self.srcLoop:setVolume(self.currentVolume)
end

function FieldSound:setPosition(position)
	self.src:setPosition(position.x, position.y, 0)
	self.srcLoop:setPosition(position.x, position.y, 0)
end

function FieldSound:stop()
	self.isFadingOut = true
	self.isFadingIn = false
	self.isStopped = true
	self.srcLoop:setLooping(false)
end

function FieldSound:done()
	return self.isDone
end

function FieldSound:immediateStop() --should be called before deleting the object
	self.srcLoop:setLooping(false)
	self.src:setVolume(0)
	self.srcLoop:setVolume(0)
	self.isStopped=true
	self.isDone=true
	self.isPlaying=false
	self.src:stop()
	self.srcLoop:stop()
	self.src=nil
	self.srcLoop=nil
end

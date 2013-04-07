FieldSound = {}
FieldSound.__index = FieldSound

FieldSound.SOUND_ROOT = "sound/"
FieldSound.SOUND_LOOP = ""--"loop"

FADING_DURATION = 0.5 --durée des fading in et out
SOUND_VOLUME = 1


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
	-- init
	local path = FieldSound.SOUND_ROOT..name..'.wav'
	local pathLoop = FieldSound.SOUND_ROOT..name..FieldSound.SOUND_LOOP..'.wav'
	self.src = love.audio.newSource(path, "static")
	self.srcLoop = love.audio.newSource(pathLoop, "static")
	self.isFadingIn = false
	self.isFadingOut = false
	self.currentVolume = 1
	self.isDone = false
	self.isPlaying = false
	self.isStopped = false
    return self
end

function FieldSound:play()
	self.isFadingIn = true
	self.isPlaying = true
	self.src:play()
	self.src:setLooping(false)
end

function FieldSound:update(dt)
	if self.isPlaying then
		if self.isFadingIn then
			self.currentVolume = self.currentVolume + ((dt*SOUND_VOLUME)/FADING_DURATION)
			if self.currentVolume >= SOUND_VOLUME then
				self.currentVolume = SOUND_VOLUME
				self.isFadingIn = false
			end
		elseif self.isFadingOut then
			self.currentVolume = self.currentVolume - ((dt*SOUND_VOLUME)/FADING_DURATION)
			if self.currentVolume <= 0 then
				self.srcLoop:setLooping(false)
				self.currentVolume = 0
				self.isFadingOut = false
				self.isDone = true
			end
		end
		if self.src:isStopped() then
			if self.isStopped~=true then
				self.srcLoop:setLooping(true)
				self.srcLoop:play()
			end
		end
		
		self.src:setVolume(self.currentVolume)
		self.srcLoop:setVolume(self.currentVolume)
	end
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

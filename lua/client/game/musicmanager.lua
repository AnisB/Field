MusicManager = {}
MusicManager.__index = MusicManager

MusicManager.SOUND_ROOT = "sound/"
MusicManager.SOUND_LOOP = ""--"loop"

MUSIC_VOL = 10


function MusicManager.new()
    local self = {}
    setmetatable(self, MusicManager)
	
	local introPath = MusicManager.SOUND_ROOT.."theme"..'.ogg'
	local mainLoopPath = MusicManager.SOUND_ROOT.."theme"..'.ogg'
	self.srcIntro = love.audio.newSource(introPath)
	self.srcMainLoop = love.audio.newSource(mainLoopPath)

	self.introIsDone = false
    return self
end

function MusicManager:play()
	self.isPlaying = true
	self.introIsDone =false
	self.srcIntro:play()
	self.srcIntro:setVolume(MUSIC_VOL)
	self.srcIntro:setLooping(false)
end

function MusicManager:update(dt)
	if self.isPlaying then
		if self.srcIntro:isStopped()  and not self.introIsDone then
			self.introIsDone =true
			if self.isStopped~=true then
				if self.srcLoop:isStopped() then
					self.srcMainLoop:setLooping(true)
					self.srcMainLoop:play()
					self.srcMainLoop:setVolume(MUSIC_VOL)
				end
			end
		end
	end
end
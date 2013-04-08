MusicManager = {}
MusicManager.__index = MusicManager

MusicManager.SOUND_ROOT = "sound/"
MusicManager.SOUND_LOOP = ""--"loop"

MUSIC_VOL = 10


function MusicManager.new()
    local self = {}
    setmetatable(self, MusicManager)
	
	local introPath = MusicManager.SOUND_ROOT.."intro"..'.ogg'
	local mainLoopPath = MusicManager.SOUND_ROOT.."base"..'.ogg'
	self.srcIntro = love.audio.newSource(introPath)
	self.srcMainLoop = love.audio.newSource(mainLoopPath)
	self.secondaryLoop={}
	self.introIsDone = false
	self.upondate=true
    return self
end


function MusicManager:addSound(name)
	local sound=nil
	sound.src= love.audio.newSource(MusicManager.SOUND_ROOT..name..".ogg")
	sound.isActive=false
	sound.shouldBeActive=true
	self.secondaryLoop[name]=sound
	self.upondate=false

end

function MusicManager:removeSound(name)

	if self.secondaryLoop[name]~=nil then
		self.secondaryLoop[name].isActive=false
		self.secondaryLoop[name].shouldBeActive=false
		self.secondaryLoop[name].src:stop()
		self.upondate=false
	end
end

function MusicManager:play()
	self.isPlaying = true
	self.introIsDone =false
	self.srcIntro:play()
	self.srcIntro:setVolume(MUSIC_VOL)
	self.srcIntro:setLooping(false)
end


function MusicManager:reset()
-- TODO
end


function MusicManager:update(dt)
	if self.isPlaying then
		if self.srcIntro:isStopped()  and not self.introIsDone then
			self.introIsDone =true
			self.srcMainLoop:setLooping(true)
			self.srcMainLoop:play()
			self.srcMainLoop:setVolume(MUSIC_VOL)
		end
	end
end
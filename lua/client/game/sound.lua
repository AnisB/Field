Sound = {}
Sound.__index = Sound

Sound.SOUND_ROOT = "sound/"
Sound.sources = {}
Sound.currentMusic = nil

--[[--
UTILISATION :

	Les trois contrôles standard :
		Sound.play() : play
		Sound.pause() : pause
		Sound.stop() : stop

	Jouer une musique (longue durée) :
		Sound.playMusic("nom")

	Jouer un son (durée très courte) :
		Sound.playSound("nom")

--]]--

MUSIC_VOLUME = 1
SOUND_VOLUME = 0.1
Sound.isPaused = false

Sound.play = function ()
	if Sound.currentMusic then 
		Sound.currentMusic:play()
		Sound.isPaused = false
	end
end

Sound.pause = function ()
	if Sound.currentMusic then 
		Sound.currentMusic:pause() 
		Sound.isPaused = true
	end
end

Sound.stop = function ()
	if Sound.currentMusic then Sound.currentMusic:stop() end
end

Sound.playMusic = function (name,isLoop)
	if Sound.sources[name] == nil then
		Sound.preload(name,isLoop)
	end
	local src = Sound.sources[name]
	if src == Sound.currentMusic then
		return
	else
		if Sound.currentMusic then
			Sound.currentMusic:pause()
		end
		Sound.currentMusic = src
		src:setVolume(MUSIC_VOLUME)
		Sound.currentMusic:play()
	end
end

Sound.playSound = function (name)
	local path = Sound.SOUND_ROOT..name..'.ogg'
	local src = love.audio.newSource(path, "static")
	src:play()

	src:setVolume(SOUND_VOLUME)
	return src
end


Sound.getSound = function (name)
	local path = Sound.SOUND_ROOT..name..'.ogg'
	local src = love.audio.newSource(path, "static")
	src:setVolume(SOUND_VOLUME)
	return src
end

-- PRIVATE
Sound.preload = function (name,isLoop)
	if Sound.sources[name] ~= nil then
		return
	end
	local path = Sound.SOUND_ROOT..name..'.wav'
	local src = love.audio.newSource(path)
	src:setLooping(isLoop)
	if name == "themeprincipal" then
		src:setLooping(true)
		src:seek(math.random(0, 100), "seconds")
	end
	src:setVolume(MUSIC_VOLUME)
	Sound.sources[name] = src
end
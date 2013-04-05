
require "love.filesystem"
require "love.image"
require "love.audio"
require "love.sound"

local ressourceTypes = {
  image = {
    requestKey  = "imagePath",
    resourceKey = "imageData",
    constructor = love.image.newImageData,
    postProcess = function(data)
      return love.graphics.newImage(data)
    end
  },
  source = {
    requestKey  = "sourcePath",
    resourceKey = "source",
    constructor = function(path)
      return love.audio.newSource(path)
    end
  },
  stream = {
    requestKey  = "streamPath",
    resourceKey = "stream",
    constructor = function(path)
      return love.audio.newSource(path, "stream")
    end
  },
  soundData = {
    requestKey  = "soundDataPathOrDecoder",
    resourceKey = "soundData",
    constructor = love.sound.newSoundData
  },
  imageData = {
    requestKey  = "imageDataPath",
    resourceKey = "rawImageData",
    constructor = love.image.newImageData
  }
}

-- compatibility with LÖVE v0.7.x and 0.8.x
local function setInThread(thread, key, value)
  return (thread.set or thread.send)(thread, key, value)
end

local function getFromThread(thread, key)
  return (thread.get or thread.receive)(thread, key)
end

local producer = love.thread.getThread('loader')

if producer then

  local requestParam, resource
  local done = false

  while not done do

    for _,kind in pairs(ressourceTypes) do
      requestParam = getFromThread(producer, kind.requestKey)
      if requestParam then
        resource = kind.constructor(requestParam)
        setInThread(producer, kind.resourceKey, resource)
      end
    end

    done = getFromThread(producer, "done")
  end

else

  local loader = {}

  local pending = {}
  local callbacks = {}
  local resourceBeingLoaded

  local pathToThisFile = (...):gsub("%.", "/") .. ".lua"

  local function shift(t)
    return table.remove(t,1)
  end

  local function newResource(kind, holder, key, requestParam)
    pending[#pending + 1] = {
      kind = kind, holder = holder, key = key, requestParam = requestParam
    }
  end

  local function getResourceFromThreadIfAvailable(thread)
    local errorMessage = getFromThread(thread,"error")
    assert(not errorMessage, errorMessage)

    local data, resource
    for name,kind in pairs(ressourceTypes) do
      data = getFromThread(thread, kind.resourceKey)
      if data then
        resource = kind.postProcess and kind.postProcess(data, resourceBeingLoaded) or data
        resourceBeingLoaded.holder[resourceBeingLoaded.key] = resource
        loader.loadedCount = loader.loadedCount + 1
        callbacks.oneLoaded(resourceBeingLoaded.kind, resourceBeingLoaded.holder, resourceBeingLoaded.key)
        resourceBeingLoaded = nil
      end
    end
  end

  local function requestNewResourceToThread(thread)
    resourceBeingLoaded = shift(pending)
    local requestKey = ressourceTypes[resourceBeingLoaded.kind].requestKey
    setInThread(thread, requestKey, resourceBeingLoaded.requestParam)
  end

  local function endThreadIfAllLoaded(thread)
    if not resourceBeingLoaded and #pending == 0 then
      setInThread(thread,"done",true)
      callbacks.allLoaded()
    end
  end


  -- public interface starts here

  function loader.newImage(holder, key, path)
    newResource('image', holder, key, path)
  end

  function loader.newSource(holder, key, path, sourceType)
    local kind = (sourceType == 'stream' and 'stream' or 'source')
    newResource(kind, holder, key, path)
  end

  function loader.newSoundData(holder, key, pathOrDecoder)
    newResource('soundData', holder, key, pathOrDecoder)
  end

  function loader.newImageData(holder, key, path)
    newResource('imageData', holder, key, path)
  end

  function loader.start(allLoadedCallback, oneLoadedCallback)

    callbacks.allLoaded = allLoadedCallback or function() end
    callbacks.oneLoaded = oneLoadedCallback or function() end

    local thread = love.thread.newThread("loader", pathToThisFile)

    loader.loadedCount = 0
    loader.resourceCount = #pending
    thread:start()
  end

  function loader.update()
    local thread = love.thread.getThread("loader")
    if thread then
      if resourceBeingLoaded then
        getResourceFromThreadIfAvailable(thread)
        endThreadIfAllLoaded(thread)
      elseif #pending > 0 then
        requestNewResourceToThread(thread)
      end
    end
  end

  return loader
end
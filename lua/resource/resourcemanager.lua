ResourceManager = {}
ResourceManager.__index = ResourceManager
-- PUBLIC : constructor
function ResourceManager.new()
	local self = {}
	setmetatable(self, ResourceManager)
	self.imagedata = {}
	self.images = {}
	self.fonts = {}
	self.sound = {}
	return self
end

function ResourceManager:LoadImageData( parImageDataPath)
	if(self.imagedata[parImageDataPath] == nil) then
		self.imagedata[parImageDataPath] = love.image.newImageData(parImageDataPath)
	end
	return self.imagedata[parImageDataPath]
end

function ResourceManager:LoadImage( parImagePath)
	if(self.images[parImagePath] == nil) then
		self.images[parImagePath] = love.graphics.newImage(parImagePath)
	end
	return self.images[parImagePath]
end

function ResourceManager:LoadFont( parFontPath, parSize)
	if(self.fonts[parFontPath] == nil) then
		self.fonts[parFontPath] = love.graphics.newFont(parFontPath, parSize)
	end
	return self.fonts[parFontPath]
end


s_resourceManager = ResourceManager.new()
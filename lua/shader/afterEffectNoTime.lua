--[[ 
This file is part of the Field project
]]

AfterEffectNoTime = {}
AfterEffectNoTime.__index = AfterEffectNoTime

function AfterEffectNoTime.new(parPath)
	local self = {}
	setmetatable(self, AfterEffectNoTime)
	self:init(parPath)
    self.canvas = love.graphics.newCanvas(windowW, windowH)
    self.active = false
	return self
end


function AfterEffectNoTime:init(parPath)
	local file = love.filesystem.read(parPath,all)
	local xf = love.graphics.newShader(file)
	self.xf = xf
end

function AfterEffectNoTime:setParameter(p)
	for k,v in pairs(p) do
		self.xf:send(k,v)
	end
end

function AfterEffectNoTime:activate()
    self.active = true
end

function AfterEffectNoTime:update()
end

function AfterEffectNoTime:injectTex(parTexName, parImagePath)
	self.xf:send(parTexName,s_resourceManager:LoadImage(parImagePath))
end
function AfterEffectNoTime:injectUniform(parUniform, parVal)
	self.xf:send(parUniform, parVal)
end

function AfterEffectNoTime:enableCanvas()
		self.canvas:clear()
		love.graphics.setCanvas(self.canvas)
end

function AfterEffectNoTime:disableCanvas()
		love.graphics.setCanvas()	
end

function AfterEffectNoTime:filterPass(filter)
	love.graphics.setShader(self.xf)
	love.graphics.setColor(255,255,255,255*filter)
	love.graphics.draw(self.canvas,0,0)
	love.graphics.setShader()
end
function AfterEffectNoTime:pass()
	love.graphics.setShader(self.xf)
	love.graphics.draw(self.canvas,0,0)
	love.graphics.setShader()
end
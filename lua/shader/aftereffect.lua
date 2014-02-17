--[[ 
This file is part of the Field project
]]

AfterEffect = {}
AfterEffect.__index = AfterEffect

function AfterEffect.new(parPath)
	local self = {}
	setmetatable(self, AfterEffect)
	self:init(parPath)
    self.canvas = love.graphics.newCanvas(windowW, windowH)
    self.duration = 1.0
    self.active = false
    self.autoReset = false
	return self
end


function AfterEffect:init(parPath)
	local file = love.filesystem.read(parPath,all)
	local xf = love.graphics.newShader(file)
	self.xf = xf
	self.time = 0
end

function AfterEffect:setDuration(parTime)
	self.duration = parTime
end

function AfterEffect:setAutoReset(parReset)
	self.autoReset = parReset
end

function AfterEffect:inject(parTexName, parImagePath)
	self.xf:send(parTexName,s_resourceManager:LoadImage(parImagePath))
end

function AfterEffect:setParameter(p)
		for k,v in pairs(p) do
			self.xf:send(k,v)
		end
end

function AfterEffect:activate()
    self.active = true
    self.time = 0
end

function AfterEffect:update(dt)
	if(self.active) then
		self.time = self.time + dt
		if(self.time>=self.duration) then
			if not self.autoReset then
				self.active = false
			else
				self.time = 0
			end
		end
	end
	self.xf:send("time",self.time)
end

function AfterEffect:enableCanvas()
		self.canvas:clear()
		love.graphics.setCanvas(self.canvas)
end

function AfterEffect:disableCanvas()
		love.graphics.setCanvas()	
end

function AfterEffect:filterPass(filter)
	if(self.active or self.time>0) then
		love.graphics.setShader(self.xf)
	end
	love.graphics.setColor(255,255,255,255*filter)
	love.graphics.draw(self.canvas,0,0)
	love.graphics.setShader()
end
function AfterEffect:pass()
	if(self.active or self.time>0) then
		love.graphics.setShader(self.xf)
	end
	love.graphics.draw(self.canvas,0,0)
	love.graphics.setShader()
end
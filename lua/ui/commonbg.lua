--[[ 
This file is part of the Field project]]


require("ui.autoloopingbackground")
require("render.basicanim")

CommonBackground = {}
CommonBackground.__index = CommonBackground
function CommonBackground.new(isSimplfied)
    local self = {}
    setmetatable(self, CommonBackground)

    self.back2=s_resourceManager:LoadImage("backgrounds/common/back2.png")
    self.back1=AutoLoopingBackground.new("backgrounds/common/back1.png",300,300)
    self.back0=AutoLoopingBackground.new("backgrounds/common/back0.png",300)
    self.isSimplfied = isSimplfied
    if self.isSimplfied == true then
    else
    	self.mm = BasicAnim.new("runningmm", true,0.075,9)
    	self.tm = BasicAnim.new("runningtm", true,0.075,9)
    	self.tm:syncronize(4)
	end
    self.logo = BasicAnim.new("logo", true,0.15,8)
    return self
end

function CommonBackground:update(dt) 
	if self.isSimplfied == true then
    else
    	self.tm:update(dt)
    	self.mm:update(dt)
	end

	self.logo:update(dt)
    self.back1:update(dt)
	self.back0:update(dt)
end


function CommonBackground:draw(filter)
	local color = 255*filter
	love.graphics.setColor(color,color,color,255)
	self.back0:draw()
    self.back1:draw()
	love.graphics.draw(self.back2,0,0)
	if self.isSimplfied == true then
    else
    	love.graphics.draw(self.tm:getSprite(),600,300)
    	love.graphics.draw(self.mm:getSprite(),850,300)
	end

 	love.graphics.draw(self.logo:getSprite(),50,0)
end

--[[ 
This file is part of the Field project]]


require("game.ui.button")
require("game.ui.autoloopingbackground")
require("game.ui.confirmationpopup")
require("game.basicanim")

CommonBackground = {}
CommonBackground.__index = CommonBackground
function CommonBackground.new(isSimplfied)
    local self = {}
    setmetatable(self, CommonBackground)

    self.back2=love.graphics.newImage("backgrounds/common/back2.png")
    self.back1=AutoLoopingBackground.new("backgrounds/common/back1.png",300)
    self.isSimplfied = isSimplfied
    if self.isSimplfied == true then
        self.back1=SimpleBackground.new("backgrounds/common/back1.png",300)
    else
    	self.mm = BasicAnim.new("runningmm", true,0.075,9)
    	self.tm = BasicAnim.new("runningtm", true,0.075,9)
    	self.tm:syncronize(4)
        self.back1=AutoLoopingBackground.new("backgrounds/common/back1.png",300)
	end
    self.logo = BasicAnim.new("logosmall", true,0.2,4)
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
end


function CommonBackground:draw(filter)
	local color = 255*filter
	love.graphics.setColor(color,color,color,255)
	self.back1:draw()
	love.graphics.draw(self.back2,0,0)
	if self.isSimplfied == true then
    else
    	love.graphics.draw(self.tm:getSprite(),600,300)
    	love.graphics.draw(self.mm:getSprite(),850,300)
	end

 	love.graphics.draw(self.logo:getSprite(),50,0)
end

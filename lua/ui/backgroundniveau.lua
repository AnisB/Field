--[[ 
This file is part of the Field project]]


require("ui.button")
require("ui.autoloopingbackground")
require("ui.confirmationpopup")
require("render.basicanim")

BackgroundNiveau = {}
BackgroundNiveau.__index = BackgroundNiveau
function BackgroundNiveau.new()
    local self = {}
    setmetatable(self, BackgroundNiveau)

    self.back3=s_resourceManager:LoadImage("backgrounds/common/back3.png")
    self.back1=AutoLoopingBackground.new("backgrounds/common/back1.png",300)
    self.logo = BasicAnim.new("logo", true,0.15,8)
    return self
end

function BackgroundNiveau:update(dt) 
	self.logo:update(dt)
	self.back1:update(dt)
end


function BackgroundNiveau:draw(filter)
	local color = 255*filter
	love.graphics.setColor(color,color,color,255)
	self.back1:draw()
	love.graphics.draw(self.back3,0,0)

 	love.graphics.draw(self.logo:getSprite(),50,0)
end

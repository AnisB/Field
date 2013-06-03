--[[ 
This file is part of the Field project]]


require("game.ui.button")
require("game.ui.autoloopingbackground")
require("game.ui.confirmationpopup")
require("game.basicanim")

BackgroundNiveau = {}
BackgroundNiveau.__index = BackgroundNiveau
function BackgroundNiveau.new()
    local self = {}
    setmetatable(self, BackgroundNiveau)

    self.back3=love.graphics.newImage("backgrounds/common/back3.png")
    self.back1=AutoLoopingBackground.new("backgrounds/common/back1.png",300)
    self.logo = BasicAnim.new("logo", true,0.2,8)
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

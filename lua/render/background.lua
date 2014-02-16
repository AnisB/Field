--[[ 
	This file is part of the Field project
]]


Background = {}
Background.__index =  Background

Background.sprites = {}
function Background.new(path,scale,ymap)
    local self = {}
    setmetatable(self, Background)

    if Background.sprites[path] ==nil  then
        Background.sprites[path]=s_resourceManager:LoadImage(path)
    end
    self.img = path
    self.scale=scale
    self.ymap=ymap
    self.scale=scale
    self.quad= love.graphics.newQuad(0, 0, 1280, 800, 2560, 800)

    return self
end


function Background:destroy()
end

function Background:update(dt)
end


function Background:draw(pos)
    local img = Background.sprites[self.img]
	love.graphics.draw( img, self.quad,-(pos.x)*self.scale%1280-1280, -(img:getHeight()-windowH)*pos.y/self.ymap)
	love.graphics.draw( img, self.quad, -(pos.x)*self.scale%1280, -(img:getHeight()-windowH)*pos.y/self.ymap)
end
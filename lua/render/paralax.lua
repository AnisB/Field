--[[ 
	This file is part of the Field project
]]

require("render.background")


Paralax = {}
Paralax.__index =  Paralax

Paralax.sprites = {}
function Paralax.new(path,ymap)
    local self = {}
    setmetatable(self, Paralax)
    self.ymap = ymap
    self.path = path
    self.background1=Background.new(self.path.."/1.png",1,self.ymap)
    self.background2=Background.new(self.path.."/2.png",0.75,self.ymap)
    self.background3=Background.new(self.path.."/3.png",0.5,self.ymap)
    self.background4=Background.new(self.path.."/4.png",0.25,self.ymap)
    self.background5=SimpleBackground.new(self.path.."/5.png",0.0,self.ymap)

    self.background=Background.new(self.path.."/noparalax/1.png",1,self.ymap)

    self.isActive = true
    return self
end

function Paralax:setEnable(parVal)
    self.isActive = parVal
end
function Paralax:destroy()
    for i,j in pairs(Background.sprites) do
        j = nil
    end
    collectgarbage("collect")
end

function Paralax:update(dt)
end


function Paralax:draw(pos)
    if(self.isActive) then
        self.background5:draw(pos)
        self.background4:draw(pos)
        self.background3:draw(pos)
        self.background2:draw(pos)
        self.background1:draw(pos)
    else
        self.background:draw(pos)
    end
end
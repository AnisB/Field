--[[ 
	This file is part of the Field project
]]


LoadingScreen = {}
LoadingScreen.__index =  LoadingScreen

function LoadingScreen.new(options)
    local self = {}
    setmetatable(self, LoadingScreen)
    math.randomseed(os.time())
    self.spiral = love.graphics.newImage('media/spiral.png')
    self.spiralAngle = 0
    self.screenWidth, self.screenHeight = love.graphics.getWidth(), love.graphics.getHeight()
    return self
end




function LoadingScreen:update(dt)
	self.spiralAngle = self.spiralAngle + 2*dt
end


function LoadingScreen:draw()
	self:drawSpiral()
	self:drawLoadingBar()
end




 function LoadingScreen:drawSpiral()
  local w,h = self.spiral:getWidth(), self.spiral:getHeight()
  local x,y = windowW/2, windowH/2
  love.graphics.draw(self.spiral, x, y, self.spiralAngle, 1, 1, w/2, h/2)
end

 function LoadingScreen:drawLoadingBar()
  local separation = 30;
  local w = windowW - 2*separation
  local h = 50;
  local x,y = separation, windowH - separation - h;
  love.graphics.rectangle("line", x, y, w, h)

  x, y = x + 3, y + 3
  w, h = w - 6, h - 7

  if gameStateManager.loader.loadedCount > 0 then
    w = w * (gameStateManager.loader.loadedCount / gameStateManager.loader.resourceCount)
  end
  love.graphics.rectangle("fill", x, y, w, h)
end
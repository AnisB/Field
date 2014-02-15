--[[ 
	This file is part of the Field project
]]


LoadingScreen = {}
LoadingScreen.__index =  LoadingScreen


LoadingScreen.spiral = love.graphics.newImage("img/loading.png")


function LoadingScreen.new(options)
    local self = {}
    setmetatable(self, LoadingScreen)
    math.randomseed(os.time())

    self.screenWidth, self.screenHeight = love.graphics.getWidth(), love.graphics.getHeight()
    self.timer = 1
    self.gd = true
    return self
end




function LoadingScreen:update(dt)
  if self.gd then
    self.timer = self.timer -dt
    if self.timer <= 0 then
      self.timer = 0
      self.gd = false
    end
  else
    self.timer = self.timer  +dt
    if self.timer >= 1 then
      self.timer = 1
      self.gd = true
    end
  end
end


function LoadingScreen:draw()
  love.graphics.setColor(255,255,255,255*self.timer)
  love.graphics.draw(LoadingScreen.spiral, 500,100)
	self:drawLoadingBar()
end





 function LoadingScreen:drawLoadingBar()
  love.graphics.setColor(255,255,255,255)
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
  love.graphics.setColor(255,100,100,255)
  love.graphics.rectangle("fill", x, y, w, h)
  love.graphics.setColor(255,255,255,255)

end
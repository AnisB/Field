--[[ 
	This file is part of the Field project
]]


LoadingScreen = {}
LoadingScreen.__index =  LoadingScreen


--LoadingScreen.spiral = BasicAnim.new("loading",true, 0.2,8)


function LoadingScreen.new(options)
    local self = {}
    setmetatable(self, LoadingScreen)
    math.randomseed(os.time())

    self.screenWidth, self.screenHeight = love.graphics.getWidth(), love.graphics.getHeight()
    return self
end




function LoadingScreen:update(dt)
  --LoadingScreen.spiral:update(dt)
end


function LoadingScreen:draw()
  love.graphics.setColor(255,255,255,255)
  --love.graphics.draw(LoadingScreen.spiral:getSprite(), 0,0)
	self:drawLoadingBar()
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
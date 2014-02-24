--[[ 
	This file is part of the fieldSolo project
]]


FieldSolo = {}
FieldSolo.__index =  FieldSolo

function FieldSolo.new(type,position)
    local self = {}
    setmetatable(self, FieldSolo)

  --1a. create a blank 32px*32px image data
  id = love.image.newImageData(32, 32)
  --1b. fill that blank image data
  for x = 0, 31 do
  	for y = 0, 31 do
  		local gradient = 1 - ((x-15)^2+(y-15)^2)/40
  		id:setPixel(x, y, 255, 255, 255, 255*(gradient<0 and 0 or gradient))
  	end
  end
  self.isActive=false
  local backimg=nil
  local movimg=nil
  backimg="img/particle/backstat.png"
  movimg="img/particle/movstat.png"  
  self.fieldSoloType=type
  self.movposition={x=0,y=0}
  self.bufferSize=256
  self.EmissionRate=10
  self.lifeTime=0.1
  self.position={x=0,y=0}
  self.Direction=0
  self.Spread=5
  self.speed={x=0,y=00}
  self.spin=0
  self.particleLife=3
  self.radialAcceleration=200
  self.tangentialAcceleration=1
  self.colors={r1=30,g1=30,b1=180,a1=10,r2=30,g2=30,b2=180,a2=10}
  if type == FieldSoloTypes.Static then
    backimg="img/particle/backstat.png"
    movimg="img/particle/movstat.png"
    self.tangentialAcceleration=1
    self.radialAcceleration=50
    self.colors={r1=30,g1=30,b1=180,a1=10,r2=30,g2=30,b2=180,a2=10}
    self.particleLife=3
  elseif type == FieldSoloTypes.Repulsive then
    backimg="img/particle/backrep.png"
    movimg="img/particle/movrep.png"
    self.tangentialAcceleration=1
    self.radialAcceleration=1000
    self.colors={r1=180,g1=30,b1=30,a1=20,r2=180,g2=30,b2=30,a2=20}
    self.particleLife=0.75
  elseif type == FieldSoloTypes.RotativeL then 
    backimg="img/particle/backrotl.png"
    movimg="img/particle/movrotl.png"
    self.tangentialAcceleration=1000
    self.radialAcceleration=10
    self.colors={r1=255,g1=255,b1=30,a1=10,r2=255,g2=255,b2=30,a2=10}
    self.particleLife=1
  elseif type == FieldSoloTypes.RotativeR then
    backimg="img/particle/backrotr.png"
    movimg="img/particle/movrotr.png"
    self.tangentialAcceleration=-1000
    self.radialAcceleration=200
    self.colors={r1=255,g1=150,b1=30,a1=10,r2=255,g2=127,b2=30,a2=10}
    self.particleLife=1
  end         
  i =s_resourceManager:LoadImage(id)
  self.back = love.graphics.newParticleSystem(i, self.bufferSize)
  self.back:setEmissionRate          (self.EmissionRate)
  self.back:setLifetime              (self.lifeTime)
  self.back:setParticleLife          (self.particleLife)
  self.back:setPosition              (self.position.x, self.position.y)
  self.back:setDirection             (self.Direction)
  self.back:setSpread                (self.Spread)
  self.back:setSpeed                 (self.speed.x,self.speed.y)
  self.back:setGravity               (00)
  self.back:setRadialAcceleration    (self.radialAcceleration)
  self.back:setTangentialAcceleration(self.tangentialAcceleration)
  self.back:setSizes                  (1,50, 1)
  self.back:setSizeVariation         (0.5)
  self.back:setRotation              (0)
  self.back:setSpin                  (0)
  self.back:setSpinVariation         (0)
  self.back:setColors                 (self.colors.r1, self.colors.g1, self.colors.b1, self.colors.a1, self.colors.r2, self.colors.g2, self.colors.b2, self.colors.a2)
  self.back:stop();

    --2. create an image from that image data
  i =s_resourceManager:LoadImage(movimg)
  self.fieldSoloType=type
  self.img= i
  self.bufferSize=256
  self.EmissionRate=20
  self.lifeTime=0.1
  self.Direction=0
  self.Spread=3
  self.speed={x=-1,y=1}
  self.mov = love.graphics.newParticleSystem(i, self.bufferSize)
  self.mov:setEmissionRate          (self.EmissionRate)
  self.mov:setLifetime              (self.lifeTime)
  self.mov:setParticleLife          (self.particleLife)
  self.mov:setPosition              (self.movposition.x, self.movposition.y)
  self.mov:setDirection             (self.Direction)
  self.mov:setSpread                (self.Spread)
  self.mov:setSpeed                 (self.speed.x,self.speed.y)
  self.mov:setGravity               (0)
  self.mov:setRadialAcceleration    (self.radialAcceleration)
  self.mov:setTangentialAcceleration(self.tangentialAcceleration)
  self.mov:setSizes                  (2,2,1 )
  self.mov:setSizeVariation         (1)
  self.mov:setRotation              (0)
  self.mov:setSpin                  (self.spin)
  self.mov:setSpinVariation         (0)
  self.mov:setColors                 (255, 255, 255, 255, 255, 255, 255, 255)
  self.mov:stop();

  return self
end

function FieldSolo:activate()
  self.isActive=true

end

function FieldSolo:disable()
  self.isActive=false
end

function FieldSolo:update(dt)
	self.back:update(dt);
  self.mov:update(dt)
	if  self.isActive then
		self.back:start()
    self.mov:start()
	end
end


function FieldSolo:draw(x,y)
  canvas = love.graphics.getShader( )
  love.graphics.setShader()
	love.graphics.draw(self.back, x-unitWorldSize/4,y-unitWorldSize/4)
  love.graphics.draw(self.mov, x-unitWorldSize/4,y-unitWorldSize/4)
  love.graphics.setShader(canvas)

end
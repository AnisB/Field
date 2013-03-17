--[[ 
	This file is part of the field project
]]


AttField = {}
AttField.__index =  AttField

function AttField.new(type,position)
    local self = {}
    setmetatable(self, AttField)

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
  movimg="img/particle/movatt.png"
  self.colors={r1=30,g1=180,b1=30,a1=10,r2=30,g2=180,b2=30,a2=10}


  i =love.graphics.newImage(id)
  self.bufferSize=256
  self.EmissionRate=15
  self.lifeTime=0.1
  self.position={x=0,y=0}
  self.Direction=0
  self.Spread=2
  self.speed={x=0,y=00}
  self.back = love.graphics.newParticleSystem(i, self.bufferSize)
  self.back:setEmissionRate          (self.EmissionRate)
  self.back:setLifetime              (self.lifeTime)
  self.back:setParticleLife          (1)
  self.back:setPosition              (self.position.x, self.position.y)
  self.back:setDirection             (self.Direction)
  self.back:setSpread                (self.Spread)
  self.back:setSpeed                 (self.speed.x,self.speed.y)
  self.back:setGravity               (00)
  self.back:setRadialAcceleration    (100)
  self.back:setTangentialAcceleration(1)
  self.back:setSizes                  (1,50, 1)
  self.back:setSizeVariation         (0.5)
  self.back:setRotation              (0)
  self.back:setSpin                  (0)
  self.back:setSpinVariation         (0)
  self.back:setColors                 (self.colors.r1, self.colors.g1, self.colors.b1, self.colors.a1, self.colors.r2, self.colors.g2, self.colors.b2, self.colors.a2)
  self.back:stop();

  self.img= i
  self.bufferSize=256
  self.EmissionRate=10
  self.lifeTime=0.1
  self.position={x=0,y=0}
  self.Direction=0
  self.Spread=2
  self.speed={x=0,y=00}
  self.radialAcceleration=200
  self.tangentialAcceleration=1
  self.particleLife=1.25
    --2. create an image from that image data
  i =love.graphics.newImage(movimg)
  self.fieldType=type
  self.img= i
  self.bufferSize=256
  self.EmissionRate=15
  self.lifeTime=0.1
  self.Spread=2
  self.speed={x=-1,y=0}
  -- self.particleLife=1
  self.mov1 = love.graphics.newParticleSystem(i, self.bufferSize)
  self.mov1:setEmissionRate          (self.EmissionRate)
  self.mov1:setLifetime              (self.lifeTime)
  self.mov1:setParticleLife          (self.particleLife)
  self.mov1:setPosition              (unitWorldSize*3, 0)
  self.mov1:setDirection             (3)
  self.mov1:setSpread                (self.Spread)
  self.mov1:setSpeed                 (1,0)
  self.mov1:setGravity               (0)
  self.mov1:setRadialAcceleration    (200)
  self.mov1:setTangentialAcceleration(0)
  self.mov1:setSizes                  (1,2,1 )
  self.mov1:setSizeVariation         (0.5)
  self.mov1:setRotation              (0)
  self.mov1:setSpin                  (0)
  self.mov1:setSpinVariation         (0)
  self.mov1:setColors                 (255, 255, 255, 255, 255, 255, 255, 255)
  self.mov1:stop();

    self.mov2 = love.graphics.newParticleSystem(i, self.bufferSize)
  self.mov2:setEmissionRate          (self.EmissionRate)
  self.mov2:setLifetime              (self.lifeTime)
  self.mov2:setParticleLife          (self.particleLife)
  self.mov2:setPosition              (-unitWorldSize*3,0)
  self.mov2:setDirection             (3)
  self.mov2:setSpread                (self.Spread)
  self.mov2:setSpeed                 (-1,0)
  self.mov2:setGravity               (0)
  self.mov2:setRadialAcceleration    (200)
  self.mov2:setTangentialAcceleration(0)
  self.mov2:setSizes                  (1,2,1 )
  self.mov2:setSizeVariation         (0.5)
  self.mov2:setRotation              (0)
  self.mov2:setSpin                  (0)
  self.mov2:setSpinVariation         (0)
  self.mov2:setColors                 (255, 255, 255, 255, 255, 255, 255, 255)
  self.mov2:stop();

    self.mov3 = love.graphics.newParticleSystem(i, self.bufferSize)
  self.mov3:setEmissionRate          (self.EmissionRate)
  self.mov3:setLifetime              (self.lifeTime)
  self.mov3:setParticleLife          (self.particleLife)
  self.mov3:setPosition              (0, unitWorldSize*3)
  self.mov3:setDirection             (5)
  self.mov3:setSpread                (self.Spread)
  self.mov3:setSpeed                 (0,1)
  self.mov3:setGravity               (0)
  self.mov3:setRadialAcceleration    (200)
  self.mov3:setTangentialAcceleration(0)
  self.mov3:setSizes                  (1,2,1 )
  self.mov3:setSizeVariation         (0.5)
  self.mov3:setRotation              (0)
  self.mov3:setSpin                  (0)
  self.mov3:setSpinVariation         (0)
  self.mov3:setColors                 (255, 255, 255, 255, 255, 255, 255, 255)
  self.mov3:stop();

    self.mov4 = love.graphics.newParticleSystem(i, self.bufferSize)
  self.mov4:setEmissionRate          (self.EmissionRate)
  self.mov4:setLifetime              (self.lifeTime)
  self.mov4:setParticleLife          (self.particleLife)
  self.mov4:setPosition              (0,-unitWorldSize*3)
  self.mov4:setDirection             (2)
  self.mov4:setSpread                (1)
  self.mov4:setSpeed                 (0,1)
  self.mov4:setGravity               (0)
  self.mov4:setRadialAcceleration    (200)
  self.mov4:setTangentialAcceleration(0)
  self.mov4:setSizes                  (1,2,1 )
  self.mov4:setSizeVariation         (0.5)
  self.mov4:setRotation              (0)
  self.mov4:setSpin                  (0)
  self.mov4:setSpinVariation         (0)
  self.mov4:setColors                 (255, 255, 255, 255, 255, 255, 255, 255)
  self.mov4:stop();

  return self
end

function AttField:activate()
  self.isActive=true

end

function AttField:disable()
  self.isActive=false
end

function AttField:update(dt)
	self.back:update(dt);
  self.mov1:update(dt)
  self.mov2:update(dt)
  self.mov3:update(dt)
  self.mov4:update(dt)
	if  self.isActive then
		self.back:start()
    self.mov1:start()
    self.mov2:start()
    self.mov3:start()
    self.mov4:start()
	end
end


function AttField:draw(x,y)
	love.graphics.draw(self.back, x,y)
  love.graphics.draw(self.mov1, x,y)
  love.graphics.draw(self.mov2, x,y)
  love.graphics.draw(self.mov3, x,y)
  love.graphics.draw(self.mov4, x,y)
end
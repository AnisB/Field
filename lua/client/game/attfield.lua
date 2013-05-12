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
  self.colors={r1=30,g1=180,b1=30,a1=20,r2=30,g2=180,b2=30,a2=20}


  i =love.graphics.newImage(id)
  self.bufferSize=256
  self.EmissionRate=15
  self.lifeTime=0.1
  self.position={x=0,y=0}
  self.Direction=0
  self.Spread=0.1
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
  self.lifeTime=5
  self.position={x=0,y=0}
  self.Direction=0
  self.Spread=2
  self.speed={x=0,y=00}
  self.radialAcceleration=2000
  self.tangentialAcceleration=1
  self.particleLife=0.4
    --2. create an image from that image data
  i =love.graphics.newImage(movimg)
  self.fieldType=type
  self.img= i
  self.bufferSize=256
  self.EmissionRate=4
  self.lifeTime=0.3
  self.Spread=0.1
  self.speed={x=-1,y=0}
  -- self.particleLife=1
  self.mov1 = love.graphics.newParticleSystem(i, self.bufferSize)
  self.mov1:setEmissionRate          (self.EmissionRate)
  self.mov1:setLifetime              (self.lifeTime)
  self.mov1:setParticleLife          (self.particleLife)
  self.mov1:setPosition              (unitWorldSize*3, 0)
  self.mov1:setDirection             (3.1)
  self.mov1:setSpread                (self.Spread)
  self.mov1:setSpeed                 (1,0)
  self.mov1:setGravity               (0)
  self.mov1:setRadialAcceleration    (self.radialAcceleration)
  self.mov1:setTangentialAcceleration(0)
  self.mov1:setSizes                  (2,2,1 )
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
  self.mov2:setDirection             (3.1)
  self.mov2:setSpread                (self.Spread)
  self.mov2:setSpeed                 (-1,0)
  self.mov2:setGravity               (0)
  self.mov2:setRadialAcceleration    (self.radialAcceleration)
  self.mov2:setTangentialAcceleration(0)
  self.mov2:setSizes                  (1,2,1 )
  self.mov2:setSizeVariation         (0.5)
  self.mov2:setRotation              (1)
  self.mov2:setSpin                  (0)
  self.mov2:setSpinVariation         (0)
  self.mov2:setColors                 (255, 255, 255, 255, 255, 255, 255, 255)
  self.mov2:stop();

  self.mov3 = love.graphics.newParticleSystem(i, self.bufferSize)
  self.mov3:setEmissionRate          (self.EmissionRate)
  self.mov3:setLifetime              (self.lifeTime)
  self.mov3:setParticleLife          (self.particleLife)
  self.mov3:setPosition              (0, unitWorldSize*3)
  self.mov3:setDirection             (4.7)
  self.mov3:setSpread                (self.Spread)
  self.mov3:setSpeed                 (0,1)
  self.mov3:setGravity               (0)
  self.mov3:setRadialAcceleration    (self.radialAcceleration)
  self.mov3:setTangentialAcceleration(0)
  self.mov3:setSizes                  (1,2,1 )
  self.mov3:setSizeVariation         (0.5)
  self.mov3:setRotation              (3.5)
  self.mov3:setSpin                  (0)
  self.mov3:setSpinVariation         (0)
  self.mov3:setColors                 (255, 255, 255, 255, 255, 255, 255, 255)
  self.mov3:stop();

  self.mov4 = love.graphics.newParticleSystem(i, self.bufferSize)
  self.mov4:setEmissionRate          (self.EmissionRate)
  self.mov4:setLifetime              (self.lifeTime)
  self.mov4:setParticleLife          (self.particleLife)
  self.mov4:setPosition              (0 ,-unitWorldSize*3)
  self.mov4:setDirection             (4.7)
  self.mov4:setSpread                (0.1)
  self.mov4:setSpeed                 (0,-1)
  self.mov4:setGravity               (0)
  self.mov4:setRadialAcceleration    (self.radialAcceleration)
  self.mov4:setTangentialAcceleration(0)
  self.mov4:setSizes                  (2,2,1 )
  self.mov4:setSizeVariation         (0.5)
  self.mov4:setRotation              (3.5)
  self.mov4:setSpin                  (0)
  self.mov4:setSpinVariation         (0)
  self.mov4:setColors                 (255, 255, 255, 255, 255, 255, 255, 255)
  self.mov4:stop();

  self.mov5 = love.graphics.newParticleSystem(i, self.bufferSize)
  self.mov5:setEmissionRate          (self.EmissionRate)
  self.mov5:setLifetime              (self.lifeTime)
  self.mov5:setParticleLife          (self.particleLife)
  self.mov5:setPosition              (-unitWorldSize*3*0.64,unitWorldSize*3*0.64)
  self.mov5:setDirection             (5.5)
  self.mov5:setSpread                (0.1)
  self.mov5:setSpeed                 (1,0)
  self.mov5:setGravity               (0)
  self.mov5:setRadialAcceleration    (self.radialAcceleration)
  self.mov5:setTangentialAcceleration(0)
  self.mov5:setSizes                  (2,2,1 )
  self.mov5:setSizeVariation         (0.5)
  self.mov5:setRotation              (0)
  self.mov5:setSpin                  (0)
  self.mov5:setSpinVariation         (0)
  self.mov5:setColors                 (255, 255, 255, 255, 255, 255, 255, 255)
  self.mov5:stop();

  self.mov6 = love.graphics.newParticleSystem(i, self.bufferSize)
  self.mov6:setEmissionRate          (self.EmissionRate)
  self.mov6:setLifetime              (self.lifeTime)
  self.mov6:setParticleLife          (self.particleLife)
  self.mov6:setPosition              (-unitWorldSize*3*0.64,-unitWorldSize*3*0.64)
  self.mov6:setDirection             (1)
  self.mov6:setSpread                (0.1)
  self.mov6:setSpeed                 (0,1)
  self.mov6:setGravity               (0)
  self.mov6:setRadialAcceleration    (self.radialAcceleration)
  self.mov6:setTangentialAcceleration(0)
  self.mov6:setSizes                  (2,2,1 )
  self.mov6:setSizeVariation         (0.5)
  self.mov6:setRotation              (3.5)
  self.mov6:setSpin                  (0)
  self.mov6:setSpinVariation         (0)
  self.mov6:setColors                 (255, 255, 255, 255, 255, 255, 255, 255)
  self.mov6:stop();
      
  self.mov7 = love.graphics.newParticleSystem(i, self.bufferSize)
  self.mov7:setEmissionRate          (self.EmissionRate)
  self.mov7:setLifetime              (self.lifeTime)
  self.mov7:setParticleLife          (self.particleLife)
  self.mov7:setPosition              (unitWorldSize*3*0.64,-unitWorldSize*3*0.64)
  self.mov7:setDirection             (5.5)
  self.mov7:setSpread                (0.1)
  self.mov7:setSpeed                 (-1,0)
  self.mov7:setGravity               (0)
  self.mov7:setRadialAcceleration    (self.radialAcceleration)
  self.mov7:setTangentialAcceleration(0)
  self.mov7:setSizes                  (2,2,1 )
  self.mov7:setSizeVariation         (0.5)
  self.mov7:setRotation              (3.5)
  self.mov7:setSpin                  (0)
  self.mov7:setSpinVariation         (0)
  self.mov7:setColors                 (255, 255, 255, 255, 255, 255, 255, 255)
  self.mov7:stop();
    
  self.mov8 = love.graphics.newParticleSystem(i, self.bufferSize)
  self.mov8:setEmissionRate          (self.EmissionRate)
  self.mov8:setLifetime              (self.lifeTime)
  self.mov8:setParticleLife          (self.particleLife)
  self.mov8:setPosition              (unitWorldSize*3*0.64,unitWorldSize*3*0.64)
  self.mov8:setDirection             (1)
  self.mov8:setSpread                (0.1)
  self.mov8:setSpeed                 (0,-1)
  self.mov8:setGravity               (0)
  self.mov8:setRadialAcceleration    (self.radialAcceleration)
  self.mov8:setTangentialAcceleration(0)
  self.mov8:setSizes                  (2,2,1 )
  self.mov8:setSizeVariation         (0.5)
  self.mov8:setRotation              (3.5)
  self.mov8:setSpin                  (0)
  self.mov8:setSpinVariation         (0)
  self.mov8:setColors                 (255, 255, 255, 255, 255, 255, 255, 255)
  self.mov8:stop();


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

  self.mov5:update(dt)
  self.mov6:update(dt)
  self.mov7:update(dt)
  self.mov8:update(dt)

	if  self.isActive then
		self.back:start()
    self.mov1:start()
    self.mov2:start()
    self.mov3:start()
    self.mov4:start()

    self.mov5:start()
    self.mov6:start()
    self.mov7:start()
    self.mov8:start()
	end
end


function AttField:draw(x,y)
    effect = love.graphics.getPixelEffect( )
  love.graphics.setPixelEffect()

	love.graphics.draw(self.back, x,y)
  love.graphics.draw(self.mov1, x,y)
  love.graphics.draw(self.mov2, x,y)
  love.graphics.draw(self.mov3, x,y)
  love.graphics.draw(self.mov4, x,y)

  love.graphics.draw(self.mov5, x,y)
  love.graphics.draw(self.mov6, x,y)
  love.graphics.draw(self.mov7, x,y)
  love.graphics.draw(self.mov8, x,y)
  love.graphics.setPixelEffect(effect)
end

function AttField:send(x,y)
  if  self.isActive then
    return ("@field".."#".."Attractive".."#".."1".."#"..math.floor(x).."#"..math.floor(y))
  else
    return ("@field".."#".."Attractive".."#".."0".."#"..math.floor(x).."#"..math.floor(y))
  end
end
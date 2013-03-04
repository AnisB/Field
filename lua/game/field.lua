--[[ 
	This file is part of the field project
]]


Field = {}
Field.__index =  Field

function Field.new(img,type,position)
    local self = {}
    setmetatable(self, Field)
      --sorry, too lazy to pick an image, just skip point 1a and 1b when you use an image file
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
  --2. create an image from that image data
  i =love.graphics.newImage(id)
  self.fieldType=type
  self.img= i
  self.bufferSize=256
  self.EmissionRate=20
  self.lifeTime=0.1
  self.position={x=0,y=0}
  self.particleLife=1
  self.Direction=0
  self.Spread=2
  self.speed={x=0,y=00}
  self.radialAcceleration=20
  self.tangentialAcceleration=1
  self.p = love.graphics.newParticleSystem(i, self.bufferSize)
  self.p:setEmissionRate          (self.EmissionRate)
  self.p:setLifetime              (self.lifeTime)
  self.p:setParticleLife          (self.particleLife)
  self.p:setPosition              (self.position.x, self.position.y)
  self.p:setDirection             (self.Direction)
  self.p:setSpread                (self.Spread)
  self.p:setSpeed                 (self.speed.x,self.speed.y)
  self.p:setGravity               (00)
  self.p:setRadialAcceleration    (self.radialAcceleration)
  self.p:setTangentialAcceleration(self.tangentialAcceleration)
  self.p:setSizes                  (1,50, 1)
  self.p:setSizeVariation         (0.5)
  self.p:setRotation              (0)
  self.p:setSpin                  (0)
  self.p:setSpinVariation         (0)
  self.p:setColors                 (200, 100, 100, 20, 200, 90, 90, 20)
  self.p:stop();
  return self
end

function Field:activate()
  self.isActive=true

end

function Field:disable()
  self.isActive=false
end

function Field:update(dt)
	self.p:update(dt);
	if  self.isActive then
    print("lol")
		self.p:start()
	end
end


function Field:draw(x,y)
	love.graphics.draw(self.p, x,y)
end
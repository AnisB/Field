--[[ 
This file is part of the Field project]]


require("game.camera")
require("game.anim")

MagneticCube = {}
MagneticCube.__index = MagneticCube

MetalMTypes={Alu =0.05,Acier =0.1}

function MagneticCube.new(pos,type,material)
	local self = {}
	setmetatable(self, MagneticCube)
	print(pos)
	self.position={x=pos.x,y=pos.y}
	self.pc = Physics.newSphere(self.position.x,self.position.y,unitWorldSize/2,type)
	self.pc.fixture:setUserData(self)
	self.isStatic=type
	self.strenght=5*unitWorldSize
	self.metalType=MetalTypes.Normal
	self.type='MagneticCube'
	self.metalWeight=material
	self.pc.body:setMass(self.metalWeight*unitWorldSize)
	self.gs=self.pc.body:getGravityScale()
	return self
end


function MagneticCube:rotativeLField(pos)
	if not self.isStatic then
		local vx=self.position.x-pos.x
		local vy=self.position.y-pos.y
		local n = math.sqrt(vx*vx+vy*vy)
		local vrx = vx/n
		local vry= vy/n
		self.pc.body:applyLinearImpulse(-vry*self.strenght/5,vrx*self.strenght/5)
	end
end

function MagneticCube:rotativeRField(pos)
	if not self.isStatic then
		local vx=self.position.x-pos.x
		local vy=self.position.y-pos.y
		local n = math.sqrt(vx*vx+vy*vy)
		local vrx = vx/n
		local vry= vy/n
		self.pc.body:applyLinearImpulse(vry*self.strenght/5,-vrx*self.strenght/5)
	end
end

function MagneticCube:attractiveField(pos)
	if not self.isStatic then	
		local vx=self.position.x-pos.x
		local vy=self.position.y-pos.y
		local n = math.sqrt(vx*vx+vy*vy)
		local vrx = vx/n
		local vry= vy/n
		self.pc.body:applyLinearImpulse(vrx*self.strenght,vry*self.strenght)
	end
end


function MagneticCube:repulsiveField(pos)
if not self.isStatic then
	local vx=-self.position.x+pos.x
	local vy=-self.position.y+pos.y
	local n = math.sqrt(vx*vx+vy*vy)
	local vrx = vx/n
	local vry= vy/n
	if(n>(unitWorldSize)) then 
		self.pc.body:applyLinearImpulse(vrx*self.strenght,vry*self.strenght)
	end
end
end

function MagneticCube:setVelocity(x,y)
	self.pc.body:setLinearVelocity(x,y)
end

function MagneticCube:initStaticField()
	self.pc.body:setLinearVelocity(0,0)
	self.isStatic=true
	self.pc.body:setGravityScale(0)
end

function MagneticCube:staticField(magnet)

end

	function MagneticCube:cancelStaticField()
		self.isStatic=false
		self.pc.body:setGravityScale(self.gs)
		self.pc.body:applyLinearImpulse(0, 1)
	end

		function MagneticCube:collideWith( object, collision )
		end

		function MagneticCube:unCollideWith( object, collision )

		end

		function MagneticCube:getPosition(  )
			return self.position
		end


		function MagneticCube:update(seconds,cam)
			x,y =self.pc.body:getPosition()
			self.position.x=x
			self.position.y=y
		end

function MagneticCube:draw(x,y)
	love.graphics.setColor(20,255,175,255)
    love.graphics.circle("fill", self.pc.body:getX()-x, self.pc.body:getY()+y, unitWorldSize/2)
end
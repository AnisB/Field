--[[ 
This file is part of the Field project]]


require("game.camera")

Metal = {}
Metal.__index = Metal

MetalMTypes={Alu =0.05,Acier =0.1}

function Metal.new(pos,shapeType,type,material)
	local self = {}
	setmetatable(self, Metal)
	print(pos)
	self.position={x=pos.x,y=pos.y}
	self.shapeType=shapeType
	if self.shapeType=='sphere' then
		self.pc = Physics.newSphere(self.position.x,self.position.y,unitWorldSize/2,type)
	-- Shape choice
	elseif self.shapeType =='rectangle' then
		decalage={unitWorldSize/2,unitWorldSize/2}
		self.pc = Physics.newRectangle(self.position.x,self.position.y,unitWorldSize,unitWorldSize,type,decalage)
	end
	self.pc.fixture:setUserData(self)
	self.isStatic=type
	self.strenght=5*unitWorldSize
	self.metalType=MetalTypes.Normal
	self.type='Metal'
	self.metalWeight=material
	print(self.pc.body:getMass())
	self.pc.body:setMass(self.metalWeight*unitWorldSize)
	self.gs=self.pc.body:getGravityScale()
	return self
end


function Metal:rotativeLField(pos)
	if not self.isStatic then
		local vx=self.position.x-pos.x+0.01
		local vy=self.position.y-pos.y
		local n = math.sqrt(vx*vx+vy*vy)
		local vrx = vx/n
		local vry= vy/n
		self.pc.body:applyLinearImpulse(-vry*self.strenght/5,vrx*self.strenght/5)
	end
end

function Metal:rotativeRField(pos)
	if not self.isStatic then
		local vx=self.position.x-pos.x+0.01
		local vy=self.position.y-pos.y
		local n = math.sqrt(vx*vx+vy*vy)
		local vrx = vx/n
		local vry= vy/n
		self.pc.body:applyLinearImpulse(vry*self.strenght/5,-vrx*self.strenght/5)
	end
end

function Metal:attractiveField(pos)
	if not self.isStatic then	
		local vx=self.position.x-pos.x+0.01
		local vy=self.position.y-pos.y
		local n = math.sqrt(vx*vx+vy*vy)
		local vrx = vx/n
		local vry= vy/n
		self.pc.body:applyLinearImpulse(vrx*self.strenght,vry*self.strenght)
	end
end


function Metal:repulsiveField(pos)
if not self.isStatic then
	local vx=-self.position.x+pos.x+0.01
	local vy=-self.position.y+pos.y
	local n = math.sqrt(vx*vx+vy*vy)
	local vrx = vx/n
	local vry= vy/n
	if(n>(unitWorldSize)) then 
		self.pc.body:applyLinearImpulse(vrx*self.strenght,vry*self.strenght)
	end
end
end

function Metal:setVelocity(x,y)
	self.pc.body:setLinearVelocity(x,y)
end

function Metal:initStaticField()
	self.pc.body:setLinearVelocity(0,0)
	self.isStatic=true
	self.pc.body:setGravityScale(0)
end

function Metal:staticField(magnet)

end

	function Metal:cancelStaticField()
		self.isStatic=false
		self.pc.body:setGravityScale(self.gs)
		self.pc.body:applyLinearImpulse(0, 1)
	end

		function Metal:collideWith( object, collision )
		end

		function Metal:unCollideWith( object, collision )

		end

		function Metal:getPosition(  )
			return self.position
		end


		function Metal:update(seconds)
			x,y =self.pc.body:getPosition()
			self.position.x=x
			self.position.y=y
		end

function Metal:draw(x,y)
	love.graphics.setColor(20,255,175,255)
      if self.shapeType=='sphere' then
            love.graphics.circle( "fill", self.position.x-x,self.position.y+y,unitWorldSize/2, 1000 )
            elseif self.shapeType =='rectangle' then
                love.graphics.rectangle( "fill", self.position.x-x,self.position.y+y, unitWorldSize, unitWorldSize )
            end
        end
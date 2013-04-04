--[[ 
This file is part of the Field project]]


require("game.camera")
require("game.animbloc")

Metal = {}
Metal.__index = Metal

MetalMTypes={Alu =0.05,Acier =0.1}

function Metal.new(pos,shapeType,typeP,material,typemetal)
	local self = {}
	setmetatable(self, Metal)
	local type =false
	if typeP =="static" then
		type=true
	else
		type = false
	end

	if typemetal =="static" then
		self.metalType=MetalTypes.Static
	else
		self.metalType=MetalTypes.Normal
	end
	self.w=unitWorldSize
	self.h=unitWorldSize
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
	self.type='Metal'
	if material=="aluminium" then
		self.metalWeight=MetalMTypes.Alu
	else
		self.metalWeight=MetalMTypes.Acier

	end
	if typemetal =="static" then
		self.anim = AnimBloc.new('bloc/static')
	else
		if self.metalWeight==MetalMTypes.Alu then
			self.anim = AnimBloc.new('bloc/alu')
			elseif self.metalWeight==MetalMTypes.Acier then
				self.anim = AnimBloc.new('bloc/acier')
			end
		end
		self:loadAnimation("normal",true)		
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
			self.pc.body:applyLinearImpulse(vry*self.strenght/3,-vrx*self.strenght/3)
		end
	end

	function Metal:attractiveField(pos)
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


	function Metal:repulsiveField(pos)
		if not self.isStatic then	
			local vx=self.position.x-pos.x+0.01
			local vy=self.position.y-pos.y
			local n = math.sqrt(vx*vx+vy*vy)
			local vrx = vx/n
			local vry= vy/n
			self.pc.body:applyLinearImpulse(vrx*self.strenght,vry*self.strenght)
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
		self.anim:update(seconds)
		x,y =self.pc.body:getPosition()
		self.position.x=x
		self.position.y=y
	end

	function Metal:loadAnimation(anim, force)
		self.anim:load(anim, force)
	end

	function Metal:draw(x,y)
		love.graphics.setColor(255,255,255,255)
		love.graphics.draw(self.anim:getSprite(), self.position.x-x, self.position.y+y)
	end
	function Metal:send(x,y)
	return ("@metal".."img/img.png".."#"..(self.position.x-x).."#"..(self.position.y+y))
end



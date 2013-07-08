--[[ 
This file is part of the Field project]]


require("game.camera")

MetalSolo = {}
MetalSolo.__index = MetalSolo

MetalSoloMTypes={Alu =0.05,Acier =0.1}

function MetalSolo.new(pos,shapeType,typeP,material,typemetalSolo,netid)
	local self = {}
	setmetatable(self, MetalSolo)


	self.netid=netid
	local type =false
	if typeP =="static" then
		type=true
	else
		type = false
	end

	if typemetalSolo =="static" then
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
	self.strenght=7*unitWorldSize
	self.type='MetalSolo'
	if material=="aluminium" then
		self.metalSoloWeight=MetalSoloMTypes.Alu
	else
		self.metalSoloWeight=MetalSoloMTypes.Acier

	end
	if typemetalSolo =="static" then
		self.anim = AnimBloc.new('bloc/static')
	else
		if self.metalSoloWeight==MetalSoloMTypes.Alu then
			self.anim = AnimBloc.new('bloc/alu')
			elseif self.metalSoloWeight==MetalSoloMTypes.Acier then
				self.anim = AnimBloc.new('bloc/acier')
			end
		end
		self.pc.body:setMass(self.metalSoloWeight*unitWorldSize)
		self.gs=self.pc.body:getGravityScale()
		self.quad  = love.graphics.newQuad(0, 0, 64, 64, 128, 64)

		return self
	end

	function MetalSolo:init()
		self:loadAnimation("normal",true)		
	end

	function MetalSolo:rotativeLField(pos,factor)
		if not self.isStatic then
			local vx=self.position.x-pos.x+0.01
			local vy=self.position.y-pos.y
			local n = math.sqrt(vx*vx+vy*vy)
			local vrx = vx/n
			local vry= vy/n
			self.pc.body:applyLinearImpulse(-vry*self.strenght/3*factor,vrx*self.strenght/3*factor)
		end
	end

	function MetalSolo:rotativeRField(pos,factor)
		if not self.isStatic then
			local vx=self.position.x-pos.x+0.01
			local vy=self.position.y-pos.y
			local n = math.sqrt(vx*vx+vy*vy)
			local vrx = vx/n
			local vry= vy/n
			self.pc.body:applyLinearImpulse(vry*self.strenght/3*factor,-vrx*self.strenght/3*factor)
		end
	end

	function MetalSolo:attractiveField(pos,factor)
		if not self.isStatic then
			local vx=-self.position.x+pos.x+0.01
			local vy=-self.position.y+pos.y
			local n = math.sqrt(vx*vx+vy*vy)
			local vrx = vx/n
			local vry= vy/n
			if(n>(unitWorldSize)) then 
				self.pc.body:applyLinearImpulse(vrx*self.strenght*factor,vry*self.strenght*factor)
			end
		end

	end


	function MetalSolo:repulsiveField(pos,factor)
		if not self.isStatic then	
			local vx=self.position.x-pos.x+0.01
			local vy=self.position.y-pos.y
			local n = math.sqrt(vx*vx+vy*vy)
			local vrx = vx/n
			local vry= vy/n
			self.pc.body:applyLinearImpulse(vrx*self.strenght*factor/2,vry*self.strenght*factor/2)
		end
	end

	function MetalSolo:setVelocity(x,y)
		self.pc.body:setLinearVelocity(x,y)
	end

	function MetalSolo:initStaticField()
		self.pc.body:setLinearVelocity(0,0)
		self.isStatic=true
		self.pc.body:setGravityScale(0)
	end

	function MetalSolo:staticField(magnet)

	end

	function MetalSolo:cancelStaticField()
		self.isStatic=false
		self.pc.body:setGravityScale(self.gs)
		self.pc.body:applyLinearImpulse(0, 1)
	end

	function MetalSolo:collideWith( object, collision )
	end

	function MetalSolo:unCollideWith( object, collision )

	end

	function MetalSolo:getPosition(  )
		return self.position
	end


	function MetalSolo:update(seconds)
		self.anim:update(seconds)
		x,y =self.pc.body:getPosition()
		self.position.x=x
		self.position.y=y
	end

	function MetalSolo:loadAnimation(anim, force)
		self.anim:load(anim, force)
	end

	function MetalSolo:draw(x,y)
		love.graphics.setColor(255,255,255,255)
		love.graphics.drawq(self.anim:getSprite(), self.quad, self.position.x-x, self.position.y+y)
	end


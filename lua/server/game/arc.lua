

require("game.animarc")

Arc = {}
Arc.__index = Arc

TimerArc =1

ArcType={DebutH='DebutH',MillieuH='MillieuH',FinH='FinH',DebutV='DebutV',MillieuV='MillieuV',FinV='FinV'}
function Arc.new(pos,w,h,typeArc,id,enable, netid)
	local self = {}
	setmetatable(self, Arc)

	self.id=tonumber(id)
	self.netid = netid
	self.position={x=pos.x,y=pos.y}
	self.w=w
	self.h=h
	local decalage={w/2,h/2}
	self.pc = Physics.newZone(self.position.x,self.position.y,w,h,decalage)
	self.pc.fixture:setUserData(self)
	self.type='Arc'
	self.arcType=typeArc
	if( self.arcType==ArcType.MillieuV or self.arcType==ArcType.MillieuH ) then
		self.anim = AnimArc.new('arc/arcmid')
	else
		self.anim = AnimArc.new('arc/arcside')
	end
	-- self:loadAnimation("on",true)
	self.isTouched=false
	self.timer=0
	self.diffuse  = love.graphics.newQuad(0, 0, 64, 64, 128, 64)
	if enable == "true" then
		self.enabled = true
		self.anim:load("on")
	else
		self.enabled = false
		self.anim:load("off")
	end

	return self
end

function Arc:loadAnimation(anim, force)
	self.anim:load(anim, force)
end


function Arc:getPosition()
	return self.position
end


function Arc:preSolve(b,coll)
end

function Arc:collideWith( object, collision )
	if self.enabled then
		if object.type=='MetalMan' or object.type =='TheMagnet' then
			self.isTouched=true
			object:die()
			--gameStateManager.state["Gameplay"]:slow(1)
		    -- gameStateManager.state["Gameplay"]:shakeOnX(4,500,0.4)
		    -- gameStateManager.state["Gameplay"]:shakeOnY(4,500,0.4)
		end
	end
end

function Arc:unCollideWith( object, collision )

end
function Arc:activateA( )
	self.enabled = true
	self.anim:load("on",true)
	end

function Arc:disableA( )
	self.enabled = false
	self.anim:load("off",true)
	end
function Arc:update(seconds)
	if self.isTouched then
		self.timer=self.timer+seconds
	end
	self.anim:update(seconds)
	x,y =self.pc.body:getPosition()
	self.position.x=x
	self.position.y=y
	if(self.timer>=TimerArc) then
		self.isTouched=false
		gameStateManager:failed()
	end
end

function Arc:draw(x,y)
	love.graphics.setColor(255,255,255,255)

	if( self.arcType==ArcType.MillieuH or self.arcType==ArcType.DebutH) then
		love.graphics.drawq(self.anim:getSprite(),self.diffuse, self.position.x-x, self.position.y+y)
	elseif (  self.arcType==ArcType.MillieuV or self.arcType==ArcType.DebutV) then
		love.graphics.drawq(self.anim:getSprite(),self.diffuse, self.position.x-x +unitWorldSize, self.position.y+y,math.pi/2)
	elseif (  self.arcType==ArcType.FinV) then
		love.graphics.drawq(self.anim:getSprite(), self.diffuse,self.position.x-x , self.position.y+y+unitWorldSize,-math.pi/2)
	elseif (  self.arcType==ArcType.FinH) then
		love.graphics.drawq(self.anim:getSprite(), self.diffuse,self.position.x-x+unitWorldSize , self.position.y+y,0,-1,1)
	end
end

function Arc:send(x,y)
		return ("@arc".."#"..self.netid.."#"..self.arcType.."#"..self.anim:getImgInfo()[1].."#"..self.anim:getImgInfo()[2].."#"..math.floor(self.position.x-x).."#"..math.floor(self.position.y+y))
end

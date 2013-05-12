

require("game.animarc")

Arc = {}
Arc.__index = Arc

TimerArc =1

ArcType={DebutH='DebutH',MillieuH='MillieuH',FinH='FinH',DebutV='DebutV',MillieuV='MillieuV',FinV='FinV'}
function Arc.new(pos,typeArc,anim,id)
	local self = {}
	setmetatable(self, Arc)
	self.position={x=pos.x,y=pos.y}
	self.type='Arc'
	self.arcType=typeArc
	if( self.arcType==ArcType.MillieuV or self.arcType==ArcType.MillieuH ) then
		self.anim = AnimArc.new('arc/arcmid')
	else
		self.anim = AnimArc.new('arc/arcside')
	end
	self.anim:syncronize(anim,id)
	self.diffuse  = love.graphics.newQuad(0, 0, 64, 64, 128, 64)

	return self
end

function Arc:loadAnimation(anim, force)
	self.anim:load(anim, force)
end


function Arc:getPosition()
	return self.position
end

function Arc:syncronize(pos,anim,id)
	self.position.x=pos.x
	self.position.y=pos.y
	self.drawed=true
	if (self.anim.currentAnim.name~=anim) then
		self.anim:syncronize(anim,id)
	end
end



function Arc:update(seconds)
	self.anim:update(seconds)
end

function Arc:draw()

	if( self.arcType==ArcType.MillieuH or self.arcType==ArcType.DebutH) then
		love.graphics.drawq(self.anim:getSprite(), self.diffuse,self.position.x, self.position.y)
	elseif (  self.arcType==ArcType.MillieuV or self.arcType==ArcType.DebutV) then
		love.graphics.drawq(self.anim:getSprite(), self.diffuse, self.position.x +unitWorldSize, self.position.y,math.pi/2)
	elseif (  self.arcType==ArcType.FinV) then
		love.graphics.drawq(self.anim:getSprite(),self.diffuse, self.position.x , self.position.y+unitWorldSize,-math.pi/2)
	elseif (  self.arcType==ArcType.FinH) then
		love.graphics.drawq(self.anim:getSprite(), self.diffuse,self.position.x+unitWorldSize , self.position.y,0,-1,1)
	end
end


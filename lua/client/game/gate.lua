

require("game.field")
require("game.animgate")

GateTypes={
	DebutHG='DebutHG',MillieuHG='MillieuHG',FinHG='FinHG',
	DebutHD='DebutHD',MillieuHD='MillieuHD',FinHD='FinHD',
	DebutVH='DebutVH',MillieuVH='MillieuVH',FinVH='FinVH',
	DebutVB='DebutVB',MillieuVB='MillieuVB',FinVB='FinVB',
	HAloneG='HAloneG',HAloneD='HAloneD',
	VAloneH='VAloneH',VAloneB='VAloneB'}


Gate = {}
Gate.__index = Gate


function Gate.new(pos,type,anim,id,rot,scale)
	local self = {}
	setmetatable(self, Gate)
	self.position={x=pos.x,y=pos.y}
    -- Type
    self.type='Gate' 
    self.gateType=type
    if( self.gateType==GateTypes.MillieuHG or self.gateType==GateTypes.MillieuHD or self.gateType==GateTypes.MillieuVH or self.gateType==GateTypes.MillieuVB ) then
		self.anim = AnimGate.new('gate/gatemid')
	elseif ( self.gateType==GateTypes.DebutHG or self.gateType==GateTypes.DebutHD or self.gateType==GateTypes.DebutVH or self.gateType==GateTypes.DebutVB ) then
		self.anim = AnimGate.new('gate/gateside')
	elseif ( self.gateType==GateTypes.FinHG or self.gateType==GateTypes.FinHD or self.gateType==GateTypes.FinVH or self.gateType==GateTypes.FinVB ) then
		self.anim = AnimGate.new('gate/gateend')
	elseif ( self.gateType==GateTypes.HAloneG or self.gateType==GateTypes.HAloneD or self.gateType==GateTypes.VAloneH or self.gateType==GateTypes.VAloneB ) then
		self.anim = AnimGate.new('gate/gatealone')
	end
	self.anim:syncronize(anim,id)
	self.rot=rot
	self.scale=scale
	self.drawed=true

    return self
end

-- function Gate:syncronize(pos,anim,id)
function Gate:syncronize(pos,anim,id)
	if (self.anim.currentAnim.name~=anim) then
		self.anim:syncronize(anim,id)
	end        
	self.position.x=pos.x
	self.position.y=pos.y

	self.drawed=true	
end


function Gate:getPosition(  )
	return self.position
end

function Gate:update(seconds)
end

function Gate:draw()
		love.graphics.draw(self.anim:getSprite(), self.position.x, self.position.y,self.rot,self.scale,1)
end
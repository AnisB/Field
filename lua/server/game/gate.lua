

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

RotConst=math.pi/2

function Gate.new(pos,w,h,openID,closeID,prev,next,animid,enabled,type,mapLoader,netid)
	local self = {}
	setmetatable(self, Gate)

	print(type)
	self.animid=animid
	self.netid=netid
	self.openID=openID
	self.closeID=closeID
	self.prev=prev
	self.next=next
	self.mapLoader=mapLoader
	self.position={x=pos.x,y=pos.y}
    -- Type
    self.type='Gate' 
    self.w=w
    self.h=h
    decalage={w/2,h/2}
    self.pc = Physics.newRectangle(self.position.x,self.position.y,w,h,true,decalage)
    self.pc.fixture:setUserData(self)   
    self.gateType=type
    self.isOpening=false
    self.isClosing=false

    if( self.gateType==GateTypes.MillieuHG or self.gateType==GateTypes.MillieuHD or self.gateType==GateTypes.MillieuVH or self.gateType==GateTypes.MillieuVB ) then
		self.anim = AnimGate.new('gate/gatemid')
	elseif ( self.gateType==GateTypes.DebutHG or self.gateType==GateTypes.DebutHD or self.gateType==GateTypes.DebutVH or self.gateType==GateTypes.DebutVB ) then
		self.anim = AnimGate.new('gate/gateside')
	elseif ( self.gateType==GateTypes.FinHG or self.gateType==GateTypes.FinHD or self.gateType==GateTypes.FinVH or self.gateType==GateTypes.FinVB ) then
		self.anim = AnimGate.new('gate/gateend')
	elseif ( self.gateType==GateTypes.HAloneG or self.gateType==GateTypes.HAloneD or self.gateType==GateTypes.VAloneH or self.gateType==GateTypes.VAloneB ) then
		self.anim = AnimGate.new('gate/gatealone')
	end
	
    if enabled then
        self.pc.fixture:setFilterData(1,1,-1)    	
    	self.anim:load("open",true)
    else
    	self.pc.fixture:setFilterData(1,1,0)
    	self.anim:load("close",true)
	end
	return self
end

	function Gate:isAppliable(pos)
		local ax =pos.x-self.position.x
		local ay =pos.y-self.position.y
		if math.abs(math.sqrt(ax*ax+ay*ay))<=self.fieldRadius then
			return true
		else
			return false
		end
	end
	
	function Gate:getPosition()
		return self.position
	end
	

	
	function Gate:collideWith( object, collision )
	end
	
	function Gate:unCollideWith( object, collision )

	end

	function Gate:openG( )
	self.open= true
	self.pc.fixture:setFilterData(1,1,-1)
	Sound.playSound("door")
	self.anim:load("opening",true)
	self.isOpening=true
	end

	function Gate:closeG( )
	self.open= false
    self.isClosing=true
	self.pc.fixture:setFilterData(1,1,0)
	Sound.playSound("door")
	self.anim:load("closing",true)
	end


function Gate:getPosition(  )
	return self.position
end

function Gate:update(seconds)
	self.anim:update(seconds)
	if self.isOpening and self.anim.currentAnim.name=="open" then
		self.isOpening=false
		if self.prev~=nil then
			self.mapLoader:openPG(self.prev)
		end
	end
	if self.isClosing and self.anim.currentAnim.name=="close" then
		self.isClosing=false
		if self.next~=nil then
			self.mapLoader:closeNG(self.next)
		end
	end
	x,y =self.pc.body:getPosition()
	self.position.x=x
	self.position.y=y
end

function Gate:draw(x,y)
	love.graphics.setColor(255,255,255,255)
	-- if self.open==false then
	if( self.gateType==GateTypes.DebutHG or self.gateType==GateTypes.MillieuHG or self.gateType==GateTypes.FinHG or self.gateType==GateTypes.HAloneG  ) then
		love.graphics.draw(self.anim:getSprite(), self.position.x-x, self.position.y+y)

	elseif ( self.gateType==GateTypes.DebutHD or self.gateType==GateTypes.MillieuHD or self.gateType==GateTypes.FinHD or self.gateType==GateTypes.HAloneD )then
		love.graphics.draw(self.anim:getSprite(), self.position.x-x+unitWorldSize, self.position.y+y,0,-1,1)

	elseif ( self.gateType==GateTypes.DebutVH or self.gateType==GateTypes.MillieuVH or self.gateType==GateTypes.FinVH  or self.gateType==GateTypes.VAloneH)then
		love.graphics.draw(self.anim:getSprite(), self.position.x-x+unitWorldSize, self.position.y+y,math.pi/2)

	elseif ( self.gateType==GateTypes.DebutVB or self.gateType==GateTypes.MillieuVB or self.gateType==GateTypes.FinVB or self.gateType==GateTypes.VAloneB )then
		love.graphics.draw(self.anim:getSprite(), self.position.x-x, self.position.y+y+unitWorldSize,-math.pi/2)
	end

end

function Gate:send(x,y)
	if( self.gateType==GateTypes.DebutHG or self.gateType==GateTypes.MillieuHG or self.gateType==GateTypes.FinHG or self.gateType==GateTypes.HAloneG  ) then
		return ("@gate".."#"..self.netid.."#"..self.gateType.."#"..self.anim:getImgInfo()[1].."#"..self.anim:getImgInfo()[2].."#"..math.floor(self.position.x-x).."#"..math.floor(self.position.y+y).."#".."0".."#".."1")
	elseif ( self.gateType==GateTypes.DebutHD or self.gateType==GateTypes.MillieuHD or self.gateType==GateTypes.FinHD or self.gateType==GateTypes.HAloneD )then
		return ("@gate".."#"..self.netid.."#"..self.gateType.."#"..self.anim:getImgInfo()[1].."#"..self.anim:getImgInfo()[2].."#"..math.floor(self.position.x-x+unitWorldSize).."#"..math.floor(self.position.y+y).."#".."0".."#".."-1")
	elseif ( self.gateType==GateTypes.DebutVH or self.gateType==GateTypes.MillieuVH or self.gateType==GateTypes.FinVH  or self.gateType==GateTypes.VAloneH)then
		return ("@gate".."#"..self.netid.."#"..self.gateType.."#"..self.anim:getImgInfo()[1].."#"..self.anim:getImgInfo()[2].."#"..math.floor(self.position.x-x+unitWorldSize).."#"..math.floor(self.position.y+y).."#"..tostring(RotConst).."#".."1")
	elseif ( self.gateType==GateTypes.DebutVB or self.gateType==GateTypes.MillieuVB or self.gateType==GateTypes.FinVB or self.gateType==GateTypes.VAloneB )then
		return ("@gate".."#"..self.netid.."#"..self.gateType.."#"..self.anim:getImgInfo()[1].."#"..self.anim:getImgInfo()[2].."#"..math.floor(self.position.x-x).."#"..math.floor(self.position.y+y+unitWorldSize).."#"..tostring(-RotConst).."#".."1")
	end
end
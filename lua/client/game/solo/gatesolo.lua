

require("game.solo.fieldsolo")
require("game.solo.animgatesolo")

GateSoloTypes={
	DebutHG='DebutHG',MillieuHG='MillieuHG',FinHG='FinHG',
	DebutHD='DebutHD',MillieuHD='MillieuHD',FinHD='FinHD',
	DebutVH='DebutVH',MillieuVH='MillieuVH',FinVH='FinVH',
	DebutVB='DebutVB',MillieuVB='MillieuVB',FinVB='FinVB',
	HAloneG='HAloneG',HAloneD='HAloneD',
	VAloneH='VAloneH',VAloneB='VAloneB'}

GateSolo = {}
GateSolo.__index = GateSolo

RotConst=math.pi/2

function GateSolo.new(pos,w,h,openID,closeID,prev,next,animid,enabled,type,mapLoader,netid)
	local self = {}
	setmetatable(self, GateSolo)

	self.animid=animid
	self.netid=netid
	self.openID=openID
	self.closeID=closeID
	self.prev=prev
	self.next=next
	self.mapLoader=mapLoader
	self.position={x=pos.x,y=pos.y}
    -- Type
    self.type='GateSolo' 
    self.w=w
    self.h=h
    decalage={w/2,h/2}
    self.pc = Physics.newRectangle(self.position.x,self.position.y,w,h,true,decalage)
    self.pc.fixture:setUserData(self)   
    self.gateSoloType=type
    self.isOpening=false
    self.isClosing=false

    if( self.gateSoloType==GateSoloTypes.MillieuHG or self.gateSoloType==GateSoloTypes.MillieuHD or self.gateSoloType==GateSoloTypes.MillieuVH or self.gateSoloType==GateSoloTypes.MillieuVB ) then
		self.anim = AnimGateSolo.new('gate/gatemid')
	elseif ( self.gateSoloType==GateSoloTypes.DebutHG or self.gateSoloType==GateSoloTypes.DebutHD or self.gateSoloType==GateSoloTypes.DebutVH or self.gateSoloType==GateSoloTypes.DebutVB ) then
		self.anim = AnimGateSolo.new('gate/gateside')
	elseif ( self.gateSoloType==GateSoloTypes.FinHG or self.gateSoloType==GateSoloTypes.FinHD or self.gateSoloType==GateSoloTypes.FinVH or self.gateSoloType==GateSoloTypes.FinVB ) then
		self.anim = AnimGateSolo.new('gate/gateend')
	elseif ( self.gateSoloType==GateSoloTypes.HAloneG or self.gateSoloType==GateSoloTypes.HAloneD or self.gateSoloType==GateSoloTypes.VAloneH or self.gateSoloType==GateSoloTypes.VAloneB ) then
		self.anim = AnimGateSolo.new('gate/gatealone')
	end
	
	self.sound={open=Sound.getSound("open"),close=Sound.getSound("close")}
    if enabled then
        self.pc.fixture:setFilterData(1,1,-1)    	
    	self.anim:load("open",true)
    else
    	self.pc.fixture:setFilterData(1,1,0)
    	self.anim:load("close",true)
	end
	self.quad= love.graphics.newQuad(0, 0, unitWorldSize, unitWorldSize, unitWorldSize*2,unitWorldSize)

	return self
end

	function GateSolo:isAppliable(pos)
		local ax =pos.x-self.position.x
		local ay =pos.y-self.position.y
		if math.abs(math.sqrt(ax*ax+ay*ay))<=self.fieldRadius then
			return true
		else
			return false
		end
	end
	
	function GateSolo:getPosition()
		return self.position
	end
	

	
	function GateSolo:collideWith( object, collision )
	end
	
	function GateSolo:unCollideWith( object, collision )

	end

	function GateSolo:openG( )
	self.open= true
	self.pc.fixture:setFilterData(1,1,-1)
	self.anim:load("opening",true)
	self.isOpening=true
	self.sound.open:play()
	end

	function GateSolo:closeG( )
	self.open= false
    self.isClosing=true
	self.pc.fixture:setFilterData(1,1,0)
	self.anim:load("closing",true)
	self.sound.close:play()

	end


function GateSolo:getPosition(  )
	return self.position
end

function GateSolo:update(seconds)
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

function GateSolo:draw(x,y)
	love.graphics.setColor(255,255,255,255)
	-- if self.open==false then
	if( self.gateSoloType==GateSoloTypes.DebutHG or self.gateSoloType==GateSoloTypes.MillieuHG or self.gateSoloType==GateSoloTypes.FinHG or self.gateSoloType==GateSoloTypes.HAloneG  ) then
		love.graphics.drawq(self.anim:getSprite(), self.quad,self.position.x-x, self.position.y+y)

	elseif ( self.gateSoloType==GateSoloTypes.DebutHD or self.gateSoloType==GateSoloTypes.MillieuHD or self.gateSoloType==GateSoloTypes.FinHD or self.gateSoloType==GateSoloTypes.HAloneD )then
		love.graphics.drawq(self.anim:getSprite(), self.quad,self.position.x-x+unitWorldSize, self.position.y+y,0,-1,1)

	elseif ( self.gateSoloType==GateSoloTypes.DebutVH or self.gateSoloType==GateSoloTypes.MillieuVH or self.gateSoloType==GateSoloTypes.FinVH  or self.gateSoloType==GateSoloTypes.VAloneH)then
		love.graphics.drawq(self.anim:getSprite(),self.quad, self.position.x-x+unitWorldSize, self.position.y+y,math.pi/2)

	elseif ( self.gateSoloType==GateSoloTypes.DebutVB or self.gateSoloType==GateSoloTypes.MillieuVB or self.gateSoloType==GateSoloTypes.FinVB or self.gateSoloType==GateSoloTypes.VAloneB )then
		love.graphics.drawq(self.anim:getSprite(),self.quad, self.position.x-x, self.position.y+y+unitWorldSize,-math.pi/2)
	end

end
--[[ 
This file is part of the Field project
]]

-- Includes
require("game.camera")
require("game.animtm")
require("game.field")
require("game.attfield")
require("game.themagnetconst")
-- Class Init
TheMagnet = {}
TheMagnet.__index = TheMagnet

FieldTypes ={None='None',Static='Static', RotativeL ='RotativeL', RotativeR='RotativeR', Repulsive='Repulsive', Attractive='Attractive'}

-- Constructor
function TheMagnet.new(camera,pos)

	-- Class init
	local self = {}
	setmetatable(self, TheMagnet)

	-- Posiiton Init
	self.position={x=0,y=0}

	-- State and animation init
	self:setState("standing")
	self.anim = AnimTM.new('themagnet')
	self:loadAnimation("standing",true)

	self.goF=true

	-- Object's type
	self.type='TheMagnet'

	-- Field init

		-- Particle field managing
		self.field= Field.new(FieldTypes.Static,pos)
		self.field.isActive=false

	    -- Other field attributes
	    self.appliesField=false
	    self.fieldType=FieldTypes.None

	    -- Static Field attributes
	    self.statMetals={}

	    -- Sound
	    self.fieldSound=Sound.getSound("field")


	    self.alive=true

	    return self
	end


-- This methods handles the object's state change
function TheMagnet:setState( state )
	self.currentState=state
end

-- This methods handles the object's state change
function TheMagnet:handlePacket( string )
	t={}
	for v in string.gmatch(string, "[^#]+") do
		table.insert(t,v)
	end

	self.anim:syncronize(t[2],tonumber(t[3]))
	self.position.x=tonumber(t[4])
	self.position.y=tonumber(t[5])
	if t[6]=="1" then
		self.goF=true
	else
		self.goF=false
	end

	if not self.appliesField and t[7]=="true" then
		self.fieldType=t[8]
		self.appliesField=true
		if t[8]~="Attractive" then
			self.field= Field.new(t[8])
		else
			self.field= AttField.new(t[8])
		end
		self.field.isActive=true
	elseif self.appliesField and t[7]=="false" then
		self.fieldType="None"
		self.appliesField=false
		self.field= Field.new(t[8])
		self.field.isActive=true
	elseif 	self.appliesField and t[7]=="true" then
		if self.fieldType==t[8] then
		else
			if t[8]~="Attractive" then
				self.field= Field.new(t[8])
			else
				self.field= AttField.new(t[8])
			end			
		end
	end
end


-- Method that loads an animation
function TheMagnet:loadAnimation(anim, force)
	self.anim:load(anim, force)
end


-- Method that updates the character state
function TheMagnet:update(seconds)
	self.anim:update(seconds)
	self.field:update(seconds,self.position.x,self.position.y)

end



function TheMagnet:draw()
	-- Draws the field
	self.field:draw(self.position.x+unitWorldSize*1/2,self.position.y+unitWorldSize*1/2)
	if 	 self.goF then
		love.graphics.draw(self.anim:getSprite(), self.position.x,self.position.y, 0, 1,1)
	else
		love.graphics.draw(self.anim:getSprite(), windowW/2+unitWorldSize/2,windowH/2-unitWorldSize/2,0 , -1,1)
	end
end

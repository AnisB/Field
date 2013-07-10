--[[ 
This file is part of the Field project
]]

-- Includes
require("game.camera")
require("game.animtm")
require("game.field")
require("game.attfield")
require("game.themagnetconst")
require("game.fieldsound")
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
	self.soundPlaying=nil

	self.alive=true
	self.diffuse  = love.graphics.newQuad(0, 0, 64, 64, 128, 64)
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

	if (self.anim.currentAnim.name~=t[2]) then
		self.anim:syncronize(t[2],tonumber(t[3]))
	end
	self.position.x=tonumber(t[4])
	self.position.y=tonumber(t[5])
	if t[6]=="1" then
		self.goF=true
	else
		self.goF=false
	end
	if not self.appliesField and t[7]=="true" then
		--lancement du champ
		self.soundPlaying = FieldSound.new(t[8])
		self.soundPlaying:play()
		self.fieldType=t[8]
		self.appliesField=true
		if t[8]~="Attractive" then
			self.field= Field.new(t[8])
		else
			self.field= AttField.new(t[8])
		end
		self.field.isActive=true
	elseif self.appliesField and t[7]=="false" then
		-- fermeture de champ, on fadeout les sons lancés
		self.soundPlaying:stop()
		-- self.fieldType="None"
		self.appliesField=false
		self.field.isActive=false
	elseif 	self.appliesField and t[7]=="true" then				
		if self.fieldType==t[8] then
		else
			self.fieldType=t[8]
			-- mauvais champ lancé donc nouveau champ lancé
			self.soundPlaying:immediateStop()
			self.soundPlaying=nil
			self.soundPlaying = FieldSound.new(t[8])
			self.soundPlaying:play()
			if t[8]~="Attractive" then
				self.field= Field.new(t[8])
			else
				self.field= AttField.new(t[8])
			end			
			print "Activating"
			self.field.isActive=true
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
	self.field:update(seconds)
	if self.soundPlaying then
		self.soundPlaying:setPosition(self.position)
		self.soundPlaying:update(seconds)
		if self.soundPlaying:done() then
			self.soundPlaying=nil
		end
	end
end

function TheMagnet:destroy()
	if self.soundPlaying ~=nil then
		self.soundPlaying:destroy()
		self.soundPlaying = nil
	end

	self.anim = nil
	self.field:destroy()
	self.field = nil
end


function TheMagnet:draw()
	-- Draws the field
	if 	 self.goF then
		if self.fieldType=="Attractive" then
			self.field:draw(self.position.x+unitWorldSize/2,self.position.y+unitWorldSize/2)
		else
			self.field:draw(self.position.x+unitWorldSize*0.75,self.position.y+unitWorldSize*0.75)
		end
		love.graphics.drawq(self.anim:getSprite(), self.diffuse, self.position.x,self.position.y, 0, 1,1)
	else
		if self.fieldType=="Attractive" then
			self.field:draw(self.position.x-unitWorldSize*0.25,self.position.y+unitWorldSize/2)
		else
			self.field:draw(self.position.x,self.position.y+unitWorldSize*0.75)
		end
		love.graphics.drawq(self.anim:getSprite(),self.diffuse, self.position.x,self.position.y, 0, -1,1)		
	end
end

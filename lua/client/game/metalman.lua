--[[ 
This file is part of the Field project]]


require("game.camera")
require("game.animmm")
require("game.metalmanconst")
require ("game.shader.shockwave")

MetalMan = {}
MetalMan.__index = MetalMan

function MetalMan.new()
	local self = {}
	setmetatable(self, MetalMan)


	-- The position initiate
	self.position={x=0,y=0}

	-- Animation state
	self.anim = AnimMM.new('metalman/alu')
	self:loadAnimation("standing",true)
	self.goF=true

	-- Other states
	self.type='MetalMan'
	self.s= ShockwaveEffect.new()
	self.s:setParameter{
		center = {0.5,0.5},
		shockParams = {20,0.8,0.1},
	}
	self.s.time=10
	self.diffuse  = love.graphics.newQuad(0, 0, 64, 64, 128, 64)
	return self
end

function MetalMan:reset()
end

-- This methods handles the object's state change
function MetalMan:handlePacket( string )
	t={}
	for v in string.gmatch(string, "[^#]+") do
		table.insert(t,v)
	end
	if self.anim.folder~=t[2] then
		self.anim = AnimMM.new(t[2])
		self.s.time=0
	end
	if (self.anim.currentAnim.name~=t[3]) then
		self.anim:syncronize(t[3],tonumber(t[4]))
	end
	self.position.x=tonumber(t[5])
	self.position.y=tonumber(t[6])
	self.s:setParameter{
		center = {self.position.x/windowW,(self.position.y+unitWorldSize)/windowH}
	}
	if t[7]=="1" then
		self.goF=true
	else
		self.goF=false
	end
end



function MetalMan:loadAnimation(anim, force)
		self.anim:load(anim, force)
end

function MetalMan:update(seconds)
	self.anim:update(seconds)
	self.s:update(seconds)
end

function MetalMan:preDraw()

		-- love.graphics.setCanvas( canvas )
		self.s:predraw()
		-- love.graphics.setCanvas(  )
		-- love.graphics.draw(canvas, 0,0, 0, 1,1)

end

function MetalMan:postDraw()

		-- love.graphics.setCanvas( canvas )
		self.s:postdraw()
		-- love.graphics.setCanvas(  )
		-- love.graphics.draw(canvas, 0,0, 0, 1,1)

end
function MetalMan:draw()

		self.s:postdraw()
    	if 	self.goF then
    		love.graphics.drawq(self.anim:getSprite(), self.diffuse,self.position.x,self.position.y, 0, 1,1)
    	else
    		love.graphics.drawq(self.anim:getSprite(), self.diffuse,self.position.x,self.position.y,0 , -1,1)
    	end
end
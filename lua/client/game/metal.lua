--[[ 
This file is part of the Field project]]


require("game.camera")
require("game.animbloc")

Metal = {}
Metal.__index = Metal


function Metal.new(pos,typemetal,anim,id)
	local self = {}
	setmetatable(self, Metal)

	self.position={x=pos.x,y=pos.y}
	self.drawed=true
	if typemetal =="static" then
		self.anim = AnimBloc.new('bloc/static')
	else
		if typemetal =="aluminium" then
			self.anim = AnimBloc.new('bloc/alu')
			elseif typemetal =="acier" then
				self.anim = AnimBloc.new('bloc/acier')
			end

		end
		self.anim:syncronize(anim,id)
        self.diffuse  = love.graphics.newQuad(0, 0, 64, 64, 128, 64)

		return self
	end

	function Metal:syncronize(pos,anim,id)
		if (self.anim.currentAnim.name~=anim) then
			self.anim:syncronize(anim,id)
		end
		self.position.x=pos.x
		self.position.y=pos.y
		self.drawed=true
	end

	function Metal:getPosition(  )
		return self.position
	end


	function Metal:update(seconds)
		self.anim:update(seconds)
	end

	function Metal:loadAnimation(anim, force)
		self.anim:load(anim, force)
	end

	function Metal:draw()

		love.graphics.drawq(self.anim:getSprite(), self.diffuse,self.position.x, self.position.y)
	end




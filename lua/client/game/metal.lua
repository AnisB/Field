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

	if typemetal =="static" then
		self.anim = AnimBloc.new('bloc/static')
	else
		if typemetal =="aluminium" then
			self.anim = AnimBloc.new('bloc/alu')
			elseif typemetal =="acier" then
				self.anim = AnimBloc.new('bloc/acier')
			end

		end
		--self:loadAnimation("normal",true)	
		print(anim..id)
		self.anim:syncronize(anim,id)	
		return self
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
		love.graphics.draw(self.anim:getSprite(), self.position.x, self.position.y)
	end




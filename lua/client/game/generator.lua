

require("game.field")
require("game.attfield")
require("game.animgene")


Generator = {}
Generator.__index = Generator


function Generator.new(pos,typeField,anim,id)
	local self = {}
	setmetatable(self, Generator)
	self.position={x=pos.x,y=pos.y}
	self.type='Generator'

	if typeField=="Repulsive" then
		self.typeField=FieldTypes.Repulsive
		elseif typeField=="Attractive" then
			self.typeField=FieldTypes.Attractive
			elseif typeField=="RotativeR" then
				self.typeField=FieldTypes.RotativeR
				elseif typeField=="RotativeL" then
					self.typeField=FieldTypes.RotativeL
				end

				self.appliesField=false
				if self.typeField==FieldTypes.Attractive then
					self.field=AttField.new({x=0,y=0})
				else
					self.field=Field.new(self.typeField,{x=0,y=0})
				end
				self.anim = AnimGene.new('gene')
				self:loadAnimation("off",true)
				self.anim:syncronize(anim,id)
				self.drawed=true
				return self
			end


			function Generator:getPosition()
				return self.position
			end

			function Generator:syncronize(pos,typeField,anim,id,applies)
				self.drawed=true

				if (self.anim.currentAnim.name~=anim) then
					self.anim:syncronize(anim,id)
				end
				self.position.x=pos.x
				self.position.y=pos.y
				if not self.appliesField and applies=="true" then
					self.appliesField=true
					self.field.isActive=true
					elseif self.appliesField and applies=="false" then
						self.appliesField=false
						self.field.isActive=false
					end
				end


				function Generator:getPosition(  )
					return self.position
				end

				function Generator:update(seconds)
					self.field:update(seconds)
					self.anim:update(seconds)

				end


				function Generator:loadAnimation(anim, force)
					self.anim:load(anim, force)
				end

				function Generator:draw(x,y)
					if self.typeField =="Attractive" then
						self.field:draw(self.position.x+unitWorldSize/2,self.position.y+unitWorldSize/2)
					else
						self.field:draw(self.position.x+unitWorldSize/2,self.position.y+unitWorldSize/2)
					end
					love.graphics.setColor(255,255,255,255)
					love.graphics.draw(self.anim:getSprite(), self.position.x-unitWorldSize/2, self.position.y-unitWorldSize/2)
				end

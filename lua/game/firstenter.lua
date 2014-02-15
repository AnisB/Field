--[[ 
This file is part of the Field project]]
-- require("game.sound")
require("render.basicanim")

FirstEnter = {}
FirstEnter.__index = FirstEnter
function FirstEnter:new()
    local self = {}
    setmetatable(self, FirstEnter)
    self.timer=0
    self.logo = BasicAnim.new("logo", true,0.15,8)

    self.shouldPass=false
    self.passTimer=1

    -- self.inputManager = MenuInputManager.new(self)
    return self
end


function FirstEnter:mousePressed(x, y, button)
end

function FirstEnter:mouseReleased(x, y, button)
end


function FirstEnter:keyPressed(key, player)
	if(key == InputType.START) then
		s_gameStateManager:changeState('Menu')
	end
end
function FirstEnter:keyReleased(key, player)
end

function FirstEnter:update(dt)
	self.logo:update(dt)
    self.timer= self.timer+dt

	-- if self.shouldPass then
	-- 	self.passTimer= self.passTimer - dt
	-- 	if self.passTimer<=0 then
	-- 		-- gameStateManager:resetAndChangeState('Menu')
	-- 	end
	-- end
end

function FirstEnter:draw(filter)
	love.graphics.setColor(255,150,150,255*math.abs(math.cos(self.timer))*filter)
	love.graphics.print("Press Start",500,500)
	love.graphics.setColor(255,255,255,255*self.passTimer*filter)
	love.graphics.draw(self.logo:getSprite(),400,100)
end


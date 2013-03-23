--[[ 
This file is part of the Field project]]


FirstEnter = {}
FirstEnter.__index = FirstEnter
function FirstEnter:new()
    local self = {}
    setmetatable(self, FirstEnter)
    self.timer=1
    return self
end


function FirstEnter:mousePressed(x, y, button)
end

function FirstEnter:mouseReleased(x, y, button)
end


function FirstEnter:keyPressed(key, unicode)
end

function FirstEnter:keyReleased(key, unicode)
end


function FirstEnter:update(dt)
	self.timer= self.timer-dt
	if self.timer<=0 then
		gameStateManager:changeState('ConnectToServer')
	end
	
end

function FirstEnter:draw()

end


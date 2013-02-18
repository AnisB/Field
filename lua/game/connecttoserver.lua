--[[ 
This file is part of the Field project]]


ConnectToServer = {}
ConnectToServer.__index = ConnectToServer
function ConnectToServer:new()
    local self = {}
    setmetatable(self, ConnectToServer)
    self.timer=1
    return self
end


function ConnectToServer:mousePressed(x, y, button)
end

function ConnectToServer:mouseReleased(x, y, button)
end


function ConnectToServer:keyPressed(key, unicode)
end

function ConnectToServer:keyReleased(key, unicode)
end


function ConnectToServer:update(dt)
	self.timer= self.timer-dt
	if self.timer<=0 then
		gameState:changeState('WaitingForDistant')
	end
	
end

function ConnectToServer:draw()

end


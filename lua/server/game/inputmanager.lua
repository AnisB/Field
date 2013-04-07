--[[ 
This file is part of the Field project]]

InputManager = {}
InputManager.__index =  InputManager

function InputManager.new()
    local self = {}
	setmetatable(self, InputManager)
	
	--init
	
	self.listKeys = {}
	
	return self
end

function InputManager:handlePacket(pck)
	print("J'ai recu qq chose"..pck.key)
	if pck.key~=nil then
		if pck.state~=nil then
			if(pck.state==true) then
				print("Pressed"..pck.key)
				love.event.push('keypressed', pck.key)
				self.listKeys[pck.key]=true
			else
				print("Released"..pck.key)
				love.event.push('keyreleased', pck.key)
				self.listKeys[pck.key]=nil
			end
		end
	end
end

function InputManager:isKeyDown(key)
	local ok=false
	if self.listKeys[key]~=nil then
		ok=true
	end
	return ok
end
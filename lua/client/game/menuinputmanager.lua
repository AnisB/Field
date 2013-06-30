--[[ 
This file is part of the Field project]]

--les touches telles qu'elles doivent être envoyées au serveur
-- MetalManKEYSSolo={up="z",down="s",left="q",right="d",changeweight="b",changestatic="n", interact="e"}
-- TheMagnetKEYSSolo={up="up",down="down",left="left",right="right",repulsive="p",attractive="o",rotativel="k",rotativer="l",static="i", interact="e"}

KeyMap={up="up",down="down",left="left",right="right",start="return",back="escape",cross="return"}


MenuInputManager = {}
MenuInputManager.__index = MenuInputManager
function MenuInputManager.new(callBackState)
  local self = {}
  setmetatable(self, MenuInputManager)
  self.keys=require("other.menukeys")
  self.joystickKeyPressed = {"released", "released", "released", "released"}
  self.joystickHat = {"up", "down", "left", "right"}
  self.perso = perso
  self.callBackState = callBackState
  self.listKeys = {}
  return self
end

function MenuInputManager:keyPressed(akey, unicode,shouldSend)
	sent = false
	for i,v in pairs(self.keys.KeyMap) do
		if(v==akey) then
			self.listKeys[akey] = true
			self.callBackState:sendPressedKey(KeyMap[i])
			sent = true
		end
	end
	if shouldSend then
	    if not sent then
	    	self.callBackState:sendPressedKey(akey)
	    end
	end
  end

  function MenuInputManager:keyReleased(akey, unicode)
	for i,v in pairs(self.keys.KeyMap) do
		if(v==akey) then
			self.listKeys[akey] = nil
		end
	end
  end
  
function MenuInputManager:joystickPressed(joystick, button)
	for i,v in pairs(self.keys.JoystickKeyMap) do
		if(v==button) then
			self.listKeys[button] = true
			self.callBackState:sendPressedKey(KeyMap[i])
		end
	end
end

function MenuInputManager:joystickReleased(joystick, button)
	for i,v in pairs(self.keys.JoystickKeyMap) do
		if(v==button) then
			self.listKeys[button] = nil
		end
	end
end

function MenuInputManager:update()
	direction = love.joystick.getHat(1, 1)
	
	local newJoystickKeyPressed = {"released", "released", "released", "released"}
	
	if direction ~= "c" then
		if direction=="d" then
			newJoystickKeyPressed  = {"released", "pressed", "released", "released"}
		elseif direction == "l" then
			newJoystickKeyPressed  = {"released", "released", "pressed", "released"}
		elseif direction =="ld" then
			newJoystickKeyPressed  = {"released", "pressed", "pressed", "released"}
		elseif direction == "u" then
			newJoystickKeyPressed  = {"pressed", "released", "released", "released"}
		elseif direction == "lu" then
			newJoystickKeyPressed  = {"pressed", "released", "pressed", "released"}
		elseif direction == "r" then
			newJoystickKeyPressed  = {"released", "released", "released", "pressed"}
		elseif direction == "ru" then
			newJoystickKeyPressed  = {"pressed", "released", "released", "pressed"}
		elseif direction == "rd" then
			newJoystickKeyPressed  = {"released", "pressed", "released", "pressed"}
		end
	end
		if gameFocus then
			for i,v in pairs(newJoystickKeyPressed) do
		        --print("new : "..newJoystickKeyPressed[i].." | old : "..self.joystickKeyPressed[i])
		        if newJoystickKeyPressed[i]=="released" and self.joystickKeyPressed[i]=="pressed" then
		        	self:joystickReleased(1, self.joystickHat[i])
	        	elseif newJoystickKeyPressed[i]=="pressed" and self.joystickKeyPressed[i]=="released" then
	        		self:joystickPressed(1, self.joystickHat[i])
	        	end
	        	self.joystickKeyPressed[i]=newJoystickKeyPressed[i]
	        end
	    end
	
end


function MenuInputManager:isKeyDown(key)
	local ok=false
	if self.listKeys[key]~=nil then
		ok=true
	end
	return ok
end

--[[ 
This file is part of the Field project]]

--les touches telles qu'elles doivent être envoyées au serveur
-- MetalManKEYSSolo={up="z",down="s",left="q",right="d",changeweight="b",changestatic="n", interact="e"}
-- TheMagnetKEYSSolo={up="up",down="down",left="left",right="right",repulsive="p",attractive="o",rotativel="k",rotativer="l",static="i", interact="e"}

MetalManKEYSSolo={hands="e", jump="up",up="up",down="down",left="left",right="right",changeweight="b",changestatic="n", pause ="escape", start ="return"}
TheMagnetKEYSSolo={hands="f", jump="up",up="up",down="down",left="left",right="right",repulsive="p",attractive="o",rotativel="k",rotativer="l",static="i", pause ="escape", start ="return" }


SoloInputManager = {}
SoloInputManager.__index = SoloInputManager
function SoloInputManager.new(perso, callBackState)
  local self = {}
  setmetatable(self, SoloInputManager)
  self.keys=require("other.keys")
  self.joystickKeyPressed = {"released", "released", "released", "released"}
  self.joystickHat = {"up", "down", "left", "right"}
  self.perso = perso
  self.callBackState = callBackState
  self.listKeys = {}
  return self
end

function SoloInputManager:keyPressed(akey, unicode)
  if(self.perso=="metalman") then 
    for i,v in pairs(self.keys.MetalManKEYS) do
      if(v==akey) then
      	self.listKeys[akey] = true
        self.callBackState:sendPressedKey(MetalManKEYSSolo[i])
      end
    end
    return
    elseif (self.perso=="themagnet")then
      for i,v in pairs(self.keys.TheMagnetKEYS) do
        if(v==akey) then
        	self.listKeys[akey] = true
        	self.callBackState:sendPressedKey(TheMagnetKEYSSolo[i])
        end
      end
    end
  end

  function SoloInputManager:keyReleased(akey, unicode)
  if(self.perso=="metalman") then 
    for i,v in pairs(self.keys.MetalManKEYS) do
      if(v==akey) then
        	self.listKeys[akey] = nil
        self.callBackState:sendReleasedKey(MetalManKEYSSolo[i])
      end
    end
    return
    elseif (self.perso=="themagnet")then
      for i,v in pairs(self.keys.TheMagnetKEYS) do
        if(v==akey) then
        	self.listKeys[akey] = nil
        	self.callBackState:sendReleasedKey(TheMagnetKEYSSolo[i])
        end
      end
    end
  end
  
function SoloInputManager:joystickPressed(joystick, button)
	if not gamePaused then
		if(self.perso=="metalman") then 
		for i,v in pairs(self.keys.MetalManJoystickKEYS) do
		  if(v==button) then
		  	self.listKeys[button] = true
		  	print(i)
			self.callBackState:sendPressedKey(MetalManKEYSSolo[i])
		  end
		end
		return
		elseif (self.perso=="themagnet")then
		  for i,v in pairs(self.keys.TheMagnetJoystickKEYS) do
			if(v==button) then
				self.listKeys[button] = true
				print("BLAH"..i)
				print("BLOH"..TheMagnetKEYSSolo[i])
				self.callBackState:sendPressedKey(TheMagnetKEYSSolo[i])
			end
		  end
		end
	end
end

function SoloInputManager:joystickReleased(joystick, button)
	if not gamePaused then
		if(self.perso=="metalman") then 
		for i,v in pairs(self.keys.MetalManJoystickKEYS) do
		  if(v==button) then
		  	self.listKeys[button] = nil
		  	self.callBackState:sendReleasedKey(MetalManKEYSSolo[i])
		  end
		end
		return
		elseif (self.perso=="themagnet")then
		  for i,v in pairs(self.keys.TheMagnetJoystickKEYS) do
			if(v==button) then
				self.listKeys[button] = nil
				self.callBackState:sendReleasedKey(TheMagnetKEYSSolo[i])
			end
		  end
		end
	end
end

function SoloInputManager:update()
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
		
		if(gameFocus) then
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

function SoloInputManager:clearInputs()
	self.listKeys =nil
	self.listKeys ={}
end
function SoloInputManager:isKeyDown(key)
	local ok=false
	if self.listKeys[key]~=nil then
		ok=true
	end
	return ok
end

--[[ 
This file is part of the Field project]]

--les touches telles qu'elles doivent être envoyées au serveur
-- MetalManKEYS={up="z",down="s",left="q",right="d",changeweight="b",changestatic="n", interact="e"}
-- TheMagnetKEYS={up="up",down="down",left="left",right="right",repulsive="p",attractive="o",rotativel="k",rotativer="l",static="i", interact="e"}

MetalManKEYS={hands="e", up="z",down="s",left="q",right="d",changeweight="b",changestatic="n"}
TheMagnetKEYS={hands="f", up="up",down="down",left="left",right="right",repulsive="p",attractive="o",rotativel="k",rotativer="l",static="i"}


InputManagerSolo = {}
InputManagerSolo.__index = InputManagerSolo
function InputManagerSolo.new()
  local self = {}
  setmetatable(self, InputManagerSolo)
  self.keys=require("other.keys")
  self.joystickKeyPressed = {"released", "released", "released", "released"}
  self.joystickHat = {"up", "down", "left", "right"}
  return self
end

function InputManagerSolo:keyPressed(akey, unicode)
  if(monde.moi.perso=="metalman") then 
    for i,v in pairs(self.keys.MetalManKEYS) do
      if(v==akey) then
        -- gameStateManager.state['GamePlay']:Input(akey)
      end
    end
    return
    elseif (monde.moi.perso=="themagnet")then
      for i,v in pairs(self.keys.TheMagnetKEYS) do
        if(v==akey) then
          serveur:send({type="input", pck={character="themagnet", key=TheMagnetKEYS[i], state=true}})
        end
      end
    end
  end

  function InputManagerSolo:keyReleased(akey, unicode)
  print("J'ai un input à handler"..akey)
  if(monde.moi.perso=="metalman") then 
    print("C'est un metalman, recherche de la clé")

    for i,v in pairs(self.keys.MetalManKEYS) do
      if(v==akey) then
        print("Trouvée"..i.."#"..v.."Envoyé"..MetalManKEYS[i])
        serveur:send({type="input", pck={character="metalman", key=MetalManKEYS[i], state=false}})
      end
    end
    print("Pas trouvée"..akey)
    return
    elseif (monde.moi.perso=="themagnet")then
      for i,v in pairs(self.keys.TheMagnetKEYS) do
        if(v==akey) then
          serveur:send({type="input", pck={character="themagnet", key=TheMagnetKEYS[i], state=false}})
        end
      end
    end
  end
  
function InputManagerSolo:joystickPressed(joystick, button)
	if not gamePaused then
		if(monde.moi.perso=="metalman") then 
		for i,v in pairs(self.keys.MetalManJoystickKEYS) do
		  if(v==button) then
			serveur:send({type="input", pck={character="metalman", key=MetalManKEYS[i], state=true}})
		  end
		end
		return
		elseif (monde.moi.perso=="themagnet")then
		  for i,v in pairs(self.keys.TheMagnetJoystickKEYS) do
			if(v==button) then
			  serveur:send({type="input", pck={character="themagnet", key=TheMagnetKEYS[i], state=true}})
			end
		  end
		end
	end
end

function InputManagerSolo:joystickReleased(joystick, button)
	if not gamePaused then
		if(monde.moi.perso=="metalman") then 
		print("C'est un metalman, recherche de la clé")

		for i,v in pairs(self.keys.MetalManJoystickKEYS) do
		  if(v==button) then
			print("Trouvée"..i.."#"..v.."Envoyé"..MetalManKEYS[i])
			serveur:send({type="input", pck={character="metalman", key=MetalManKEYS[i], state=false}})
		  end
		end
		return
		elseif (monde.moi.perso=="themagnet")then
		  for i,v in pairs(self.keys.TheMagnetJoystickKEYS) do
			if(v==button) then
			  serveur:send({type="input", pck={character="themagnet", key=TheMagnetKEYS[i], state=false}})
			end
		  end
		end
	end
end

function InputManagerSolo:update()
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


function InputManagerSolo:isKeyDown(key)
	local ok=false
	if self.listKeys[key]~=nil then
		ok=true
	end
	return ok
end

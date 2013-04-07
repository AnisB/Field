--[[ 
This file is part of the Field project]]


MetalManKEYS={up="z",down="s",left="q",right="d",changeweight="b",changestatic="n"}
TheMagnetKEYS={up="up",down="down",left="left",right="right",repulsive="p",attractive="o",rotativel="k",rotativer="l",static="i"}


InputManager = {}
InputManager.__index = InputManager
function InputManager.new()
  local self = {}
  setmetatable(self, InputManager)
  self.keys=require("other.keys")
  return self
end

function InputManager:keyPressed(akey, unicode)
  print("J'ai un input à handler"..akey)
  if(monde.moi.perso=="metalman") then 
    print("C'est un metalman, recherche de la clé")
    for i,v in pairs(self.keys.MetalManKEYS) do
      if(v==akey) then
        print("Trouvée"..i)
        serveur:send({type="input", pck={character="metalMan", key=MetalManKEYS.i, state=true}})
      end
    end
    print("Pas trouvée"..akey)
    return
    elseif (monde.moi.perso=="themagnet")then
      for i,v in pairs(self.keys.MetalManKEYS) do
        if(v==akey) then
          serveur:send({type="input", pck={character="themagnet", key=MetalManKEYS.i, state=true}})
        end
      end
    end
  end

  function InputManager:keyReleased(key, unicode)
  if(monde.moi.perso=="metalman") then 
    for i,v in pairs(self.keys.MetalManKEYS) do
      if(v==akey) then
        serveur:send({type="input", pck={character="metalMan", key=MetalManKEYS.i, state=false}})
      end
    end
    return
    elseif (monde.moi.perso=="themagnet")then
      for i,v in pairs(self.keys.MetalManKEYS) do
        if(v==akey) then
          serveur:send({type="input", pck={character="themagnet", key=MetalManKEYS.i, state=false}})
        end
      end
    end
  end


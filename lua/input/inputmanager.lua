InputManager = {}
InputManager.__index = InputManager


function InputManager.new()
  local self = {}
  setmetatable(self, InputManager)
  return self
end


function InputManager:Init()
	-- Recuperation du nombre de joystick
	self.nbConnectedJoysticks = love.joystick.getJoystickCount()
	-- print("Number of connected joysticks: ", self.nbConnectedJoysticks)

	-- Recuperation de la liste des joystick
    self.joysticks = love.joystick.getJoysticks()

    -- Initialisation des données utiles
    local joysticksData ={}
	for i = 1, self.nbConnectedJoysticks do
		joysticksData[i] = {}
		joysticksData[i].name = self.joysticks[i]:getName( )
		joysticksData[i].nbAxis = self.joysticks[i]:getAxisCount( )
		
		-- Il y a un joystick utilisable
		print("Nombre d'axes ", joysticksData[i].nbAxis)
		if(joysticksData[i].nbAxis > 2) then
			joysticksData[i].up  = false
			joysticksData[i].down  = false
			joysticksData[i].left  = false
			joysticksData[i].right  = false
		end
	end
	self.joysticksData = joysticksData

	-- local keys = self.keys=require("input.keys");

    -- Initialisation des variables
    self.debugPrint = true


	-- Initialisation des vibrations
    self.vibrationEvent = {}
end


-- Gestion des touches
function InputManager:keypressed(akey, isrepeat)
	-- if(self.debugPrint) then
	-- 	print('Key pressed: ',akey,' isrepeat: ', isrepeat)
	-- end
	s_gameManager:inputPressed(akey)
end

function InputManager:keyreleased(akey)
	-- if(self.debugPrint) then
	-- 	print('Key released: ',akey)
	-- end
	s_gameManager:inputReleased(akey)
end

 
-- Gestion des bouttons du joystick
function InputManager:joystickpressed(joystick, button)
	-- if(self.debugPrint) then
	-- 	print('Joystick button pressed joystick: ',joystick,'button: ', button)
	-- end
	local buttonName = 'b'..tostring(button)..'j'..tostring(joystick:getID())
	s_gameManager:inputPressed(buttonName)
end

function InputManager:joystickreleased(joystick, button)
	-- if(self.debugPrint) then
	-- 	print('Joystick button released joystick: ',joystick,'button: ', button)
	-- end
	local buttonName = 'b'..tostring(button)..'j'..tostring(joystick:getID())
	s_gameManager:inputReleased(buttonName)
end

function InputManager:update(dt)

	self:manageVibrations(dt)
	for i = 1, self.nbConnectedJoysticks do
		local xAxis = self.joysticks[i]:getAxis(1)
		local yAxis = self.joysticks[i]:getAxis(2)
		if(xAxis > 0.5) then
			if (self.joysticksData[i].right~=true) then
				self.joysticksData[i].left  = false
				self.joysticksData[i].right = true
				-- if(self.debugPrint) then
				-- 	print("Droite du joystick ", i)
				-- end
				s_gameManager:inputPressed('joyRj'..tostring(self.joysticks[i]:getID()))

			end
		elseif (xAxis < -0.5) then
			if (self.joysticksData[i].left~=true) then
				self.joysticksData[i].left  = true
				self.joysticksData[i].right  = false
				-- if(self.debugPrint) then
				-- 	print("Gauche du joystick ", i)
				-- end
				s_gameManager:inputPressed('joyLj'..tostring(self.joysticks[i]:getID()))
			end
		elseif (self.joysticksData[i].right~=false or self.joysticksData[i].left~=false) then

			if(self.joysticksData[i].right~=false) then
				s_gameManager:inputReleased('joyRj'..tostring(self.joysticks[i]:getID()))
				self.joysticksData[i].right  = false
			else	
				s_gameManager:inputReleased('joyLj'..tostring(self.joysticks[i]:getID()))
				self.joysticksData[i].left  = false
			end
			-- if(self.debugPrint) then
			-- 	print("Centré du joystick ", i)
			-- end

		end

		if(yAxis < -0.5) then
			if (self.joysticksData[i].up~=true) then
				self.joysticksData[i].down  = false
				self.joysticksData[i].up = true
				-- if(self.debugPrint) then
				-- 	print("Haut du joystick ", i)
				-- end
				s_gameManager:inputPressed('joyUj'..tostring(self.joysticks[i]:getID()))
			end
		elseif (yAxis > 0.5) then
			if (self.joysticksData[i].down~=true) then
				self.joysticksData[i].down  = true
				self.joysticksData[i].up  = false
				-- if(self.debugPrint) then
				-- 	print("Bas du joystick ", i)
				-- end
				s_gameManager:inputPressed('joyDj'..tostring(self.joysticks[i]:getID()))
			end
		elseif (self.joysticksData[i].up~=false or self.joysticksData[i].down~=false) then
			if(self.joysticksData[i].down~=false) then
				s_gameManager:inputReleased('joyDj'..tostring(self.joysticks[i]:getID()))

				self.joysticksData[i].down  = false
			else	
				s_gameManager:inputReleased('joyUj'..tostring(self.joysticks[i]:getID()))
				self.joysticksData[i].up  = false
			end
			-- if(self.debugPrint) then
			-- 	print("Centré du joystick ", i)
			-- end
		end
	end

end

function InputManager:manageVibrations(dt)
	for i,v in pairs(self.vibrationEvent) do
		v.time = v.time+dt 
		if(v.time>=v.duration) then
			self.joysticks[v.index]:setVibration(0.0,0.0)
			table.remove(self.vibrationEvent,i)
		end
	end
end

function InputManager:addVibration(parEvent)
		local vibration = {}
		vibration.index = parEvent.joystick
		vibration.duration = parEvent.duration
		vibration.time  = 0.0
		vibration.intersityX = parEvent.intersityX
		vibration.intersityY = parEvent.intersityY
		self.joysticks[parEvent.joystick]:setVibration(parEvent.intersityX,parEvent.intersityY)
		table.insert(self.vibrationEvent,vibration)
end
function InputManager:draw()

end

function InputManager:isKeyDown(key)

end

s_inputManager = InputManager.new()

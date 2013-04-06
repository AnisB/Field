--[[ 
This file is part of the Field project]]

Input = {}
Input.__index =  Input

function Input.new()
    local self = {}
	setmetatable(self, Input)
	
	-- init
	self.metalManInputs={}
	self.theMagnetInputs={}
	
end

function Input:receiveMetalManInput(inputMap)
	for i in inputMap.key do
		metalManInputs[i]=inputMap.state
	end
end

function Input:receiveTheMagnetInput(inputMap)
	for i in inputMap.key do
		theMagnetInputs[i]=inputMap.state
	end
end

function Input:getMetalManKeyState(key)
	return metalManInputs[key]
end

function Input:getTheMagnetKeyState(key)
	return theMagnetInputs[key]
end
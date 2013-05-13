--[[ 
This file is part of the Field project
]]


EventManager = {}
EventManager.__index =  EventManager

function EventManager.new()
    local self = {}
    setmetatable(self, EventManager)
    self.card={}
    return self
end




function EventManager:update(dt)
	for id,card in pairs(self.cardList) do
		card:update(dt)
	end
	for id,card in pairs(self.cardList) do
		if card:evalCondition() then
			card:doAction()
		end
	end
end


function EventManager:addCard(newCard)
	table.insert(self.cards,newCard)
end
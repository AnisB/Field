--[[ 
This file is part of the Field project]]

require("ui.layout")


ChoixTypeJeuSolo = {}
ChoixTypeJeuSolo.__index = ChoixTypeJeuSolo
function ChoixTypeJeuSolo.new()
    local self = {}
    setmetatable(self, ChoixTypeJeuSolo)
    local commonBackground = CommonBackground.new()
    local story=Button.new(125,375,200,50, "backgrounds/solo/story.png","story")
    local arcade=Button.new(100,425,250,50, "backgrounds/solo/arcade.png","arcade")
    local ret=Button.new(100,625,250,50, "backgrounds/solo/return.png","ret")
    ret:decaler(10,0)
    self.layout = UILayout.new()

    self.layout:addDrawable(commonBackground)

    self.layout:addSelectable(story)
    self.layout:addSelectable(arcade)
    self.layout:addSelectable(ret)

    self.layout:Init()

    return self
end


function ChoixTypeJeuSolo:keyReleased(key, unicode)
end

function ChoixTypeJeuSolo:keyPressed(key, player) 
    print(player)
    if(self.player == player) then
        self.layout:inputPressed(key)
        if key == InputType.START then
        	local name = self.layout:getSelectedName()
        	print(name)
    		if name =="ret" then
    			s_gameStateManager:changeState('Menu')
    		end
    		if name =="arcade" then
    			s_gameStateManager.state['ChoixPersoSolo'] = ChoixPersoSolo.new(false)
    			s_gameStateManager:changeState('ChoixPersoSolo')
    		end
    	end
    end
end


function ChoixTypeJeuSolo:update(dt) 
	self.layout:update(dt)
end


function ChoixTypeJeuSolo:draw(filter)
	self.layout:draw(filter)
end

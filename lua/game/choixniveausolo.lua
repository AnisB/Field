--[[ 
This file is part of the Field project]]

-- require("game.solo.gameplaysolo")
require("ui.layout")
require("ui.backgroundniveau")

ChoixNiveauSolo = {}
ChoixNiveauSolo.__index = ChoixNiveauSolo
function ChoixNiveauSolo.new(player,continuous)
    local self = {}
    setmetatable(self, ChoixNiveauSolo)
    self.back=BackgroundNiveau.new()
    self.player = player

    self.levellabel=s_resourceManager:LoadImage("backgrounds/choixniveau/level.png")

    local play= Button.new(150,340,200,50,   "backgrounds/choixniveau/play.png","play")
    local ret= Button.new(125,440,250,50, "backgrounds/choixniveau/return.png","ret")
    ret:decaler(10,0)

    local right = Button.new(1100,300,123,155,"backgrounds/choixniveau/right.png")
    local left= Button.new(500,300,123,155,"backgrounds/choixniveau/left.png")
    left:decaler(10,0)

    self.layout = UILayout.new()

    self.layout:addSelectable(play)
    self.layout:addSelectable(ret)

    self.layout:addDrawable(right)
    self.layout:addDrawable(left)

    self.layout:Init()

    self.num_level = 1
    self.availableMaps = self:listmaps()
    self.level = self.availableMaps[self.num_level]
    self.prev={}
    self.prev[self.level]=love.graphics.newImage("maps/solo/"..player.."/"..self.level.."-fieldmap/prev.png")

    self.continuous=continuous

    -- self.font = love.graphics.newFont(FontDirectory .. "font.ttf", 30)
    -- love.graphics.setFont(self.font)

    return self
end

function ChoixNiveauSolo:reset()
	
end

function ChoixNiveauSolo:listmapslua()
	local files = love.filesystem.getDirectoryItems("maps/solo/"..self.player.."/")
	local m = {}
	for k,v in pairs(files) do
		if string.sub(v, -4) == ".lua" then
			table.insert(m, string.sub(v, 0, -5))
		end
	end
	return m
end

function ChoixNiveauSolo:listmaps()
	local files = love.filesystem.getDirectoryItems("maps/solo/"..self.player.."/")
	local m = {}
	for k,v in pairs(files) do
		if string.sub(v, -9) == "-fieldmap" then
			table.insert(m, string.sub(v, 0, -10))
		end
	end
	return m
end


function ChoixNiveauSolo:keyPressed(key, unicode)
	self.layout:inputPressed(key, player)
	if  key == InputType.LEFT then
		self.num_level = self.num_level - 1
		if self.num_level < 1 then self.num_level = 1 end
		if self.num_level > #self.availableMaps then self.num_level = #self.availableMaps end
		self.level = self.availableMaps[self.num_level]
		if self.prev[self.level]==nil then
			self.prev[self.level]=s_resourceManager:LoadImage("maps/solo/"..self.player.."/"..self.level.."-fieldmap/prev.png")
		end
	elseif key == InputType.RIGHT then
		self.num_level = self.num_level + 1
		if self.num_level < 1 then self.num_level = 1 end
		if self.num_level > #self.availableMaps then self.num_level = #self.availableMaps end
		self.level = self.availableMaps[self.num_level]
		if self.prev[self.level]==nil then
			self.prev[self.level]=s_resourceManager:LoadImage("maps/solo/"..self.player.."/"..self.level.."-fieldmap/prev.png")
		end
	elseif key == InputType.START then
    	local name = self.layout:getSelectedName()
		if name =="ret" then
			s_gameStateManager:changeState('ChoixPersoSolo')
		end
		if name =="play" then
			s_gameStateManager.state['GameplaySolo']= nil
			s_gameStateManager.state['GameplaySolo']= GameplaySolo.new("maps/solo/"..self.player.."/"..self.level,self.continuous,self.player)
			s_gameStateManager:changeState('GameplaySolo')
		end
	end

end
function ChoixNiveauSolo:keyReleased(key, unicode)
end



function ChoixNiveauSolo:update(dt)
	self.layout:update(dt)
	self.back:update(dt)
end


function ChoixNiveauSolo:draw(filter)
	-- background :
	self.back:draw(filter)
	self.layout:draw(filter)

	love.graphics.draw(self.levellabel, 720, 200)
	love.graphics.print(self.level, 920, 200)

	love.graphics.setColor(255,255,255,255*filter)
	love.graphics.draw(self.prev[self.level], 647, 260,0,0.35,0.35)



end

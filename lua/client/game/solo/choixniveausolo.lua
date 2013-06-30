--[[ 
This file is part of the Field project]]

require("game.solo.gameplaysolo")

ChoixNiveauSolo = {}
ChoixNiveauSolo.__index = ChoixNiveauSolo
function ChoixNiveauSolo.new(player,continuous)
    local self = {}
    setmetatable(self, ChoixNiveauSolo)
    self.back=BackgroundNiveau.new()
    self.player = player

    self.levellabel=love.graphics.newImage("backgrounds/choixniveau/level.png")

    self.play= Button.new(150,340,200,50,   "backgrounds/choixniveau/play.png")
    self.returnB= Button.newDec(125,440,250,50, "backgrounds/choixniveau/return.png",10,0)

    self.right= Button.new(1100,300,123,155,"backgrounds/choixniveau/right.png")
    self.left= Button.newDec(500,300,123,155,"backgrounds/choixniveau/left.png",10,0)
    
    self.num_level = 1
    self.availableMaps = self:listmaps()
    self.level = self.availableMaps[self.num_level]
    self.prev={}
    self.prev[self.level]=love.graphics.newImage("maps/solo/"..player.."/"..self.level.."-fieldmap/prev.png")

    self.continuous=continuous

    self.font = love.graphics.newFont(FontDirectory .. "font.ttf", 30)
    love.graphics.setFont(self.font)

    self.inputManager = MenuInputManager.new(self)
    self.timerPrev=1
    self.fonduDone=true

    self.selection = {
        self.play,
        self.returnB
    }
    self.selected = 1
    self.play:setSelected(true)
    return self
end

function ChoixNiveauSolo:listmapslua()
	local files = love.filesystem.enumerate("maps/solo/"..self.player.."/")
	local m = {}
	for k,v in pairs(files) do
		if string.sub(v, -4) == ".lua" then
			table.insert(m, string.sub(v, 0, -5))
		end
	end
	return m
end

function ChoixNiveauSolo:listmaps()
	local files = love.filesystem.enumerate("maps/solo/"..self.player.."/")
	local m = {}
	for k,v in pairs(files) do
		if string.sub(v, -9) == "-fieldmap" then
			table.insert(m, string.sub(v, 0, -10))
		end
	end
	return m
end


function ChoixNiveauSolo:mousePressed(x, y, button)

end

function ChoixNiveauSolo:mouseReleased(x, y, button) end

function ChoixNiveauSolo:keyPressed(key, unicode)
    self.inputManager:keyPressed(key,unicode)
end
function ChoixNiveauSolo:keyReleased(key, unicode)
    self.inputManager:keyReleased(key,unicode)
end

function ChoixNiveauSolo:joystickPressed(key, unicode)
    self.inputManager:joystickPressed(key,unicode)
end


function ChoixNiveauSolo:joystickReleased(key, unicode)
    self.inputManager:joystickReleased(key,unicode)
end


function ChoixNiveauSolo:sendPressedKey(key, unicode) 
	if key == "down" then
		self:incrementSelection()
	elseif key == "up" then
		self:decrementSelection()
	elseif key == "left" then
		self.num_level = self.num_level - 1
		if self.num_level < 1 then self.num_level = 1 end
		if self.num_level > #self.availableMaps then self.num_level = #self.availableMaps end
		self.level = self.availableMaps[self.num_level]
		if self.prev[self.level]==nil then
			self.prev[self.level]=love.graphics.newImage("maps/solo/"..self.player.."/"..self.level.."-fieldmap/prev.png")
		end
		self.fonduDone=false
		self.timerPrev=0
	elseif key== "right" then
		self.num_level = self.num_level + 1
		if self.num_level < 1 then self.num_level = 1 end
		if self.num_level > #self.availableMaps then self.num_level = #self.availableMaps end
		self.level = self.availableMaps[self.num_level]
		if self.prev[self.level]==nil then
			self.prev[self.level]=love.graphics.newImage("maps/solo/"..self.player.."/"..self.level.."-fieldmap/prev.png")
		end
		self.fonduDone=false
		self.timerPrev=0
	elseif key == "return" then
		if self.play.selected then
			gameStateManager.state['GameplaySolo']= GameplaySolo.new("maps/solo/"..self.player.."/"..self.level,self.continuous,self.player)
			gameStateManager:changeState('GameplaySolo')
		elseif self.returnB.selected then
			gameStateManager:changeState('ChoixPersoSolo')
		end
	elseif key == "escape" then
		gameStateManager:changeState('ChoixPersoSolo')
	end


end


function ChoixNiveauSolo:incrementSelection()
	self.selection[self.selected]:setSelected(false)
	if self.selected == #self.selection then
		self.selected = 0
	end
	self.selected = self.selected + 1
	self.selection[self.selected]:setSelected(true)
end

function ChoixNiveauSolo:decrementSelection()
	self.selection[self.selected]:setSelected(false)
		if self.selected == 1 then
		self.selected = #self.selection + 1
	end
	self.selected = self.selected - 1
	self.selection[self.selected]:setSelected(true)
end


function ChoixNiveauSolo:update(dt)
	self.back:update(dt)
	self.inputManager:update()
	if not self.fonduDone then
		self.timerPrev =self.timerPrev +dt
		if self.timerPrev>=1 then
			self.timerPrev=1
			self.fonduDone=true
		end
	end
end


function ChoixNiveauSolo:draw()
	x, y = love.mouse.getPosition()

	-- background :
	self.back:draw(1)

	love.graphics.draw(self.levellabel, 720, 200)
	love.graphics.print(self.level, 920, 200)
	self.right:draw(1)
	self.left:draw(1)
    self.play:draw(1)
    self.returnB:draw(1)

	love.graphics.setColor(255,255,255,255*self.timerPrev)
	love.graphics.draw(self.prev[self.level], 647, 260,0,0.35,0.35)



end

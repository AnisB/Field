--[[ 
This file is part of the Field project]]

require("game.solo.gameplaysolo")

ChoixNiveauSolo = {}
ChoixNiveauSolo.__index = ChoixNiveauSolo
function ChoixNiveauSolo.new(player,continuous)
    local self = {}
    setmetatable(self, ChoixNiveauSolo)
    self.back=love.graphics.newImage("backgrounds/choixniveau/back.png")
    self.levellabel=love.graphics.newImage("backgrounds/choixniveau/level.png")

    self.play= Button.new(550,640,200,50,ButtonType.Small,"backgrounds/choixniveau/play.png")
    self.returnB= Button.newDec(1000,640,250,50,ButtonType.Large,"backgrounds/choixniveau/return.png",10,0)

    self.right= Button.new(1000,350,123,155,ButtonType.Arrow,"backgrounds/choixniveau/right.png")
    self.left= Button.newDec(90,350,123,155,ButtonType.Arrow,"backgrounds/choixniveau/left.png",10,0)
    
    self.num_level = 1
    self.availableMaps = self:listmapslua()
    self.level = self.availableMaps[self.num_level]
    -- self.prev={}
    -- self.prev[self.level]=love.graphics.newImage("maps/"..self.level..".fieldmap/prev.png")

    self.player = player
    self.continuous=continuous

    self.font = love.graphics.newFont(FontDirectory .. "font.ttf", 30)
    love.graphics.setFont(self.font)

    self.timerPrev=1
    self.fonduDone=true
    return self
end

function ChoixNiveauSolo:listmapslua()
	local files = love.filesystem.enumerate(SoloMapDirectory)
	local m = {}
	for k,v in pairs(files) do
		if string.sub(v, -4) == ".lua" then
			table.insert(m, string.sub(v, 0, -5))
		end
	end
	return m
end

function ChoixNiveauSolo:listmaps()
	local files = love.filesystem.enumerate(SoloMapDirectory)
	local m = {}
	for k,v in pairs(files) do
		if string.sub(v, -9) == ".fieldmap" then
			table.insert(m, string.sub(v, 0, -10))
		end
	end
	return m
end


function ChoixNiveauSolo:mousePressed(x, y, button)
	if self.left:isCliked(x,y) then
		self:keyPressed("q")
	elseif self.right:isCliked(x,y) then
		self:keyPressed("d")
	elseif self.play:isCliked(x,y) then
		gameStateManager.state['GameplaySolo']= GameplaySolo.new(self.level,self.continuous,self.player)
		gameStateManager:changeState('GameplaySolo')
	elseif self.returnB:isCliked(x,y) then
		gameStateManager:changeState("ChoixPersoSolo")
	end
end

function ChoixNiveauSolo:mouseReleased(x, y, button) end

function ChoixNiveauSolo:keyPressed(key, unicode)
	if key == "q" or key== "left" then
		self.num_level = self.num_level - 1
		if self.num_level < 1 then self.num_level = 1 end
		if self.num_level > #self.availableMaps then self.num_level = #self.availableMaps end
		self.level = self.availableMaps[self.num_level]
		-- if self.prev[self.level]==nil then
			-- self.prev[self.level]=love.graphics.newImage("maps/"..self.level..".fieldmap/prev.png")
			print "new img"
		--end
		self.fonduDone=false
		self.timerPrev=0
	elseif key == "d" or key== "right" then
		self.num_level = self.num_level + 1
		if self.num_level < 1 then self.num_level = 1 end
		if self.num_level > #self.availableMaps then self.num_level = #self.availableMaps end
		self.level = self.availableMaps[self.num_level]
		-- if self.prev[self.level]==nil then
			-- self.prev[self.level]=love.graphics.newImage("maps/"..self.level..".fieldmap/prev.png")
			print "new img"
		--end
		self.fonduDone=false
		self.timerPrev=0
	elseif key == "return" then
		gameStateManager.state['GameplaySolo']= GameplaySolo.new(self.level,self.continuous,self.player)
		gameStateManager:changeState('GameplaySolo')
	end


end

function ChoixNiveauSolo:keyReleased(key, unicode) end

function ChoixNiveauSolo:joystickPressed(joystick, button)
end

function ChoixNiveauSolo:joystickReleased(joystick, button)
end

function ChoixNiveauSolo:update(dt)
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
	love.graphics.draw(self.back, 0, 0)

	love.graphics.draw(self.levellabel, 420, 200)

	love.graphics.print(self.level, 620, 200)
	self.right:draw(x,y,1)
	self.left:draw(x,y,1)
    self.play:draw(x,y,1)
    self.returnB:draw(x,y,1)

	love.graphics.setColor(255,255,255,255*self.timerPrev)
	-- love.graphics.draw(self.prev[self.level], 400, 300,0,0.35,0.35)



end

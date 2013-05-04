--[[ 
This file is part of the Field project]]

ChoixPersoSolo = {}
ChoixPersoSolo.__index = ChoixPersoSolo
function ChoixPersoSolo.new(continuous)
    local self = {}
    setmetatable(self, ChoixPersoSolo)
    self.mm = love.graphics.newImage("backgrounds/choixperso/metalmanimg.png")
    self.tm = love.graphics.newImage("backgrounds/choixperso/magnetimg.png")

    self.back= love.graphics.newImage("backgrounds/choixperso/back.png")
    self.themagnet = Button.newDec(200,200,420,300,ButtonType.Perso,"backgrounds/choixperso/magnet.png",0,300)
    self.metalman= Button.newDec(670,200,420,300,ButtonType.Perso,"backgrounds/choixperso/metalman.png",0,300)
    self.play= Button.new(550,640,200,50,ButtonType.Small,"backgrounds/choixperso/play.png")
    self.returnB= Button.newDec(1000,640,250,50,ButtonType.Large,"backgrounds/choixperso/return.png",10,0)

    self.play:setEnable(false)
    self.continuous=continuous

    self.selected=-1
    return self
end

function ChoixPersoSolo:mousePressed(x, y, button)
	if self.metalman:isCliked(x,y) then
		self.selected=1
		self.metalman:setSelected(true)
		self.themagnet:setSelected(false)
		self.play:setEnable(true)
	elseif self.themagnet:isCliked(x,y) then
		self.selected=2
		self.themagnet:setSelected(true)
		self.metalman:setSelected(false)
		self.play:setEnable(true)
	elseif self.play:isCliked(x,y) then
		if self.selected~=-1 then
			if self.selected==1 then
				gameStateManager.state['ChoixNiveauSolo'] = ChoixNiveauSolo.new("metalman",self.continuous)
			elseif self.selected==2 then

				gameStateManager.state['ChoixNiveauSolo'] = ChoixNiveauSolo.new("themagnet",self.continuous)
			end
			gameStateManager:changeState('ChoixNiveauSolo')
		end
	
	elseif self.returnB:isCliked(x,y) then
		gameStateManager:changeState("ChoixTypeJeuSolo")
	end
end

function ChoixPersoSolo:mouseReleased(x, y, button) 
end
function ChoixPersoSolo:keyPressed(key, unicode)
end
function ChoixPersoSolo:keyReleased(key, unicode)
end

function ChoixPersoSolo:joystickPressed(joystick, button)
end

function ChoixPersoSolo:joystickReleased(joystick, button)
end

function ChoixPersoSolo:update(dt) 
end


function ChoixPersoSolo:draw()
	local hover = false
	x, y = love.mouse.getPosition()

	-- background :
	love.graphics.draw(self.back, 0, 0)

	self.themagnet:draw(x,y,1)
    self.metalman:draw(x,y,1)
    self.play:draw(x,y,1)
    self.returnB:draw(x,y,1)

    love.graphics.draw(self.tm,300,210)
    love.graphics.draw(self.mm,710,210)

end

--[[ 
This file is part of the Field project]]

require("game.themagnet")
require("game.metalman")
require("game.camera")
require("game.maploader")
require("const")
require("game.levelending")
require("game.levelfailed")
require("game.inputmanager")
require("game.background")

Gameplay = {}
Gameplay.__index = Gameplay

function Gameplay.new(mapFile)
    local self = {}
    setmetatable(self, Gameplay)
    --Map
    if mapFile == nil then
        mapFile = "maps.field2"
    end
    self.mapFile=mapFile
    self.mapLoader = MapLoader.new(mapFile)
    
    --Characters
    self.metalMan = MetalMan.new()
    self.theMagnet = TheMagnet.new()
	self.keyPacket={}
	self.mapx=self.mapLoader.map.width*self.mapLoader.map.tilewidth
	self.mapy= self.mapLoader.map.height*self.mapLoader.map.tileheight
	self.background1=Background.new("img/background/1.png",1,self.mapy)
	self.background2=Background.new("img/background/2.png",0.75,self.mapy)
	self.background3=Background.new("img/background/3.png",0.5,self.mapy)
	self.background4=Background.new("img/background/4.png",0.0,self.mapy)
	self.background5=Background.new("img/background/5.png",0.0,self.mapy)

    self.camera=Camera.new(-1000,-1000)
    self.inputManager = InputManager.new()
    return self
end

function Gameplay:reset()
    self.shouldEnd=false

    --Map
    print("LOADING FILE =", self.mapFile)
    self.mapLoader = MapLoader.new(self.mapFile)
    
    --Characters
    self.metalMan = MetalMan.new()
    self.theMagnet = TheMagnet.new()
    self.keyPacket={}
    self.camera=Camera.new(-1000,-1000)
end

function Gameplay:handlePacket(packet)

	if packet.levelfailed~=nil then
		gameStateManager.state['LevelFailed']=LevelFailed.new()
		gameStateManager:changeState('LevelFailed')
	end

	if packet.levelfinish~=nil then
		gameStateManager.state['LevelEnding']=LevelEnding.new(packet.next,packet.continuous)
		gameStateManager:changeState('LevelEnding')
	end

	if  packet.themagnet~=nil then
		self.theMagnet:handlePacket(packet.themagnet)
	end
	if  packet.metalman~=nil then
		self.metalMan:handlePacket(packet.metalman)
	end
	if  packet.camera~=nil then
		self.camera:handlePacket(packet.camera)
	else
		print "camera nil"
	end        
	if  packet.map~=nil then
		self.mapLoader:handlePacket(packet.map)
	end
end

function Gameplay:finish()
end

function Gameplay:mousePressed(x, y, button)
end

function Gameplay:mouseReleased(x, y, button)
end

function Gameplay:keyPressed(inputKey, unicode)
	self.inputManager:keyPressed(inputKey, unicode)
	-- serveur:send({type="input", pck={character="metalMan", key=inputKey, state=true}})
end

	
function Gameplay:keyReleased(inputKey, unicode)
	self.inputManager:keyReleased(inputKey, unicode)

	-- serveur:send({type="input", pck={character="metalMan", key=inputKey, state=false}})
end

function Gameplay:joystickPressed(joystick, button)
	self.inputManager:joystickPressed(joystick, button)
end

function Gameplay:joystickReleased(joystick, button)
	self.inputManager:joystickReleased(joystick, button)
end

function Gameplay:update(dt)
	self.theMagnet:update(dt)
	self.metalMan:update(dt)
	self.mapLoader:update(dt)
	self.inputManager:update()
end


function Gameplay:draw()
	-- self.background6:draw(self.camera:getPos())

	self.background5:draw(self.camera:getPos())	
	
	self.background4:draw(self.camera:getPos())

	self.background3:draw(self.camera:getPos())

	self.background2:draw(self.camera:getPos())


	self.background1:draw(self.camera:getPos())



	self.mapLoader:draw(self.camera:getPos())
	self.theMagnet:draw()
	self.metalMan:draw()
	self.mapLoader:firstPlanDraw()
	love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)

end
    

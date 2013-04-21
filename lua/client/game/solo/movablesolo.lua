--[[ 
    This file is part of the Field project
    ]]

    require("const")
    require("game.animbloc")
    MovableSolo = {}
    MovableSolo.__index =  MovableSolo
    
    function MovableSolo.new(position,type,netid)
        local self = {}
        setmetatable(self, MovableSolo)

        self.netid=netid
        -- Position
        self.position={x=position.x,y=position.y}
        self.w=unitWorldSize
        self.h=unitWorldSize
        -- Sprite
        self.anim = AnimBloc.new('bloc/nonmetal')

        -- Type
        self.type='MovableSolo'
        self.shapeType = type
        if self.shapeType=='sphere' then
            self.pc = Physics.newSphere(self.position.x,self.position.y,unitWorldSize/2,false)
        elseif self.shapeType =='rectangle' then
            decalage={unitWorldSize/2,unitWorldSize/2}
            self.pc = Physics.newRectangle(self.position.x,self.position.y,unitWorldSize,unitWorldSize,false,decalage)
        end
        self.pc.fixture:setUserData(self)    
        return self
    end

    function MovableSolo:update(dt)
        self.anim:update(dt)
        self.position.x=self.pc.body:getX()
        self.position.y=self.pc.body:getY()
    end
   

   function MovableSolo:getPosition()
    return self.position
end 
function MovableSolo:collideWith( object, collision )

end

function MovableSolo:unCollideWith( object, collision )

end
    function MovableSolo:draw(x, y)  
       love.graphics.setColor(255,255,255,255)
       love.graphics.draw(self.anim:getSprite(), self.position.x-x, self.position.y+y)
    end



    function MovableSolo:send(x, y)
    return ("@movableSolo".."#"..self.netid.."#"..self.anim:getImgInfo()[1].."#"..self.anim:getImgInfo()[2].."#"..math.floor(self.position.x-x).."#"..math.floor(self.position.y+y))
    end
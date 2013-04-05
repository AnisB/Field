--[[ 
    This file is part of the Field project
    ]]

    require("const")
    require("game.animbloc")
    Movable = {}
    Movable.__index =  Movable
    
    function Movable.new(position,type)
        local self = {}
        setmetatable(self, Movable)

        -- Position
        self.position={x=position.x,y=position.y}
        self.w=unitWorldSize
        self.h=unitWorldSize
        -- Sprite
        self.anim = AnimBloc.new('bloc/nonmetal')

        -- Type
        self.type='Movable'
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

    function Movable:update(dt)
        self.anim:update(dt)
        self.position.x=self.pc.body:getX()
        self.position.y=self.pc.body:getY()
    end
   

   function Movable:getPosition()
    return self.position
end 
function Movable:collideWith( object, collision )

end

function Movable:unCollideWith( object, collision )

end
    function Movable:draw(x, y)  
       love.graphics.setColor(255,255,255,255)
       love.graphics.draw(self.anim:getSprite(), self.position.x-x, self.position.y+y)
    end



    function Movable:send(x, y)
    return ("@movable".."#"..self.anim:getImgInfo()[1].."#"..self.anim:getImgInfo()[2].."#"..math.floor(self.position.x-x).."#"..math.floor(self.position.y+y))
    end
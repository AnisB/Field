--[[ 
    This file is part of the Field project
    ]]

    require("const")
    Movable = {}
    Movable.__index =  Movable
    
    function Movable.new(position,type,sprite)
        local self = {}
        setmetatable(self, Movable)

        -- Position
        self.position={x=position.x,y=position.y}

        -- Sprite
        self.sprite=sprite

        -- Type
        self.type='Movable'
        self.shapeType = type
        if self.shapeType=='Sphere' then
            self.pc = Physics.newSphere(self.position.x,self.position.y,unitWorldSize/2,false)
        elseif self.shapeType =='Rectangle' then
            decalage={unitWorldSize/2,unitWorldSize/2}
            self.pc = Physics.newRectangle(self.position.x,self.position.y,unitWorldSize,unitWorldSize,false,decalage)
        end
        self.pc.fixture:setUserData(self)    
        return self
    end

    function Movable:update(dt)
    end
   

   function Movable:getPosition()
    return self.position
end 
function Movable:collideWith( object, collision )

end

function Movable:unCollideWith( object, collision )

end
    function Movable:draw(x, y)
         self.position.x=self.pc.body:getX()
         self.position.y=self.pc.body:getY()
         love.graphics.setColor(100,200,200,255)
         if self.shapeType=='Sphere' then
            love.graphics.circle( "fill", self.position.x-x,self.position.y+y,unitWorldSize/2, 1000 )
            elseif self.shapeType =='Rectangle' then
                love.graphics.rectangle( "fill", self.position.x-x,self.position.y+y, unitWorldSize, unitWorldSize )
            end
    end
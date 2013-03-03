--[[ 
    This file is part of the Field project
    ]]

    require("const")
    Destroyable = {}
    Destroyable.__index =  Destroyable
    
    function Destroyable.new(position,type,sprite)
        local self = {}
        setmetatable(self, Destroyable)

        -- Position
        self.position={x=position.x,y=position.y}

        -- Sprite
        self.sprite=sprite

        -- Type
        self.type='Destroyable'
        self.shapeType = type
        if self.shapeType=='Sphere' then
            self.pc = Physics.newSphere(self.position.x,self.position.y,unitWorldSize/2,true)
        elseif self.shapeType =='Rectangle' then
            decalage={unitWorldSize/2,unitWorldSize/2}
            self.pc = Physics.newRectangle(self.position.x,self.position.y,unitWorldSize,unitWorldSize,true,decalage)
        end
        self.pc.fixture:setUserData(self)    
        self.kinPallier = 90    
        self.destroy=false
        return self
    end

    function Destroyable:update(dt)
    end
   

   function Destroyable:getPosition()
    return self.position
end 
function Destroyable:collideWith( object, collision )
    if object.type=='MetalMan' then
        local kinEnergy = math.log(0.5*object.pc.body:getMass()*object.pc.body:getMass()*object.pc.body:getMass()*object.pc.body:getLinearVelocity())
        if(kinEnergy>10.5) then
            self.pc.body:destroy()
            self.destroy=true
            Sound.playSound('break')
        end
    end
end

function Destroyable:unCollideWith( object, collision )

end
    function Destroyable:draw(x, y)
        if (not self.destroy)  then
         self.position.x=self.pc.body:getX()
         self.position.y=self.pc.body:getY()
         love.graphics.setColor(255,255,255,255)
         if self.shapeType=='Sphere' then
            love.graphics.circle( "fill", self.position.x-x,self.position.y+y,unitWorldSize/2, 1000 )
            elseif self.shapeType =='Rectangle' then
                love.graphics.rectangle( "fill", self.position.x-x,self.position.y+y, unitWorldSize, unitWorldSize )
            end
        end
    end
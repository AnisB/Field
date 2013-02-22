--[[ 
    This file is part of the Field project
    ]]

    require("const")
    Destructs = {}
    Destructs.__index =  Destructs
    
    function Destructs.new(position, sprite)
        local self = {}
        setmetatable(self, Destructs)
        self.position={x=position.x,y=position.y}
        self.sprite=sprite
        decalage={unitWorldSize/2,unitWorldSize/2}
        self.type='Destructs'
        self.pc = Physics.newRectangle(self.position.x,self.position.y,unitWorldSize,unitWorldSize,true,decalage)
        self.pc.fixture:setUserData(self)    
        self.kinPallier = 90    
        self.destroy=false
        return self
    end

    function Destructs:update(dt)
    end
   

   function Destructs:getPosition()
    return self.position
end 
function Destructs:collideWith( object, collision )
    if object.type=='MetalMan' then
        local kinEnergy = math.log(0.5*object.pc.body:getMass()*object.pc.body:getMass()*object.pc.body:getMass()*object.pc.body:getLinearVelocity())
        if(kinEnergy>10.5) then
            self.pc.body:destroy()
            self.destroy=true
        end
    end
end

function Destructs:unCollideWith( object, collision )

end
    function Destructs:draw(x, y)
    if (not self.destroy)       then
       self.position.x=self.pc.body:getX()
       self.position.y=self.pc.body:getY()
       love.graphics.rectangle( "fill", self.position.x-x,self.position.y+y, unitWorldSize, unitWorldSize )
   end
	  --love.graphics.polygon("fill", self.pc.body:getWorldPoints(self.pc.shape:getPoints()))

    end
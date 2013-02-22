--[[ 
    This file is part of the Field project
    ]]

    require("const")
    Bloc = {}
    Bloc.__index =  Bloc
    
    function Bloc.new(position, sprite)
        local self = {}
        setmetatable(self, Bloc)
        self.position={x=position.x,y=position.y}
        self.sprite=sprite
        decalage={unitWorldSize/2,unitWorldSize/2}
        self.type='Bloc'
        self.pc = Physics.newRectangle(self.position.x,self.position.y,unitWorldSize,unitWorldSize,false,decalage)
        self.pc.fixture:setUserData(self)        
        return self
    end

    function Bloc:update(dt)
    end
   

   function Bloc:getPosition()
    return self.position
end 
function Bloc:collideWith( object, collision )

end

function Bloc:unCollideWith( object, collision )

end
    function Bloc:draw(x, y) 
       self.position.x=self.pc.body:getX()
       self.position.y=self.pc.body:getY()
       love.graphics.rectangle( "fill", self.position.x-x,self.position.y+y, unitWorldSize, unitWorldSize )
	  --love.graphics.polygon("fill", self.pc.body:getWorldPoints(self.pc.shape:getPoints()))

    end
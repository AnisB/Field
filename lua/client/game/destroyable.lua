--[[ 
    This file is part of the Field project
    ]]

    require("game.animdestroyable")
    require("const")
    Destroyable = {}
    Destroyable.__index =  Destroyable
    
    function Destroyable.new(position,anim,pos)
        local self = {}
        setmetatable(self, Destroyable)

        -- Position
        self.position={x=position.x,y=position.y}

        -- Type
        self.type='Destroyable'

        self.anim = AnimDestroyable.new('destroyable')
        self:loadAnimation("normal",true)
        self.anim:syncronize(anim,pos)
        return self
    end

    function Destroyable:update(dt)
        self.anim:update(dt)
 end


 function Destroyable:getPosition()
    return self.position
end 

function Destroyable:unCollideWith( object, collision )

end
function Destroyable:draw()
   love.graphics.draw(self.anim:getSprite(), self.position.x, self.position.y)
end

function Destroyable:loadAnimation(anim, force)
    self.anim:load(anim, force)
end

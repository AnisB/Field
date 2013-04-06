--[[ 
    This file is part of the Field project
    ]]

    require("const")
    require("game.animbloc")
    Movable = {}
    Movable.__index =  Movable
    
    function Movable.new(position,anim,pos)
        local self = {}
        setmetatable(self, Movable)

        -- Position
        self.position={x=position.x,y=position.y}
        -- Sprite
        self.anim = AnimBloc.new('bloc/nonmetal')

        -- Type
        self.type='Movable'
        self.anim:syncronize(anim,pos)        
        return self
    end

    function Movable:update(dt)
        self.anim:update(dt)
    end
    function Movable:syncronize(pos,anim,id)
        self.drawed=true
        if (self.anim.currentAnim.name~=anim) then
            self.anim:syncronize(anim,id)
            end        
        self.position.x=pos.x
        self.position.y=pos.y    
    end


    function Movable:getPosition()
        return self.position
    end 
    function Movable:collideWith( object, collision )

    end

    function Movable:unCollideWith( object, collision )

    end
    function Movable:draw()  
       love.graphics.draw(self.anim:getSprite(), self.position.x, self.position.y)
   end

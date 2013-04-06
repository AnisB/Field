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
        self.drawed=true
        -- Position
        self.position={x=position.x,y=position.y}

        -- Type
        self.type='Destroyable'

        self.anim = AnimDestroyable.new('destroyable')
        self:loadAnimation("normal",true)
        self.anim:syncronize(anim,pos)
        self.drawed=true
        return self
    end

    function Destroyable:update(dt)
        self.anim:update(dt)
 end
    function Destroyable:syncronize(pos,anim,id)
        if (self.anim.currentAnim.name~=anim) then
            print(self.anim.currentAnim.name.."syncro"..anim)    
            self.anim:syncronize(anim,id) 
        end
        self.position.x=pos.x
        self.position.y=pos.y
        self.drawed=true
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

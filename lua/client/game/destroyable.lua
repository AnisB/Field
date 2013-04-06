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
        self.anim:syncronize(anim,id) 
        print(self.position.x.."#"..self.position.y)
        print("#"..pos.x.."#"..pos.y)  
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
   -- if self.anim:getSprite()~=nil then
     print(self.anim:getSprite(), self.position.x, self.position.y)   
     love.graphics.draw(self.anim:getSprite(), self.position.x, self.position.y)
 -- end
end

function Destroyable:loadAnimation(anim, force)
    self.anim:load(anim, force)
end

--[[ 
    This file is part of the Field project
    ]]

    require("game.animdestroyable")
    require("const")
    Destroyable = {}
    Destroyable.__index =  Destroyable
    
    function Destroyable.new(position,type,sprite,w,h)
        local self = {}
        setmetatable(self, Destroyable)

        -- Position
        self.position={x=position.x,y=position.y}
        self.w=w
        self.h=h
        -- Sprite
        self.sprite=sprite

        -- Type
        self.type='Destroyable'
        self.shapeType = type
        if self.shapeType=='sphere' then
            self.pc = Physics.newSphere(self.position.x,self.position.y,unitWorldSize/2,true)
            elseif self.shapeType =='rectangle' then
                decalage={w/2,h/2}
                self.pc = Physics.newRectangle(self.position.x,self.position.y,w,h,true,decalage)
            end
            self.anim = AnimDestroyable.new('destroyable')
            self:loadAnimation("normal",true)
            self.pc.fixture:setUserData(self)    
            self.kinPallier = 90    
            self.destroy=false
            return self
        end

        function Destroyable:update(dt)
            self.anim:update(dt)
            if (not self.destroy)  then
               self.position.x=self.pc.body:getX()
               self.position.y=self.pc.body:getY()
           end
       end


       function Destroyable:getPosition()
        return self.position
    end 
    function Destroyable:collideWith( object, collision )
        if object.type=='MetalMan' then
            x,y =object.pc.body:getLinearVelocity()
            local kinEnergyX = math.log(0.5*object.pc.body:getMass()*object.pc.body:getMass()*object.pc.body:getMass()*math.abs(x))
            local kinEnergyY = math.log(0.5*object.pc.body:getMass()*object.pc.body:getMass()*object.pc.body:getMass()*math.abs(y))
            if(kinEnergyX>10.5) and object.position.y>self.position.y then
                self.pc.body:destroy()
                self.destroy=true
                Sound.playSound('break')
                self:loadAnimation("breaking",true)
            end

            if(kinEnergyY>11.2) and object.position.x>self.position.x then
                self.pc.body:destroy()
                self.destroy=true
                Sound.playSound('break')
                self:loadAnimation("breaking",true)            
            end
        end
    end

    function Destroyable:unCollideWith( object, collision )

    end
    function Destroyable:draw(x, y)
     love.graphics.setColor(255,255,255,255)
     love.graphics.draw(self.anim:getSprite(), self.position.x-x, self.position.y+y)
 end
 function Destroyable:loadAnimation(anim, force)
    self.anim:load(anim, force)
end


function Destroyable:send(x, y)
    return ("@destroyable".."#"..self.anim:getImgInfo()[1].."#"..self.anim:getImgInfo()[2].."#"..math.floor(self.position.x-x).."#"..math.floor(self.position.y+y))
end
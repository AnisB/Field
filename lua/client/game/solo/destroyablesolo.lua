--[[ 
    This file is part of the Field project
    ]]

    require("game.solo.animdestroyablesolo")
    require("const")
    DestroyableSolo = {}
    DestroyableSolo.__index =  DestroyableSolo
    
    function DestroyableSolo.new(position,type,sprite,w,h,netid)
        local self = {}
        setmetatable(self, DestroyableSolo)

        self.netid=netid
        -- Position
        self.position={x=position.x,y=position.y}
        self.w=w
        self.h=h
        -- Sprite
        self.sprite=sprite

        -- Type
        self.type='DestroyableSolo'
        self.shapeType = type
        if self.shapeType=='sphere' then
            self.pc = Physics.newSphere(self.position.x,self.position.y,unitWorldSize/2,true)
            elseif self.shapeType =='rectangle' then
                decalage={w/2,h/2}
                self.pc = Physics.newRectangle(self.position.x,self.position.y,w,h,true,decalage)
            end
            self.anim = AnimDestroyableSolo.new('destroyable')
            self.pc.fixture:setUserData(self)    
            self.kinPallier = 90    
            self.destroy=false
            self.quad  = love.graphics.newQuad(0, 0, 64, 64, 128, 64)

            return self
        end

        function DestroyableSolo:init()
            self:loadAnimation("normal",true)
       end

        function DestroyableSolo:update(dt)
            self.anim:update(dt)
            if (not self.destroy)  then
               self.position.x=self.pc.body:getX()
               self.position.y=self.pc.body:getY()
           end
       end


       function DestroyableSolo:getPosition()
        return self.position
    end 
    function DestroyableSolo:collideWith( object, collision )
        if object.type=='MetalManSolo' or (object.type =='MetalSolo' and object.metalSoloWeight == MetalSoloMTypes.Acier)then
            x,y =object.pc.body:getLinearVelocity()
            local kinEnergyX = math.log(0.5*object.pc.body:getMass()*object.pc.body:getMass()*object.pc.body:getMass()*math.abs(x))
            local kinEnergyY = math.log(0.5*object.pc.body:getMass()*object.pc.body:getMass()*object.pc.body:getMass()*math.abs(y))
            if(kinEnergyX>10.5) and object.position.y>self.position.y then
                self.pc.body:destroy()
                self.destroy=true
                self:loadAnimation("breaking",true)
            end

            if(kinEnergyY>11.2) and object.position.x>self.position.x then
                self.pc.body:destroy()
                self.destroy=true
                self:loadAnimation("breaking",true)            
            end
        end
    end

    function DestroyableSolo:unCollideWith( object, collision )

    end
    function DestroyableSolo:draw(x, y)
     love.graphics.drawq(self.anim:getSprite(), self.quad,self.position.x-x, self.position.y+y)
 end
 function DestroyableSolo:loadAnimation(anim, force)
    self.anim:load(anim, force)
end

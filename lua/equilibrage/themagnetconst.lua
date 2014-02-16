--[[ 
This file is part of the Field project
]]


TheMagnetConst={}

--  The magnet's
TheMagnetConst.Mass=(0.2)


-- Field Radius
TheMagnetConst.fieldRadius=4*unitWorldSize
-- Rotative Field Strengh
TheMagnetConst.Rot={x=2*unitWorldSize,y=2*unitWorldSize}
-- Attractive Field Strengh
TheMagnetConst.Att={x=2*unitWorldSize,y=2*unitWorldSize}
-- Repulsive Field Strengh
TheMagnetConst.Rep={x=unitWorldSize*1.5,y=unitWorldSize*1.5}


-- Jump impulse
TheMagnetConst.jumpImpulse=-25*unitWorldSize/TheMagnetConst.Mass


-- Déplacement
-- Run force
TheMagnetConst.MovingForce=unitWorldSize*250
-- Max speed
TheMagnetConst.MaxSpeed=unitWorldSize*10
-- Break factor 
TheMagnetConst.BreakFactor=6
TheMagnetConst.AirBreakFactor=2
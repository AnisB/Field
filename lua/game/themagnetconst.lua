--[[ 
This file is part of the Field project
]]


TheMagnetConst={}

--  The magnet's
TheMagnetConst.Mass=(0.05*unitWorldSize)


-- Field Radius
TheMagnetConst.fieldRadius=4*unitWorldSize
-- Rotative Field Strengh
TheMagnetConst.Rot={x=2*unitWorldSize,y=2*unitWorldSize}
-- Attractive Field Strengh
TheMagnetConst.Att={x=1.5*unitWorldSize,y=1.5*unitWorldSize}
-- Repulsive Field Strengh
TheMagnetConst.Rep={x=unitWorldSize*1.5,y=unitWorldSize*1.5}


-- Jump impulse
TheMagnetConst.jumpImpulse=-10*unitWorldSize/(0.05*7)


-- Déplacement
-- Run force
TheMagnetConst.MovingForce=unitWorldSize*50
-- Max speed
TheMagnetConst.MaxSpeed=unitWorldSize*10
-- Break factor 
TheMagnetConst.BreakFactor=2
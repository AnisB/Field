--[[ 
This file is part of the Field project]]


-- Métaux masse
MetalMTypes={Alu =0.05,Acier =0.1}

-- Vitesse max
MetalManMaxSpeed=unitWorldSize*10

-- Puissance des champs
-- Rotatifs (les deux)
MetaManRotFieldS={x=unitWorldSize*8/5,y=unitWorldSize*8/5}
-- Attratif
MetaManAttFieldS={x=unitWorldSize*8,y=unitWorldSize*8/5}
-- Reuplsif
MetaManRepFieldS={x=unitWorldSize*8,y=unitWorldSize*8/5}


-- Impulsion des sauts
MetalManJumpImpulse ={Alu=(-10*unitWorldSize/MetalMTypes.Alu/7),Acier=(-50*unitWorldSize/MetalMTypes.Acier/10)}

-- Deplacement
-- Force de déplacement en fonction du matériaux
MetalManMovingForce={Alu=unitWorldSize*50,Acier=unitWorldSize*100}
-- Taux de réduction de la vitesse
MetalManBreakFactor=2
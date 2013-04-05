--[[ 
This file is part of the Field project]]


-- Métaux masse
MetalMTypes= {
	Alu = 0.05,
	Acier = 0.1
}

-- Puissance des champs
-- Rotatifs (les deux)
MetaManRotFieldS={x=unitWorldSize,y=unitWorldSize*4/3}
-- Attractif
MetaManAttFieldS={x=unitWorldSize*8,y=unitWorldSize*4/3}
-- Repulsif
MetaManRepFieldS={x=unitWorldSize*6,y=unitWorldSize*2.5}


-- Impulsion des sauts
MetalManJumpImpulse ={
	Alu =   ( -10 * unitWorldSize / MetalMTypes.Alu / 7 ),
	Acier = ( -50 * unitWorldSize / MetalMTypes.Acier / 11 )
}

-- Déplacement
-- Vitesse max
MetalManMaxSpeed=unitWorldSize*10
-- Force de déplacement en fonction du matériaux
MetalManMovingForce={Alu=unitWorldSize*50,Acier=unitWorldSize*100}
-- Taux de réduction de la vitesse
MetalManBreakFactor=2
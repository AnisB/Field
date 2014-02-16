--[[ 
This file is part of the Field project]]


-- Métaux masse
MetalMTypes= {
	Alu = 0.2,
	Acier = 0.5
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
	Alu =   ( -25 * unitWorldSize / MetalMTypes.Alu ),
	Acier = ( -25 * unitWorldSize / MetalMTypes.Acier )
}

-- Déplacement
-- Vitesse max
MetalManMaxSpeed=unitWorldSize*10
-- Force de déplacement en fonction du matériaux
MetalManMovingForce={Alu=unitWorldSize*250,Acier=unitWorldSize*250}
-- Taux de réduction de la vitesse
MetalManBreakFactor=5
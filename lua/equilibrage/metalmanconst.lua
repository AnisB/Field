--[[ 
This file is part of the Field project]]


-- Métaux masse
MetalMTypes= {
	-- Alu = 0.2,
	Alu = 1,
	Acier = 0.25
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
	-- Alu =   ( -27 * unitWorldSize / MetalMTypes.Alu ),
	Alu =   ( -700 * unitWorldSize / MetalMTypes.Alu ),
	Acier = ( -400 * unitWorldSize / MetalMTypes.Acier )
}

-- Déplacement
-- Vitesse max
MetalManMaxSpeed=unitWorldSize*10
-- Force de déplacement en fonction du matériaux
MetalManMovingForce={Alu=unitWorldSize*2500,Acier=unitWorldSize*150}
-- Taux de réduction de la vitesse
MetalManBreakFactor=6
--[[ 
This file is part of the Fiels project
]]

MagnetManagerSolo = {}
MagnetManagerSolo.__index =  MagnetManagerSolo

FieldTypes ={None='None',Static='Static', RotativeL ='RotativeL', RotativeR='RotativeR', Repulsive='Repulsive', Attractive='Attractive'}
MetalTypes ={Normal='Normal',Static='Static'}
function MagnetManagerSolo.new(options)
    local self = {}
    setmetatable(self, MagnetManagerSolo)
    self.passiveGenerators={}
    self.activeGenerators={}
    self.normalMetals={}
    self.staticMetals={}
    return self
end




function MagnetManagerSolo:update(dt)

-- Managing
	for i,g in ipairs(self.passiveGenerators) do
		if g.appliesField  then
			table.insert(self.activeGenerators,g)
			table.remove(self.passiveGenerators,i)
		end
	end
	for i,g in ipairs(self.activeGenerators) do
		if not g.appliesField  then
			table.insert(self.passiveGenerators,g)
			table.remove(self.activeGenerators,i)
		end
	end


	    for i,g in ipairs(self.activeGenerators) do
			for i,m in ipairs(self.normalMetals) do
				if g:isAppliable(m:getPosition())  then
					if g.fieldType==FieldTypes.Static then
						g:addStatMetal(m)
						m:staticField()
					elseif g.fieldType==FieldTypes.RotativeL then
						m:rotativeLField(g:getPosition(),dt*60)
					elseif g.fieldType==FieldTypes.RotativeR then
						m:rotativeRField(g:getPosition(),dt*60)
					elseif g.fieldType==FieldTypes.Repulsive then
						m:repulsiveField(g:getPosition(),dt*60)
					elseif g.fieldType==FieldTypes.Attractive then
						m:attractiveField(g:getPosition(),dt*60)
					end	
				end		
			end

			for i,m in ipairs(self.staticMetals) do
				if g:isAppliable(m:getPosition())  then
					if g.fieldType==FieldTypes.RotativeL then
						g:rotativeLField(m:getPosition(),dt*60)
					elseif g.fieldType==FieldTypes.RotativeR then
						g:rotativeRField(m:getPosition(),dt*60)
					elseif g.fieldType==FieldTypes.Repulsive then
						g:repulsiveField(m:getPosition(),dt*60)
					elseif g.fieldType==FieldTypes.Attractive then
						g:attractiveField(m:getPosition(),dt*60)
					end	
				end		
			end
		end
end


function MagnetManagerSolo:enableG(GID)
	for i,v in pairs(self.passiveGenerators) do
		print ("Recherche de ", GID,v.id)
		if v.id == GID then

			v:enableG()
			done = true
		end
	end
	if done then
        for i,p in pairs(gameStateManager.state["GameplaySolo"].mapLoader.gateinterruptors) do
            if(p.generatorID==id) then
                p:syncronizeState(false)
            end
        end
    end
end

function MagnetManagerSolo:disableG(GID)
	for i,v in pairs(self.activeGenerators) do
		print ("Recherche de ", GID,v.id)
		if v.id == GID then
			v:disableG()
			done = true
		end
	end
	if done then
        for i,p in pairs(gameStateManager.state["GameplaySolo"].mapLoader.gateinterruptors) do
            if(p.generatorID==id) then
                p:syncronizeState(false)
            end
        end
    end
end




function MagnetManagerSolo:changeMetalType(metal,oldType,newType)
	if oldType==MetalTypes.Normal then
		for i,g in ipairs(self.normalMetals) do
			if  g==metal then
				if newType==MetalTypes.Static then
					table.insert(self.staticMetals,g)
				end
				table.remove(self.normalMetals,i)
			end
		end
	elseif oldType==MetalTypes.Static then
		for i,g in ipairs(self.staticMetals) do
			if  g==metal then
				if newType==MetalTypes.Normal then
					table.insert(self.normalMetals,g)
				end
				table.remove(self.staticMetals,i)
			end
		end
	end
end

function MagnetManagerSolo:addGenerator(newG)
	table.insert(self.passiveGenerators,newG)
end

function MagnetManagerSolo:addMetal(newM)
	if newM.metalType == MetalTypes.Normal then
	table.insert(self.normalMetals,newM)
	elseif  newM.metalType == MetalTypes.Static then
	table.insert(self.staticMetals,newM)
	end
end



function MagnetManagerSolo:draw()
end
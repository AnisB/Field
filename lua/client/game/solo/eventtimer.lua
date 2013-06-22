--[[ 
This file is part of the Field project
]]


EventTimer = {}
EventTimer.__index =  EventTimer

EventTimer.Actions={Shutdown = 0, Start = 1, Switch = 2}

function EventTimer.new(id, duration,  enabled, loop, actions, mapLoader, magnetManager)
    local self = {}
    setmetatable(self, EventTimer)

    -- Init self attributes
    if enabled == "true" then
    	self.enabled = true
    else
    	self.enabled = false
    end
    self.id=id
    self.duration = tonumber(duration)
    self.type="EventTimer"
    self.timer = 0
    if loop == "true" then
    	self.loop = true
    else
    	self.lopp = false
    end

    -- Init possible actions
    self.generators={}
    self.gates={}
    self.arcs={}
    self.timers ={}

    -- Parse params
    self:parseParams(actions)

    -- Accessors
    self.mapLoader = mapLoader
    self.magnetManager = magnetManager


    return self
end

function EventTimer:executeActions()

	-- Tests
	-- if k[2] = EventTimer.Actions.Shutdown then
	-- elseif k[2] = EventTimer.Actions.Start
	-- elseif k [2] = EventTimer.Actions.Switch
	-- end
	
	for i,k in pairs(self.generators) do
		if k[2] == EventTimer.Actions.Shutdown then
			self.mapLoader:disableGene(k[1])
		elseif k[2] == EventTimer.Actions.Start then
			self.mapLoader:enableGene(k[1])
		elseif k[2] == EventTimer.Actions.Switch then
			self.mapLoader:switchGene(k[1])

		end
	end

	for i,k in pairs(self.gates) do
		if k[2] == EventTimer.Actions.Shutdown then
			self.mapLoader:closeG(k[1])
		elseif k[2] == EventTimer.Actions.Start then
			self.mapLoader:openG(k[1])
		elseif k [2] == EventTimer.Actions.Switch then
			self.mapLoader:switchG(k[1])
		end
	end

	for i,k in pairs(self.arcs) do
		if k[2] == EventTimer.Actions.Shutdown then
			self.mapLoader:disableA(k[1])
		elseif k[2] == EventTimer.Actions.Start then
			self.mapLoader:enable1(k[1])
		elseif k[2] == EventTimer.Actions.Switch then
			self.mapLoader:switchA(k[1])
		end
	end

	for i,k in pairs(self.timers) do
		if k[2] == EventTimer.Actions.Shutdown then
			self.mapLoader:disableT(k[1])
		elseif k[2] == EventTimer.Actions.Start then
			self.mapLoader:ensableT(k[1])
		elseif k [2] == EventTimer.Actions.Switch then
			self.mapLoader:switchT(k[1])
		end
	end
end

function EventTimer:getArgs(string)
	local ret ={}
	for i in string.gmatch(string, "([^@]+)") do
		table.insert(ret, tonumber(i))
	end
	return ret
end

function EventTimer:parseParams(Actions)


	if Actions["Generators"] ~= nil then
		print("Il y a des generateurs dans ce timer")
		for k in string.gmatch(Actions["Generators"], "([^#]+)") do
			local generator = self:getArgs(k)
			assert(#generator == 2)
			table.insert(self.generators,generator)
		end
	end

	if Actions["Arcs"] ~= nil then
		print("Il y a des arcs dans ce timer")
		for k in string.gmatch(Actions["Arcs"], "([^#]+)") do
			local arc = self:getArgs(k)
			assert(#arc == 2)
			table.insert(self.arcs,arc)
		end
	end

	if Actions["Gates"] ~= nil then
		print("Il y a des doors dans ce timer")
		for k in string.gmatch(Actions["Gates"], "([^#]+)") do
			local gate = self:getArgs(k)
			assert(#gate == 2)
			table.insert(self.gates,gate)
			-- print(gate[1],gate[2])
		end
	end


	if Actions["Timers"] ~= nil then
		print("Il y a des timers dans ce timer")
		for k in string.gmatch(Actions["Timers"], "([^#]+)") do
			local timer = self:getArgs(k)
			assert(#timer == 2)
			table.insert(self.timer,timer)
			-- print(gate[1],gate[2])
		end
	end


end


function EventTimer:update(dt)
	if self.enabled then
		self.timer = self.timer+dt
		if  self.timer >= self.duration then
			self:executeActions()
			if self.loop then
				self.timer =0
			else
				self.enabled = false
			end
		end
	end
end
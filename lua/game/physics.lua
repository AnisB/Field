	world=nil

	Physics = {}

	Physics.__index = Physics


	function  Physics.newCharacter(x, y, radius, isStatic)
		local pc = {}
		setmetatable(pc, Physics)
		pc.shape = love.physics.newCircleShape(radius-1)
		if isStatic == true then
			pc.body = love.physics.newBody(world, x, y)
		else
			pc.body = love.physics.newBody(world, x, y, "dynamic")
		end	
	pc.fixture = love.physics.newFixture(pc.body, pc.shape, 10) -- Attach fixture to body and give it a density of 1 (rigid body)
	pc.fixture:setFilterData(1,1,-1)
	pc.body:setFixedRotation(true)
	pc.fixture:setFriction(0.5)
	pc.body:setInertia(1.0)
	return pc
end

function  Physics.newSphere(x, y, radius, isStatic)
	local pc = {}
	setmetatable(pc, Physics)
	pc.shape = love.physics.newCircleShape(radius-1)
	if isStatic == true then
		pc.body = love.physics.newBody(world, x, y)
	else
		pc.body = love.physics.newBody(world, x, y, "dynamic")
	end	
	pc.fixture = love.physics.newFixture(pc.body, pc.shape, 10) -- Attach fixture to body and give it a density of 1 (rigid body)
	pc.body:setFixedRotation(true)
	pc.fixture:setFriction(0.3)
	
	pc.body:setInertia(1.0)
	return pc
end

function Physics.newRectangle(x, y, w,l, isStatic,dec)
	print "cc"
	local pc = {}
	setmetatable(pc, Physics)
	pc.shape = love.physics.newRectangleShape( dec[1], dec[2], w, l, 0 )
	if isStatic == true then
		pc.body = love.physics.newBody(world, x , y)
	else
		pc.body = love.physics.newBody(world, x, y, "dynamic")
	end	
	pc.fixture = love.physics.newFixture(pc.body, pc.shape, 10) -- Attach fixture to body and give it a density of 1 (rigid body)
	pc.body:setFixedRotation(false)
	pc.fixture:setFriction(0.5)
	pc.body:setInertia(0.0)
	return pc
end

function Physics.newInterruptor(x, y, w,l, isStatic,dec)
	local pc = {}
	setmetatable(pc, Physics)
	pc.shape = love.physics.newRectangleShape( dec[1], dec[2], w, l, 0 )
	if isStatic == true then
		pc.body = love.physics.newBody(world, x , y)
	else
		pc.body = love.physics.newBody(world, x, y, "dynamic")
	end	
	pc.fixture = love.physics.newFixture(pc.body, pc.shape, 0) -- Attach fixture to body and give it a density of 1 (rigid body)
	pc.fixture:setSensor(true)
	pc.body:setFixedRotation(false)
	pc.fixture:setFriction(0.5)
	pc.body:setInertia(0.0)
	return pc
end


function Physics.newAcid(x, y, w,l,dec)
	local pc = {}
	setmetatable(pc, Physics)
	pc.shape = love.physics.newRectangleShape( dec[1], dec[2], w, l, 0 )
	pc.body = love.physics.newBody(world, x , y)
	pc.fixture = love.physics.newFixture(pc.body, pc.shape, 0) -- Attach fixture to body and give it a density of 1 (rigid body)
	pc.fixture:setSensor(true)
	pc.body:setFixedRotation(false)
	pc.fixture:setFriction(0.5)
	pc.body:setInertia(0.0)
	return pc
end
	function Physics.newArc(x, y, w,l,dec)
		local pc = {}
		setmetatable(pc, Physics)
		pc.shape = love.physics.newRectangleShape( dec[1], dec[2], w, l, 0 )
		pc.body = love.physics.newBody(world, x , y)
	pc.fixture = love.physics.newFixture(pc.body, pc.shape, 0) -- Attach fixture to body and give it a density of 1 (rigid body)
	pc.fixture:setSensor(true)
	pc.body:setFixedRotation(false)
	pc.fixture:setFriction(0.5)
	pc.body:setInertia(0.0)
	return pc
end


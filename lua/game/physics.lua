

world=nil

Physics = {}

Physics.__index = Physics

function  Physics.newSphere(x, y, radius, isStatic)
	local pc = {}
	setmetatable(pc, Physics)
	pc.shape = love.physics.newCircleShape(radius)
	if isStatic == true then
		pc.body = love.physics.newBody(world, x, y)
	else
		pc.body = love.physics.newBody(world, x, y, "dynamic")
	end	
	pc.fixture = love.physics.newFixture(pc.body, pc.shape, 10) -- Attach fixture to body and give it a density of 1 (rigid body)
	pc.body:setFixedRotation(true)
	pc.fixture:setFriction(0.5)
	pc.body:setInertia(1.0)
	return pc
end

 function Physics.newRectangle(x, y, w,l, isStatic,dec)
	local pc = {}
	setmetatable(pc, Physics)
	pc.shape = love.physics.newRectangleShape( dec[1], dec[2], w, l, 0 )
	if isStatic == true then
		pc.body = love.physics.newBody(world, x , y)
	else
		pc.body = love.physics.newBody(world, x, y, "dynamic")
	end	
	pc.fixture = love.physics.newFixture(pc.body, pc.shape, 1) -- Attach fixture to body and give it a density of 1 (rigid body)
	pc.body:setFixedRotation(false)
	pc.fixture:setFriction(0.5)
	pc.body:setInertia(0.0)
	return pc
end


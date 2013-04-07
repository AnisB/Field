require("lubeboth.class")

AttenteTest = {}

function AttenteTest:init()
	self.x = 42
end

function AttenteTest:update(dt)
	-- print("Weeee !", dt)
end

function AttenteTest:draw()
end

function AttenteTest:onMessage(msg, client)
	if msg.type == "login" then
		gameStateManager:changeState("Gameplay")
		client:send({type= "attenteFinie"})
	else
		debug_warn("[login] wrong type")
	end
end

AttenteTest = common.class("AttenteTest", AttenteTest)
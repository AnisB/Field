package.path = "../lubeboth/?.lua;" .. package.path
require("class")
require("lube")
require("TSerial")
require("client")
cron = require("cron")
table2 = require("table2")

-- "low level" events :

function rcvCallback(data)
    serveur:gotData(data, onConnect)
end

-- "high level" events :

function onMessage(msg)
	print("Received : " .. table2.tostring(msg))
end

function gen_cookie()
    local length = 32
    local cookie = ""
    for i=0, length do
        local n = math.random(65+32, 65+32+25)
        cookie = cookie .. string.char(n)
    end
    return cookie
end

function get_cookie()
	local savefile = gen_cookie()..".cookiesave" -- "cookie.save"
	if not love.filesystem.exists(savefile) then
		love.filesystem.write(savefile, TSerial.pack({cookie= gen_cookie()}))
	end
	local c = TSerial.unpack(love.filesystem.read(savefile))
	return c.cookie
end

-- love stuff :

function love.load()
    --do anything else you need to do here
    print("loading...")
    conn = lube.tcpClient()
	conn.handshake = "hello"
	serveur = common.instance(Client, conn) -- oui, le serveur est un "client" :)
	assert(conn:connect("localhost", 3410, true))
	conn.callbacks.recv = rcvCallback

	local function popMsg()
		local toSend = {
			type= "login",
			cookie= get_cookie(),
			pseudo= "luc"
		}
		serveur:send(toSend)
		cron.after(math.random(1, 3), popMsg)
	end
	cron.after(math.random(1, 3), popMsg)
end

function love.update(dt)
    conn:update(dt)
    cron.update(dt)
    --anything else
end

function love.keypressed(key, unicode)
	if key == "escape" then
		love.event.push("quit")
	end
end

function love.quit()
	conn:disconnect()
end
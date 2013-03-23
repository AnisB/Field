Client = {}

function Client:init(conn, clientid)
	self.conn = conn
	self.id = clientid
	self._rcv = ""
	self._size_remain = 0
end

function Client:speak(blah)
    print("Client", self.id, "says", blah)
end

function Client:gotData(data, callback)
	-- stream to messages
	while data ~= "" do
		if self._size_remain == 0 then -- new message
			local msg = self._rcv .. data
			local found = msg:find("_")
			if found then
				local taille = msg:sub(0, found-1)
				data = msg:sub(found+1)
				self._size_remain = tonumber(taille)
			else
				self._rcv = self._rcv .. data
				data = ""
			end
		else -- on attend la fin d'un msg
			if data:len() >= self._size_remain then
				self._rcv = self._rcv .. data:sub(0, self._size_remain)
				data = data:sub(self._size_remain+1)
				self._size_remain = 0
				local asTable = TSerial.unpack(self._rcv)
				self._rcv = ""
				onMessage(asTable, self)
			else
				self._rcv = self._rcv .. data
				self._size_remain = self._size_remain - data:len()
				data = ""
			end
		end
	end
end

function Client:send(aTable)
	local str = TSerial.pack(aTable)
	str = tostring(str:len()) .. "_" .. str
	self.conn:send(str, self.id)
end

Client = common.class("Client", Client)
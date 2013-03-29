function load_history(cook1, cook2)
	local savefile = "fieldServerHistory.save"
	if not love.filesystem.exists(savefile) then
		love.filesystem.write(savefile, TSerial.pack({}))
	end
	local h = TSerial.unpack(love.filesystem.read(savefile))
	for k,v in pairs(h) do
		if v.cookie1 == cook1 and v.cookie2 == cook2 then
			return v.player1, v.player2
		elseif v.cookie2 == cook1 and v.cookie1 == cook2 then
			return v.player2, v.player1
		end
	end
	return {}, {}
end

function save_history(cook1, cook2, hist1, hist2)
	local savefile = "fieldServerHistory.save"
	local h = TSerial.unpack(love.filesystem.read(savefile))
	for k,v in pairs(h) do
		if v.cookie1 == cook1 and v.cookie2 == cook2 then
			v.player1 = hist1
			v.player2 = hist2
			return love.filesystem.write(savefile, TSerial.pack(h))
		elseif v.cookie2 == cook1 and v.cookie1 == cook2 then
			v.player1 = hist2
			v.player2 = hist1
			return love.filesystem.write(savefile, TSerial.pack(h))
		end
	end
	h[#h] = {player1=hist1, player2=hist2, cookie1=cook1, cookie2=cook2}
	return love.filesystem.write(savefile, TSerial.pack(h))
end
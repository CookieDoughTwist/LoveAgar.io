local socket = require 'socket'
 
local udp = socket.udp()

-- non-blocking read (immediate timeout)
udp:settimeout(0)
 
-- use all addresses (the *)
udp:setsockname('*', 12345)
 

local data, msg_or_ip, port_or_nil
local entity, cmd, parms

local running = true
 

local DT = 0.1
local initTime = socket.gettime()
local lastLoopEndTime = initTime
local loopEndTime = initTime

while running do

	data, msg_or_ip, port_or_nil = udp:receivefrom()
	
	if data then
		print(data)
		io.flush()
	elseif msg_or_ip ~= 'timeout' then
		error("Unhandled network error: " .. tostring(msg))
	end

	loopEndTime = socket.gettime()
	local loopTimeLeft = DT - (loopEndTime - lastLoopEndTime)
	lastLoopEndTime = loopEndTime

	if loopTimeLeft > 0 then
		socket.sleep(loopTimeLeft)
	end
end



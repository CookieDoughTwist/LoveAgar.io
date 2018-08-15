
function serverLoop(udp, dt)

	local initTime = socket.gettime()
	local lastLoopEndTime = initTime
	local loopEndTime = initTime

	local running = true

	local data, msg_or_ip, port_or_nil
	local entity, cmd, parms

	while running do

		data, msg_or_ip, port_or_nil = udp:receivefrom()

		while msg_or_ip ~= 'timeout' do
			-- TODO: check logic on this one 8/15/18 -AW		
			if not data then
				error("Unhandled network error: " .. tostring(msg_or_ip))
			end
			print('data')
			print(data)
			print(msg_or_ip)
			print(port_or_nil)
			print()
			io.flush()
			data, msg_or_ip, port_or_nil = udp:receivefrom()
		end
			

		loopEndTime = socket.gettime()
		local loopTimeLeft = dt - (loopEndTime - lastLoopEndTime)
		lastLoopEndTime = loopEndTime

		if loopTimeLeft > 0 then
			socket.sleep(loopTimeLeft)
		end
	end
end

socket = require 'socket'
 
local udp = socket.udp()

-- non-blocking read (immediate timeout)
udp:settimeout(0)
 
-- use all addresses (the *)
udp:setsockname('*', 12345)

local DT = 0.1

serverLoop(udp, DT)

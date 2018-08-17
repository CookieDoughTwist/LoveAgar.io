


function serverLoop(server, dt)

	local initTime = socket.gettime()
	local lastLoopEndTime = initTime
	local loopEndTime = initTime

	local running = true

	local data, msg_or_ip, port_or_nil
	local entity, cmd, parms

	while running do

		loopEndTime = socket.gettime()
		local loopTimeLeft = dt - (loopEndTime - lastLoopEndTime)
		lastLoopEndTime = loopEndTime

		server:update()

		if loopTimeLeft > 0 then
			socket.sleep(loopTimeLeft)
		end
	end
end

-- libraries
Class = require 'lib/class'
socket = require 'socket'

-- classes
require 'Server'
 
local server = Server()

local DT = 0.1

serverLoop(server, DT)

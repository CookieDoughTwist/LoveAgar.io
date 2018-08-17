Server = Class()

function Server:init()
    self.udp = socket.udp()
    -- non-blocking read (immediate timeout)
    self.udp:settimeout(0)

    -- use all addresses (the *)
    -- TODO: remove hardcoding 8/17/18 -AW
    self.udp:setsockname('*', 12345)
end

function Server:update()
    local data, msg_or_ip, port_or_nil = self.udp:receivefrom()

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

            local words = {}
			words[1], words[2] = data:match("(%w+)(.+)")

			data, msg_or_ip, port_or_nil = self.udp:receivefrom()
        end
        
end
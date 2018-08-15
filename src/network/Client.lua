Client = Class()

function Client:init(address, port)
    self.address = address
    self.port = port
    self:startUDP()
end

function Client:startUDP()
    self.udp = socket.udp()
    self.udp:settimeout(0)
    self.udp:setpeername(self.address, self.port)
end

function Client:send(message)
    self.udp:send(message)
end

function Client:receive()
    local data, message = self.udp.receive()

    if data then
        return data

    -- TODO: more robust error handling 8/14/18 -AW
    elseif message ~= 'timeout' then
        error("Unhandled network error: " .. tostring(msg))
    end

    return nil
end

function Client:receiveAll()
    local dataTable = {}

    local data = self:receive()

    while data do
        table.insert(dataTable, data)
        data = data:receive()
    end

    return dataTable
end
PlayerClient = Class{__includes = Client}

function PlayerClient:init()
    -- TODO: remove hard coding 8/14/18 -AW
    Client.init(self, 'localhost', 12345)
end

function PlayerClient:sendHELO()
    local message = string.format(HELO_FMT, 'boo')
    print(message)
    io.flush()
    self:send(message)
end
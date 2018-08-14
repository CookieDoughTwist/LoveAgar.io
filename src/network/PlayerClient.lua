PlayerClient = Class{__includes = Client}

function PlayerClient:init(name)
    -- TODO: remove hard coding 8/14/18 -AW
    Client.init(self, 'localhost', 12345)

    self.name = name
    self.connected = false
end

function PlayerClient:sendHELO()
    local message = string.format(HELO_FMT, self.name)

    self:send(message)
end
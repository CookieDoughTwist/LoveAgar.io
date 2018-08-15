PlayerClient = Class{__includes = Client}

function PlayerClient:init(name)
    -- TODO: remove hard coding 8/14/18 -AW
    Client.init(self, 'localhost', 12345)
    
    self.name = name
    self.connected = false
    self.protocolState = 'connecting'
    self.lastUpdateElapsed = math.huge
end

function PlayerClient:update(dt)
    self.lastUpdateElapsed = self.lastUpdateElapsed + dt
    local receives = self.receiveAll()

    if self.protocolState == 'connecting' then

        if self.lastUpdateElapsed > RESEND_INTERVAL then
            self:sendHELO()
        end
    elseif self.protocolState == 'play' then
    else
        error(string.format("Unhandled protocol: %s", self.protocolState))
    end
end

function PlayerClient:sendHELO()
    local message = string.format(HELO_FMT, self.name)

    self:send(message)
end
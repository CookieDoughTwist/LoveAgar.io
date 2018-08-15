PlayerClientConnectingState = Class{__includes = BaseState}

function PlayerClientConnectingState:init(client)
    self.client = client
    self.lastSendElapsed = math.huge
end

function PlayerClientConnectingState:update(dt)

    self.lastSendElapsed = self.lastSendElapsed + dt

    if self.client.receivedMessages then

    end

    if self.lastSendElapsed > RESEND_INTERVAL then
        self.client:sendHELO()
        self.lastSendElapsed = 0
    end

end
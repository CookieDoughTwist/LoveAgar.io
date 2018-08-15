PlayerClientConnectingState = Class{__includes = BaseState}

function PlayerClientConnectingState:init(client)
    self.client = client
end

function PlayerClientConnectingState:update(dt)

    local client = self.client
    client:sendHELO()

end
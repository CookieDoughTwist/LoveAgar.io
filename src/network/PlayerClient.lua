PlayerClient = Class{__includes = Client}

function PlayerClient:init(name)
    -- TODO: remove hard coding 8/14/18 -AW
    Client.init(self, 'localhost', 12345)
    
    self.name = name
    self.connected = false
    self.stateMachine = StateMachine {
        ['connecting'] = function() return PlayerClientConnectingState(self) end,
        ['play'] = function() return PlayerClientPlayState(self) end,
    }
    
    self:changeState('connecting')
    self.receivedMessages = {}
end

function PlayerClient:update(dt)
        
    self.receivedMessages = self:receiveAll()

    self.stateMachine:update()
end

function PlayerClient:changeState(name)
    self.stateMachine:change(name)
end

function PlayerClient:sendHELO()
    local message = string.format(HELO_FMT, self.name)

    self:send(message)
end
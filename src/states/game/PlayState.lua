PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.engine = Engine()
    self.name = ''    
end

function PlayState:enter(params)

    self.name = params.name
    self.client = PlayerClient(self.name)
end

function PlayState:update(dt)
    self.client:update(dt)
    self.engine:update(dt)
end

function PlayState:render()
    self.engine:render()
end
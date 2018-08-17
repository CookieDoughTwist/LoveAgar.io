Entity = Class()

function Entity:init(x, y, mass)
    self.x = x
    self.y = y
    self.mass = mass
    self.dx = 0
    self.dy = 0
end

function Entity:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end
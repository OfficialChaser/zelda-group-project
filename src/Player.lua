--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Player = Class{__includes = Entity}

function Player:init(def)
    Entity.init(self, def)
    self:goInvulnerable(1.5)
    self.roomCounter = def.roomCounter or 0
    -- cooldown for throwing rocks (seconds)
    self.throwCooldown = 1.5
    self.throwTimer = 0
end

function Player:update(dt)
    Entity.update(self, dt)
    -- decrement throw timer
    if self.throwTimer > 0 then
        self.throwTimer = math.max(0, self.throwTimer - dt)
    end
end

function Player:collides(target)
    local selfY, selfHeight = self.y + self.height / 2, self.height - self.height / 2
    
    return not (self.x + self.width < target.x or self.x > target.x + target.width or
                selfY + selfHeight < target.y or selfY > target.y + target.height)
end

function Player:render()
    Entity.render(self)
    
    -- love.graphics.setColor(255, 0, 255, 255)
    -- love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
    -- love.graphics.setColor(255, 255, 255, 255)
end
--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Projectile = Class{}

function Projectile:init(def)
    self.x = def.x
    self.y = def.y
    self.width = def.width or (PROJECTILE_DEFS[def.type] and PROJECTILE_DEFS[def.type].width) or 8
    self.height = def.height or (PROJECTILE_DEFS[def.type] and PROJECTILE_DEFS[def.type].height) or 8
    self.dx = def.dx or 0
    self.dy = def.dy or 0
    self.speed = def.speed or (PROJECTILE_DEFS[def.type] and PROJECTILE_DEFS[def.type].speed) or 50
    self.damage = def.damage or (PROJECTILE_DEFS[def.type] and PROJECTILE_DEFS[def.type].damage) or 1
    self.type = def.type
    self.lifespan = def.lifespan or (PROJECTILE_DEFS[def.type] and PROJECTILE_DEFS[def.type].lifespan) or 2
    self.age = 0
    -- rotation
    self.angle = 0
    -- angular speed in radians per second (randomize a bit for variety)
    self.angularSpeed = def.angularSpeed or (math.random() * 6 - 3) -- between -3 and 3 rad/s
end

function Projectile:update(dt)
    -- move
    self.x = self.x + self.dx * self.speed * dt
    self.y = self.y + self.dy * self.speed * dt

    -- rotate
    self.angle = self.angle + self.angularSpeed * dt

    -- age and expire
    self.age = self.age + dt
    if self.age > self.lifespan then
        self.dead = true
    end
end

function Projectile:render(adjacentOffsetX, adjacentOffsetY)
    local ax, ay = adjacentOffsetX or 0, adjacentOffsetY or 0
    -- draw a simple rectangle if no frame specified
    if PROJECTILE_DEFS[self.type] and PROJECTILE_DEFS[self.type].frame and gFrames[PROJECTILE_DEFS[self.type].texture] then
        local def = PROJECTILE_DEFS[self.type]
        -- draw rotated about center
        local ox = self.width / 2
        local oy = self.height / 2
        love.graphics.draw(gTextures[def.texture], gFrames[def.texture][def.frame], math.floor(self.x - ax + ox), math.floor(self.y - ay + oy), self.angle, 1, 1, ox, oy)
    else
        love.graphics.setColor(120/255, 120/255, 120/255, 1)
        -- rotate rectangle about center
        love.graphics.push()
        love.graphics.translate(math.floor(self.x - ax + self.width / 2), math.floor(self.y - ay + self.height / 2))
        love.graphics.rotate(self.angle)
        love.graphics.rectangle('fill', -self.width / 2, -self.height / 2, self.width, self.height)
        love.graphics.pop()
        love.graphics.setColor(1,1,1,1)
    end
end

function Projectile:collides(target)
    return not (self.x + self.width < target.x or self.x > target.x + target.width or
                self.y + self.height < target.y or self.y > target.y + target.height)
end

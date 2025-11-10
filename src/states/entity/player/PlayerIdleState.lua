--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerIdleState = Class{__includes = EntityIdleState}

function PlayerIdleState:init(player, dungeon)
    -- call base init to set idle animation and timers
    EntityIdleState.init(self, player)
    self.dungeon = dungeon
    -- render offset for spaced character sprite (negated in render function of state)
    self.entity.offsetY = 5
    self.entity.offsetX = 0
end

function PlayerIdleState:enter(params)
    -- noop
end

function PlayerIdleState:update(dt)
    if love.keyboard.isDown('left') or love.keyboard.isDown('a') or love.keyboard.isDown('right') or love.keyboard.isDown('d') or
       love.keyboard.isDown('up') or love.keyboard.isDown('w') or love.keyboard.isDown('down') or love.keyboard.isDown('s') then
        self.entity:changeState('walk')
    end

    if love.keyboard.wasPressed('space') then
        self.entity:changeState('swing-sword')
    end

    -- throw rock with 'f'
    if love.keyboard.wasPressed('f') then
        local dir = self.entity.direction
        local dx, dy = 0, 0
        if dir == 'left' then dx = -1
        elseif dir == 'right' then dx = 1
        elseif dir == 'up' then dy = -1
        else dy = 1 end

        -- cooldown check
        if self.entity.throwTimer == 0 then
            local room = self.dungeon.currentRoom
            if not room.projectiles then room.projectiles = {} end
            local px = self.entity.x + self.entity.width / 2 - 8
            local py = self.entity.y + self.entity.height / 2 - 8
            table.insert(room.projectiles, Projectile {
                x = px,
                y = py,
                dx = dx,
                dy = dy,
                type = 'rock'
            })
            if gSounds['bowler'] then gSounds['bowler']:play() end
            self.entity.throwTimer = self.entity.throwCooldown
        end
    end
end
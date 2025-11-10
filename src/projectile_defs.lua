-- Projectile definitions
PROJECTILE_DEFS = {
    ['rock'] = {
        texture = 'rock', -- use dedicated rock sprite
        frame = 1, -- first (and only) frame
        speed = 25, -- slower moving rock
        damage = 3, -- high damage
        width = 16,
        height = 16,
        lifespan = 3.5 -- seconds before disappearing
    }
}

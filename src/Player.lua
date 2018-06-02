local MOVE_MAP = {
    [1] = function(self) return { y = self.y + MAPSIZE } end,
    [2] = function(self) return { x = self.x - MAPSIZE } end,
    [3] = function(self) return { y = self.y - MAPSIZE } end,
    [4] = function(self) return { x = self.x + MAPSIZE } end,
}

local Player = function(def)
    local player = {
        x = def.x,
        y = def.y,
        scale = def.scale or SCALE,

        moving = false,
        animation = Animation {
            frames = {1, 2, 3},
            delay = 0.2,
        },
        facing = 1,
        tween = Tween(),
    }


    local function move(self)
        self.moving = true
        self.tween:start({
            timer = 0.6,
            subject = self,
            target = MOVE_MAP[self.facing](self),
        }):after(function() self.moving = false end)
    end

    function player:update(dt)
        self.animation:update(dt)
        self.tween:update(dt)

        for k, v in pairs(FACING_ENUM) do
            if love.keyboard.isDown(v) then
                self.facing = k
                if not self.moving then
                    move(self)
                end
            end
        end
    end

    function player:draw()
        love.graphics.draw(
            TILESHEET,
            CHAR_TILES[FACING_ENUM[self.facing]][self.animation:getFrame()],
            self.x,
            self.y,
            self.facing == 2 and math.pi or 0,
            self.scale,
            self.facing == 2 and -self.scale or self.scale,
            self.facing == 2 and 9 or 0
        )
    end

    return player
end

return Player

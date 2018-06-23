local function Level(def)
    local level = {
        map = def.map,
        tileset = def.tileset,
        tilesize = def.tilesize,
        scale = def.scale,
    }

    function level:update(dt)
    end

    function level:draw()
        for i = 1, #self.map do
            for j = 1, #self.map[i] do
                love.graphics.draw(
                    TILESHEET,
                    self.tileset[self.map[i][j]],
                    self.tilesize * (j - 1),
                    self.tilesize * (i - 1),
                    0,
                    self.scale
                )
            end
        end
    end

    return level
end

return Level

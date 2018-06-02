function Animation(def)
    local animation = {
        frames = def.frames or {1},
        delay = def.delay or 0.2,

        timer = 0,
        frame = 1,
    }

    function animation:update(dt)
        if #self.frames == 1 then
            return
        end

        if self.timer < self.delay then
            self.timer = self.timer + dt
        else
            self.timer = self.timer % self.delay
            self.frame = math.max(1, (self.frame + 1) % (#self.frames + 1))
        end

        return self.frames[self.frame]
    end

    function animation:getFrame()
        return self.frames[self.frame]
    end

    return animation
end

return Animation

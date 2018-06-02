-- t = time == running time. How much time has passed *right now*
-- b = begin == starting property value
-- c = change == ending - beginning
-- d = duration == how much time has to pass for the tweening to complete
local function linear(t, b, c, d) return c * t / d + b end

local function Tween()
    local tween = {
        activeTimers = {},
    }

    function tween:start(def)
        local timer = {
            timer = def.timer,
            subject = def.subject,
            target = def.target,
            easing = def.easing or linear,

            currentTime = 0,
            change = {},
        }

        function timer:after(cb)
            self.callback = cb
        end

        for k, v in pairs(timer.target) do
            timer.change[k] = timer.target[k] - timer.subject[k]
        end

        table.insert(self.activeTimers, timer)

        return timer
    end

    function tween:update(dt)
        for i = #self.activeTimers, 1, -1 do
            local activeTimer = self.activeTimers[i]
            if activeTimer.currentTime <= activeTimer.timer then
                activeTimer.currentTime = activeTimer.currentTime + dt
                for k, v in pairs(activeTimer.target) do
                    activeTimer.subject[k] = activeTimer.easing(activeTimer.currentTime, activeTimer.target[k] - activeTimer.change[k], activeTimer.change[k], activeTimer.timer)
                end
            else
                table.remove(self.activeTimers, i)
                if activeTimer.callback then
                    activeTimer.callback()
                end
            end
        end
    end

    return tween
end

return Tween

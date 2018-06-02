local Utils = {
    generateQuads = function (atlas, tileWidth, tileHeight)
        local quads = {}

        local width, height = atlas:getDimensions()
        local sheetWidth = width / tileWidth
        local sheetHeight = height / tileHeight
        local spriteCount = 1

        for y = 0, sheetHeight - 1 do
            for x = 0, sheetWidth - 1 do
                quads[spriteCount] = love.graphics.newQuad(x * tileWidth, y * tileHeight,
                    tileWidth, tileHeight, width, height)

                spriteCount = spriteCount + 1
            end
        end

        return quads
    end,

    generateQuadsFromTo = function(atlas, tileWidth, tileHeight, from, total, offset)
        from = from or { x = 0, y = 0 }
        total = total or -1
        offset = offset or { x = 0, y = 0 }

        local quads = {}
        local width, height = atlas:getDimensions()
        local sheetWidth = width / tileWidth
        local sheetHeight = height / tileHeight
        local spriteCount = 0

        (function()
            for y = from.y, sheetHeight - 1 do
                for x = from.x, sheetWidth - 1 do
                    spriteCount = spriteCount + 1
                    quads[spriteCount] = love.graphics.newQuad(x * (tileWidth + offset.x), y * (tileHeight + offset.y),
                        tileWidth, tileHeight, width, height)

                    if spriteCount >= total then
                        return
                    end
                end
            end
        end)()

        return quads
    end
}

return Utils

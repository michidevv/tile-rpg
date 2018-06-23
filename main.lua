require('src/dependencies')

local level = nil
local player = nil

function love.load()
    math.randomseed(os.time())
    love.window.setTitle('Tiles Generation POC')
    love.graphics.setDefaultFilter('nearest')

    TILESHEET = love.graphics.newImage('src/res/spritesheet.png')
    CHAR_TILES = {
        down = Utils.generateQuadsFromTo(TILESHEET, 10, 8, {x = 0, y = 20}, 3, {x = 1, y = 0}),
        right = Utils.generateQuadsFromTo(TILESHEET, 10, 8, {x = 0, y = 21}, 3, {x = 1, y = 0}),
        up = Utils.generateQuadsFromTo(TILESHEET, 10, 8, {x = 0, y = 22}, 3, {x = 1, y = 0}),
    }
    CHAR_TILES.left = CHAR_TILES.right

    GREEN_TILES = Utils.generateQuadsFromTo(TILESHEET, 8, 8, {x = 0, y = 2}, 6)

    level = Level {
        map = LevelGenerator.generate({w = 17, h = 17,}, function() return 1 end),
        tileset = GREEN_TILES,
        tilesize = DRAW_TILESIZE,
        scale = SCALE,
    }

    player = Player {
        x = 0,
        y = 0,
        scale = SCALE,
    }
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.update(dt)
    player:update(dt)
end

function love.draw()
    level:draw()
    player:draw()
end

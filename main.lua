require('src/dependencies')

local player = Player {
    x = 100,
    y = 100,
}

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

    GRID = {}
    for i = 1, MAPSIZE do
        GRID[i] = {}
        for j = 1, MAPSIZE do
            GRID[i][j] = math.random() > 0.9 and 16 or 13
        end
    end
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
    love.graphics.draw(TILESHEET, GREEN_TILES[1], 100, 100, 0, SCALE)
    love.graphics.draw(TILESHEET, GREEN_TILES[1], 100 + DRAW_TILESIZE, 100, 0, SCALE)
    love.graphics.draw(TILESHEET, GREEN_TILES[1], 100, 100 + DRAW_TILESIZE, 0, SCALE)
    love.graphics.draw(TILESHEET, GREEN_TILES[1], 100 + DRAW_TILESIZE, 100 + DRAW_TILESIZE, 0, SCALE)
    player:draw()
end

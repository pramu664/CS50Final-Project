if arg[2] == "debug" then
    require("lldebugger").start()
end

function love.load()
    Object = require "libraries.classic"
    player = require "player"
    apple = require "apple"

    love.graphics.setDefaultFilter("nearest", "nearest")
    player = Player()

    -- Create apples
    apples = {}
    for i = 1, 1000 do
        table.insert(apples, Apple())
    end

    -- OUTDOOR GROUND TILESET --

    -- Load the image
    tileset = love.graphics.newImage("assets/world/tileset.png")

    -- Get full width and height of the tileset
    tileset_width = tileset:getWidth()
    tileset_height = tileset:getHeight()

    -- Get one tile width and height
    tile_width = (tileset_width / 4) - 2
    tile_height = (tileset_height / 3) - 2

    -- Create quads
    quads = {}
    for i = 0, 2 do
        for j = 0, 3 do
            -- j for x, i for y
            table.insert(quads,
                love.graphics.newQuad(1 + j * (tile_width + 2), 1 + i * (tile_height + 2), tile_width, tile_height,
                    tileset_width, tileset_height))
        end
    end

    -- OUTDOOR OBJECT TILESET--

    -- Load outdoor tileset
    outdoor_ground_tileset = love.graphics.newImage("assets/world/outdoor_objects/outdoor_objects.png")

    -- Get the full width and height
    outdoor_ground_tileset_width = outdoor_ground_tileset:getWidth()
    outdoor_ground_tileset_height = outdoor_ground_tileset:getHeight()

    -- Get the tile width and height
    outdoor_ground_tile_width = outdoor_ground_tileset_width / 2
    outdoor_ground_tile_height = outdoor_ground_tileset_height / 2

    -- Slice tileset
    outdoor_ground_quads = {}
    for i = 0, 1 do
        for j = 0, 1 do
            table.insert(outdoor_ground_quads,
                love.graphics.newQuad(j * outdoor_ground_tile_width, i * outdoor_ground_tile_height,
                    outdoor_ground_tile_width, outdoor_ground_tile_height, outdoor_ground_tileset_width,
                    outdoor_ground_tileset_height))
        end
    end


    -- LEVEL --
    tilemap = {
        { 2, 2, 2, 2, 2, 2, 2, 2,  2,  2, 2, 2 },
        { 2, 8, 2, 2, 2, 2, 2, 2,  12, 2, 2, 2 },
        { 2, 2, 2, 2, 2, 2, 2, 2,  2,  2, 2, 2 },
        { 1, 1, 1, 1, 1, 1, 1, 1,  1,  4, 1, 1 },
        { 1, 1, 4, 1, 1, 4, 1, 1,  1,  1, 1, 1 },
        { 1, 1, 1, 1, 1, 1, 1, 1,  1,  1, 1, 1 },
        { 1, 1, 1, 1, 1, 1, 1, 1,  1,  1, 1, 1 },
        { 1, 7, 7, 1, 3, 3, 1, 11, 11, 1, 1, 1 },
        { 1, 7, 7, 1, 3, 3, 1, 11, 11, 1, 1, 5 },
    }

    -- State
    apples_collected = 0

    -- EFFECTS --
    -- Screenshake
    shakeDuration = 0
    shakeWait = 0
    shakeOffset = {x = 0, x = y}

end

function checkCollision(player, target)
    -- Get the player left, right, top and bottom  sides
    local player_left = player.x
    local player_left = player.x
    local player_right = player.x + player.width
    -- Don't detect collsion for the player's upper body
    local player_top = player.y + player.height / 2
    local player_bottom = player.y + player.height

    -- Get the target left, right, top and bottom sides
    local target_left = target.x
    local target_right = target.x + target.width
    local target_top = target.y
    local target_bottom = target.y + target.height

    -- Collision detection
    return player_right > target_left and player_left < target_right and player_bottom > target_top and
    player_top < target_bottom
end

function love.update(dt)
    player:update(dt)

    -- When player collecting apples remove them from the apple table
    for i = #apples, 1, -1 do
        if checkCollision(player, apples[i]) then
            table.remove(apples, i)
            apples_collected = apples_collected + 1
            shakeDuration = 0.3
        end
    end

    if shakeDuration > 0 then
        shakeDuration = shakeDuration - dt
        if shakeWait > 0 then
            shakeWait = shakeWait - dt
        else
            shakeOffset.x = love.math.random(-5, 5)
            shakeOffset.y = love.math.random(-5, 5)
            shakeWait = 0.05
        end
    end
end

-- Close
function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    elseif key == "f1" then
        love.event.quit("restart")
    end
end

function love.draw()


    -- Screenshake
    if shakeDuration > 0 then
        love.graphics.translate(shakeOffset.x, shakeOffset.y)
    end

    -- Draw level
    for i, row in ipairs(tilemap) do
        for j, tile in ipairs(row) do
            if tile ~= 0 then
                love.graphics.draw(tileset, quads[tile], j * tile_width * 4, i * tile_height * 4, 0, 4, 4)
            end
        end
    end

    -- Draw outdoor ground objects
    love.graphics.draw(outdoor_ground_tileset, outdoor_ground_quads[2], outdoor_ground_tile_width * 7, 16 * 5 * 4, 0, 5,
        5)
    love.graphics.draw(outdoor_ground_tileset, outdoor_ground_quads[1], outdoor_ground_tile_width * 8 * 5, 16 * 5 * 6, 0,
        8, 8)
    love.graphics.draw(outdoor_ground_tileset, outdoor_ground_quads[3], outdoor_ground_tile_width * 8 * 5, 16 * 5 * 5, 0,
        8, 8)
    love.graphics.draw(outdoor_ground_tileset, outdoor_ground_quads[4], outdoor_ground_tile_width * 8 * 5, 16 * 5 * 4, 0,
        8, 8)
    love.graphics.draw(outdoor_ground_tileset, outdoor_ground_quads[1], outdoor_ground_tile_width * 9 * 5, 16 * 5 * 6, 0,
        8, 8)
    love.graphics.draw(outdoor_ground_tileset, outdoor_ground_quads[3], outdoor_ground_tile_width * 9 * 5, 16 * 5 * 5, 0,
        8, 8)
    love.graphics.draw(outdoor_ground_tileset, outdoor_ground_quads[4], outdoor_ground_tile_width * 9 * 5, 16 * 5 * 4, 0,
        8, 8)

    -- Draw apples to the game world
    for i, v in ipairs(apples) do
        v:draw()
    end
    -- Draw player
    player:draw()

    -- Instructions
    love.graphics.print("Restart: f1" , 10, 10)
    love.graphics.print("Exit: esc", 10, 30)
    love.graphics.print("Goal: Collect Apples", 100, 10)
    love.graphics.print("Score: "..apples_collected, 100, 30)

end


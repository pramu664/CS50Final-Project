if arg[2] == "debug" then
    require("lldebugger").start()
end


function love.load()
    Object = require "libraries.classic"
    player = require "player"
    gold = require "gold"

    love.graphics.setDefaultFilter("nearest", "nearest")
    player = Player()

    gold = {}
    for i=1,5 do
        table.insert(gold, Gold())
    end

    -- TILE  SET SLICING --

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
    for i=0,2 do
        for j=0,3 do
            -- j for x, i for y
            table.insert(quads, love.graphics.newQuad(1 + j * (tile_width + 2), 1 + i * (tile_height + 2), tile_width, tile_height, tileset_width, tileset_height ))
        end
    end

    -- LEVEL --
    tilemap = {
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    }

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
    return player_right > target_left and  player_left < target_right and  player_bottom > target_top and  player_top < target_bottom 

end

function love.update(dt)
    player:update(dt)

    -- Remove gold chunks
    for i=#gold, 1, -1 do
       if checkCollision(player, gold[i]) then
        table.remove(gold, i)
       end 
    end

end

function love.draw()
    -- Draw level
    for i, row in ipairs(tilemap) do
        for j, tile in ipairs(row) do
            if tile ~= 0 then
                love.graphics.draw(tileset ,quads[tile], j * tile_width * 4, i * tile_height * 4, 0,4, 4)
            end
        end
    end
    -- Draw gold chunks
    for i, v in ipairs(gold)  do
        v:draw()
    end
    -- Draw player
    player:draw()


end

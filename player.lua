Player = Object:extend()

function Player:new()
    -- Player controller

    self.state = "idle"

    self.x = 200
    self.y = 300

    self.size = 4
    self.player_speed = 200
    self.width = 16 * self.size
    self.height = 32 * self.size


    -- Animation controller

    self.idle_frames = {}
    self.player_walk_east_frames = {}
    self.player_walk_west_frames = {}
    self.player_walk_north_frames = {}
    self.player_walk_south_frames = {}

    table.insert(self.idle_frames, love.graphics.newImage("assets/sprites/player_idle2.png"))
    table.insert(self.idle_frames, love.graphics.newImage("assets/sprites/player_idle1.png"))

    table.insert(self.player_walk_east_frames, love.graphics.newImage("assets/sprites/player_walk_east1.png"))
    table.insert(self.player_walk_east_frames, love.graphics.newImage("assets/sprites/player_walk_east2.png"))
    table.insert(self.player_walk_east_frames, love.graphics.newImage("assets/sprites/player_walk_east3.png"))
    table.insert(self.player_walk_east_frames, love.graphics.newImage("assets/sprites/player_walk_east4.png"))


    table.insert(self.player_walk_west_frames, love.graphics.newImage("assets/sprites/player_walk_west1.png"))
    table.insert(self.player_walk_west_frames, love.graphics.newImage("assets/sprites/player_walk_west2.png"))
    table.insert(self.player_walk_west_frames, love.graphics.newImage("assets/sprites/player_walk_west3.png"))
    table.insert(self.player_walk_west_frames, love.graphics.newImage("assets/sprites/player_walk_west4.png"))


    table.insert(self.player_walk_north_frames, love.graphics.newImage("assets/sprites/player_walk_north1.png"))
    table.insert(self.player_walk_north_frames, love.graphics.newImage("assets/sprites/player_walk_north2.png"))

    table.insert(self.player_walk_south_frames, love.graphics.newImage("assets/sprites/player_walk_south1.png"))
    table.insert(self.player_walk_south_frames, love.graphics.newImage("assets/sprites/player_walk_south2.png"))

    self.idle_frame = 1
    self.player_walk_east_frame = 1
    self.player_walk_west_frame = 1
    self.player_walk_north_frame = 1
    self.player_walk_south_frame = 1


end

function Player:update(dt)

   if love.keyboard.isDown("d") then
        self.state = "east"
        self.x = self.x + dt * self.player_speed
        self.player_walk_east_frame = self.player_walk_east_frame + dt * 5
        if self.player_walk_east_frame >= 5 then
            self.player_walk_east_frame = 1
        end
    elseif love.keyboard.isDown("a") then
        self.state = "west"
        self.x = self.x - dt * self.player_speed
        self.player_walk_west_frame = self.player_walk_west_frame + dt * 5
        if self.player_walk_west_frame >= 5 then
            self.player_walk_west_frame = 1
        end
    elseif love.keyboard.isDown("w") then
        self.state = "north"
        self.y = self.y - dt * self.player_speed
        self.player_walk_north_frame = self.player_walk_north_frame + dt * 5
        if self.player_walk_north_frame >= 3 then
            self.player_walk_north_frame = 1
        end
    elseif love.keyboard.isDown("s") then
        self.state = "south"
        self.y = self.y + dt * self.player_speed
        self.player_walk_south_frame = self.player_walk_south_frame + dt * 5
        if self.player_walk_south_frame >= 3 then
            self.player_walk_south_frame = 1
        end
    else
        self.state = "idle"
        self.idle_frame = self.idle_frame + dt 
        if self.idle_frame >= 3 then
            self.idle_frame = 1
        end
    end

    -- Boundary
    if self.x - self.width < 0 then
        self.x = self.width

    elseif self.x + self.width * 2 > love.graphics.getWidth() then
        self.x = love.graphics.getWidth() - self.width * 2

    elseif self.y < 0 then
        self.y = 0

    elseif self.y + self.height > love.graphics.getHeight() - self.width/2 then
        self.y = love.graphics.getHeight() - self.height - self.width/2
    end
end


function Player:draw()
    -- love.graphics.print("Idle frame "..math.floor(self.idle_frame), 10, 10)
    -- love.graphics.print("Player walk east "..math.floor(self.player_walk_east_frame), 10, 30)
    -- love.graphics.print("Player walk west "..math.floor(self.player_walk_west_frame), 10, 50)

    if self.state == "east" then
        love.graphics.draw(self.player_walk_east_frames[math.floor(self.player_walk_east_frame)], self.x, self.y, 0, self.size, self.size)
    elseif self.state == "west" then
        love.graphics.draw(self.player_walk_west_frames[math.floor(self.player_walk_west_frame)], self.x, self.y, 0, self.size, self.size)
    elseif self.state == "idle" then
        love.graphics.draw(self.idle_frames[math.floor(self.idle_frame)], self.x, self.y, 0, self.size, self.size)
    elseif self.state == "north" then
        love.graphics.draw(self.player_walk_north_frames[math.floor(self.player_walk_north_frame)], self.x, self.y, 0, self.size, self.size)
    elseif self.state == "south" then
        love.graphics.draw(self.player_walk_south_frames[math.floor(self.player_walk_south_frame)], self.x, self.y, 0, self.size, self.size)
    end
end

Gold = Object:extend()

function Gold:new()
    self.image = love.graphics.newImage("assets/world/gold1.png")
    self.x = love.math.random(100, 600)
    self.y = love.math.random(100, 300)
    self.size = love.math.random(3, 4)
    self.width = self.image:getWidth() * self.size
    self.height =  self.image:getHeight() * self.size
end

function Gold:draw()
    love.graphics.draw(self.image, self.x, self.y, 0, self.size, self.size)
end

Apple = Object:extend()

function Apple:new()
    self.image = love.graphics.newImage("assets/world/apple.png")
    self.x = love.math.random(100, 600)
    self.y = love.math.random(100, 300)
    self.size = 3
    self.width = self.image:getWidth() * self.size
    self.height =  self.image:getHeight() * self.size
end

function Apple:draw()
    love.graphics.draw(self.image, self.x, self.y, 0, self.size, self.size)
end

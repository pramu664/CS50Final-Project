Apple = Object:extend()

function Apple:new()
    self.image = love.graphics.newImage("assets/world/apple.png")
    self.x = love.math.random(15, 800)
    self.y = love.math.random(40, 600)
    self.size = 2
    self.width = self.image:getWidth() * self.size
    self.height =  self.image:getHeight() * self.size
end

function Apple:draw()
    love.graphics.draw(self.image, self.x, self.y, 0, self.size, self.size)
end

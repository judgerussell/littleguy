Cursor = GameObject:extend()

function Cursor:new(area, x, y, opts)
    Cursor.super.new(self, area, x, y, opts)
    self.area = area
    self.collider = self.area.collider:point(x, y, "Cursor")
    self.selected = nil
    self.timer:every(.1, function () 
        self.prevX = self.x
        self.prevY = self.y 
    end)
    self.depth = 100
    if opts.sprite then self.sprite = opts.sprite end
end

function Cursor:update(dt)
    Cursor.super.update(self, dt)
    self.x, self.y = love.mouse:getPosition()
    self.x = self.x/scale
    self.y = self.y/scale
    self.collider:moveTo(self.x, self.y)
end

function Cursor:draw()
    love.graphics.points(self.x, self.y)
    if self.sprite then love.graphics.draw(self.sprite, self.x - self.sprite:getWidth() / 2, self.y - 20) end
end